alter table knowledge.movement_phases
  add constraint movement_phases_id_movement_variant_id_key
  unique (id, movement_variant_id);

create table knowledge.equipment (
  id uuid primary key default gen_random_uuid(),
  code text not null,
  name text not null,
  equipment_category text not null,
  manufacturer_neutral_description text,
  status text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  archived_at timestamptz,
  constraint equipment_code_key unique (code),
  constraint equipment_status_check
    check (
      status in (
        'draft',
        'in_review',
        'approved',
        'published',
        'deprecated',
        'archived'
      )
    )
);

comment on table knowledge.equipment is
  'Canonical equipment types used by movement variants.';
comment on column knowledge.equipment.code is
  'Stable, unique human-readable identifier for the equipment type.';
comment on column knowledge.equipment.equipment_category is
  'Classification of the equipment type.';
comment on column knowledge.equipment.manufacturer_neutral_description is
  'Equipment description that does not depend on a specific manufacturer.';

create trigger set_equipment_updated_at
before update on knowledge.equipment
for each row
execute function public.set_updated_at();

create table knowledge.movement_equipment (
  id uuid primary key default gen_random_uuid(),
  movement_variant_id uuid not null,
  equipment_id uuid not null,
  requirement_type text not null,
  quantity integer,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint movement_equipment_variant_equipment_requirement_key
    unique (movement_variant_id, equipment_id, requirement_type),
  constraint movement_equipment_movement_variant_id_fkey
    foreign key (movement_variant_id)
    references knowledge.movement_variants (id)
    on delete restrict,
  constraint movement_equipment_equipment_id_fkey
    foreign key (equipment_id)
    references knowledge.equipment (id)
    on delete restrict,
  constraint movement_equipment_requirement_type_check
    check (
      requirement_type in (
        'primary',
        'required',
        'optional',
        'supportive',
        'alternative'
      )
    ),
  constraint movement_equipment_quantity_check
    check (quantity is null or quantity > 0)
);

comment on table knowledge.movement_equipment is
  'Equipment requirements associated with movement variants.';
comment on column knowledge.movement_equipment.requirement_type is
  'Controlled relationship type describing how the equipment is used.';
comment on column knowledge.movement_equipment.quantity is
  'Optional positive quantity of the equipment required.';

create index movement_equipment_movement_variant_id_idx
  on knowledge.movement_equipment (movement_variant_id);

create index movement_equipment_equipment_id_idx
  on knowledge.movement_equipment (equipment_id);

create trigger set_movement_equipment_updated_at
before update on knowledge.movement_equipment
for each row
execute function public.set_updated_at();

create table knowledge.equipment_configurations (
  id uuid primary key default gen_random_uuid(),
  movement_variant_id uuid not null,
  equipment_id uuid not null,
  manufacturer text,
  equipment_model text,
  spring_setting text,
  footbar_position text,
  headrest_position text,
  strap_setting text,
  box_position text,
  additional_setup text,
  is_default boolean not null default false,
  status text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint equipment_configurations_movement_variant_id_fkey
    foreign key (movement_variant_id)
    references knowledge.movement_variants (id)
    on delete restrict,
  constraint equipment_configurations_equipment_id_fkey
    foreign key (equipment_id)
    references knowledge.equipment (id)
    on delete restrict,
  constraint equipment_configurations_status_check
    check (
      status in (
        'draft',
        'in_review',
        'approved',
        'published',
        'deprecated',
        'archived'
      )
    )
);

comment on table knowledge.equipment_configurations is
  'Movement-specific equipment setups, including manufacturer-specific values.';
comment on column knowledge.equipment_configurations.spring_setting is
  'Manufacturer-dependent spring or resistance setting retained as text.';
comment on column knowledge.equipment_configurations.is_default is
  'Whether this is the default configuration for its movement and equipment.';
comment on column knowledge.equipment_configurations.additional_setup is
  'Additional setup instructions not represented by dedicated fields.';

create index equipment_configurations_movement_variant_id_idx
  on knowledge.equipment_configurations (movement_variant_id);

create index equipment_configurations_equipment_id_idx
  on knowledge.equipment_configurations (equipment_id);

create trigger set_equipment_configurations_updated_at
before update on knowledge.equipment_configurations
for each row
execute function public.set_updated_at();

