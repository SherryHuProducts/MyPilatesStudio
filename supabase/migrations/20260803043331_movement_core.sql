alter table knowledge.curriculum_levels
  add constraint curriculum_levels_id_curriculum_id_key
  unique (id, curriculum_id);

create table knowledge.movement_concepts (
  id uuid primary key default gen_random_uuid(),
  code text not null,
  canonical_name text not null,
  description text,
  status text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  archived_at timestamptz,
  constraint movement_concepts_code_key unique (code),
  constraint movement_concepts_status_check
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

comment on table knowledge.movement_concepts is
  'Methodology-independent canonical identities for movements.';
comment on column knowledge.movement_concepts.code is
  'Stable, unique human-readable identifier for the movement concept.';
comment on column knowledge.movement_concepts.canonical_name is
  'Methodology-independent canonical movement name.';
comment on column knowledge.movement_concepts.status is
  'Controlled knowledge lifecycle status.';

create trigger set_movement_concepts_updated_at
before update on knowledge.movement_concepts
for each row
execute function public.set_updated_at();

create table knowledge.movement_variants (
  id uuid primary key default gen_random_uuid(),
  movement_concept_id uuid not null,
  methodology_id uuid not null,
  code text not null,
  canonical_name text not null,
  short_description text,
  setup_summary text,
  execution_summary text,
  breathing_summary text,
  difficulty_level integer,
  status text not null,
  version_number integer not null default 1,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  approved_at timestamptz,
  published_at timestamptz,
  archived_at timestamptz,
  constraint movement_variants_methodology_id_code_key
    unique (methodology_id, code),
  constraint movement_variants_movement_concept_id_fkey
    foreign key (movement_concept_id)
    references knowledge.movement_concepts (id)
    on delete restrict,
  constraint movement_variants_methodology_id_fkey
    foreign key (methodology_id)
    references knowledge.methodologies (id)
    on delete restrict,
  constraint movement_variants_difficulty_level_check
    check (difficulty_level is null or difficulty_level between 1 and 5),
  constraint movement_variants_version_number_check
    check (version_number > 0),
  constraint movement_variants_status_check
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

comment on table knowledge.movement_variants is
  'Methodology-specific, teachable implementations of movement concepts.';
comment on column knowledge.movement_variants.movement_concept_id is
  'Methodology-independent movement concept represented by this variant.';
comment on column knowledge.movement_variants.methodology_id is
  'Methodology that defines this movement variant.';
comment on column knowledge.movement_variants.code is
  'Stable human-readable identifier unique within the methodology.';
comment on column knowledge.movement_variants.difficulty_level is
  'Optional normalized difficulty from 1 through 5.';
comment on column knowledge.movement_variants.version_number is
  'Positive version number for the current movement-variant record.';

create index movement_variants_movement_concept_id_idx
  on knowledge.movement_variants (movement_concept_id);

create index movement_variants_methodology_id_idx
  on knowledge.movement_variants (methodology_id);

create trigger set_movement_variants_updated_at
before update on knowledge.movement_variants
for each row
execute function public.set_updated_at();

create table knowledge.movement_phases (
  id uuid primary key default gen_random_uuid(),
  movement_variant_id uuid not null,
  phase_type text not null,
  name text not null,
  sequence_order integer not null,
  instruction text not null,
  breathing_instruction text,
  observation_notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint movement_phases_movement_variant_id_sequence_order_key
    unique (movement_variant_id, sequence_order),
  constraint movement_phases_movement_variant_id_fkey
    foreign key (movement_variant_id)
    references knowledge.movement_variants (id)
    on delete restrict,
  constraint movement_phases_sequence_order_check
    check (sequence_order >= 0)
);

comment on table knowledge.movement_phases is
  'Ordered instructional phases belonging to a movement variant.';
comment on column knowledge.movement_phases.movement_variant_id is
  'Movement variant that owns the phase.';
comment on column knowledge.movement_phases.phase_type is
  'Instructional role of the movement phase.';
comment on column knowledge.movement_phases.sequence_order is
  'Non-negative phase order within the movement variant.';

create index movement_phases_movement_variant_id_idx
  on knowledge.movement_phases (movement_variant_id);

create trigger set_movement_phases_updated_at
before update on knowledge.movement_phases
for each row
execute function public.set_updated_at();

create table knowledge.curriculum_movements (
  id uuid primary key default gen_random_uuid(),
  curriculum_id uuid not null,
  curriculum_level_id uuid not null,
  movement_variant_id uuid not null,
  sequence_group text,
  sequence_order integer,
  required_status text not null,
  curriculum_notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint curriculum_movements_curriculum_id_movement_variant_id_key
    unique (curriculum_id, movement_variant_id),
  constraint curriculum_movements_curriculum_id_fkey
    foreign key (curriculum_id)
    references knowledge.curricula (id)
    on delete restrict,
  constraint curriculum_movements_curriculum_level_fkey
    foreign key (curriculum_level_id, curriculum_id)
    references knowledge.curriculum_levels (id, curriculum_id)
    on delete restrict,
  constraint curriculum_movements_movement_variant_id_fkey
    foreign key (movement_variant_id)
    references knowledge.movement_variants (id)
    on delete restrict,
  constraint curriculum_movements_sequence_order_check
    check (sequence_order is null or sequence_order >= 0)
);

comment on table knowledge.curriculum_movements is
  'Curriculum membership, level placement, and ordering for movement variants.';
comment on column knowledge.curriculum_movements.curriculum_id is
  'Curriculum containing the movement variant.';
comment on column knowledge.curriculum_movements.curriculum_level_id is
  'Level within the same curriculum; consistency is enforced by a composite foreign key.';
comment on column knowledge.curriculum_movements.movement_variant_id is
  'Movement variant included in the curriculum.';
comment on column knowledge.curriculum_movements.sequence_group is
  'Optional curriculum-specific grouping used for ordering.';
comment on column knowledge.curriculum_movements.sequence_order is
  'Optional non-negative order within the curriculum or sequence group.';
comment on column knowledge.curriculum_movements.required_status is
  'Curriculum-specific requirement classification.';

create index curriculum_movements_curriculum_id_idx
  on knowledge.curriculum_movements (curriculum_id);

create index curriculum_movements_curriculum_level_id_idx
  on knowledge.curriculum_movements (curriculum_level_id);

create index curriculum_movements_movement_variant_id_idx
  on knowledge.curriculum_movements (movement_variant_id);

create trigger set_curriculum_movements_updated_at
before update on knowledge.curriculum_movements
for each row
execute function public.set_updated_at();