create table knowledge.cues (
  id uuid primary key default gen_random_uuid(),
  methodology_id uuid,
  code text not null,
  canonical_text text not null,
  cue_type text not null,
  teaching_intent text not null,
  status text not null,
  version_number integer not null default 1,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  published_at timestamptz,
  archived_at timestamptz,
  constraint cues_methodology_id_code_key unique (methodology_id, code),
  constraint cues_methodology_id_fkey
    foreign key (methodology_id)
    references knowledge.methodologies (id)
    on delete restrict,
  constraint cues_version_number_check check (version_number > 0),
  constraint cues_status_check
    check (
      status in (
        'draft',
        'in_review',
        'approved',
        'published',
        'deprecated',
        'archived'
      )
    )
);

comment on table knowledge.cues is
  'Reusable teaching instructions that may be universal or methodology-specific.';
comment on column knowledge.cues.methodology_id is
  'Optional methodology scope; null identifies a universal internal cue.';
comment on column knowledge.cues.canonical_text is
  'Canonical source-language text of the cue.';
comment on column knowledge.cues.version_number is
  'Positive version number for the current cue record.';

create index cues_methodology_id_idx
  on knowledge.cues (methodology_id);

create trigger set_cues_updated_at
before update on knowledge.cues
for each row
execute function public.set_updated_at();

create table knowledge.movement_cues (
  id uuid primary key default gen_random_uuid(),
  movement_variant_id uuid not null,
  cue_id uuid not null,
  movement_phase_id uuid,
  priority integer,
  application_type text not null,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint movement_cues_movement_variant_id_fkey
    foreign key (movement_variant_id)
    references knowledge.movement_variants (id)
    on delete restrict,
  constraint movement_cues_cue_id_fkey
    foreign key (cue_id)
    references knowledge.cues (id)
    on delete restrict,
  constraint movement_cues_movement_phase_fkey
    foreign key (movement_phase_id, movement_variant_id)
    references knowledge.movement_phases (id, movement_variant_id)
    on delete restrict,
  constraint movement_cues_priority_check
    check (priority is null or priority >= 0)
);

comment on table knowledge.movement_cues is
  'Reusable cues applied to movement variants and optional movement phases.';
comment on column knowledge.movement_cues.movement_phase_id is
  'Optional phase within the same movement variant; enforced by a composite foreign key.';
comment on column knowledge.movement_cues.priority is
  'Optional non-negative cue priority for this movement application.';
comment on column knowledge.movement_cues.application_type is
  'Context in which the cue is applied to the movement.';

create index movement_cues_movement_variant_id_idx
  on knowledge.movement_cues (movement_variant_id);

create index movement_cues_cue_id_idx
  on knowledge.movement_cues (cue_id);

create index movement_cues_movement_phase_id_idx
  on knowledge.movement_cues (movement_phase_id);

create trigger set_movement_cues_updated_at
before update on knowledge.movement_cues
for each row
execute function public.set_updated_at();

create table knowledge.movement_principles (
  id uuid primary key default gen_random_uuid(),
  movement_variant_id uuid not null,
  teaching_principle_id uuid not null,
  relevance_type text not null,
  priority integer,
  rationale text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint movement_principles_variant_principle_relevance_key
    unique (movement_variant_id, teaching_principle_id, relevance_type),
  constraint movement_principles_movement_variant_id_fkey
    foreign key (movement_variant_id)
    references knowledge.movement_variants (id)
    on delete restrict,
  constraint movement_principles_teaching_principle_id_fkey
    foreign key (teaching_principle_id)
    references knowledge.teaching_principles (id)
    on delete restrict,
  constraint movement_principles_relevance_type_check
    check (
      relevance_type in (
        'primary',
        'secondary',
        'setup',
        'execution',
        'correction',
        'safety'
      )
    ),
  constraint movement_principles_priority_check
    check (priority is null or priority >= 0)
);

comment on table knowledge.movement_principles is
  'Teaching principles associated with movement variants.';
comment on column knowledge.movement_principles.relevance_type is
  'Controlled context in which the teaching principle applies.';
comment on column knowledge.movement_principles.priority is
  'Optional non-negative priority within the relationship.';
comment on column knowledge.movement_principles.rationale is
  'Explanation of why the teaching principle applies to the movement.';

create index movement_principles_movement_variant_id_idx
  on knowledge.movement_principles (movement_variant_id);

create index movement_principles_teaching_principle_id_idx
  on knowledge.movement_principles (teaching_principle_id);

create trigger set_movement_principles_updated_at
before update on knowledge.movement_principles
for each row
execute function public.set_updated_at();
