create table knowledge.methodologies (
  id uuid primary key default gen_random_uuid(),
  code text not null,
  name text not null,
  description text,
  status text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  archived_at timestamptz,
  constraint methodologies_code_key unique (code),
  constraint methodologies_status_check
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

comment on table knowledge.methodologies is
  'Canonical Pilates methodologies that own curricula and teaching frameworks.';
comment on column knowledge.methodologies.code is
  'Stable, unique human-readable identifier for the methodology.';
comment on column knowledge.methodologies.status is
  'Controlled knowledge lifecycle status.';
comment on column knowledge.methodologies.archived_at is
  'Timestamp when the methodology was archived; historical references remain valid.';

create trigger set_methodologies_updated_at
before update on knowledge.methodologies
for each row
execute function public.set_updated_at();

create table knowledge.curricula (
  id uuid primary key default gen_random_uuid(),
  methodology_id uuid not null,
  code text not null,
  name text not null,
  description text,
  status text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  archived_at timestamptz,
  constraint curricula_methodology_id_code_key
    unique (methodology_id, code),
  constraint curricula_methodology_id_fkey
    foreign key (methodology_id)
    references knowledge.methodologies (id)
    on delete restrict,
  constraint curricula_status_check
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

comment on table knowledge.curricula is
  'Curricula defined by a Pilates methodology.';
comment on column knowledge.curricula.methodology_id is
  'Methodology that owns the curriculum.';
comment on column knowledge.curricula.code is
  'Stable human-readable identifier unique within the methodology.';
comment on column knowledge.curricula.status is
  'Controlled knowledge lifecycle status.';

create index curricula_methodology_id_idx
  on knowledge.curricula (methodology_id);

create trigger set_curricula_updated_at
before update on knowledge.curricula
for each row
execute function public.set_updated_at();

create table knowledge.curriculum_levels (
  id uuid primary key default gen_random_uuid(),
  curriculum_id uuid not null,
  code text not null,
  name text not null,
  sequence_order integer not null,
  description text,
  status text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  archived_at timestamptz,
  constraint curriculum_levels_curriculum_id_code_key
    unique (curriculum_id, code),
  constraint curriculum_levels_curriculum_id_fkey
    foreign key (curriculum_id)
    references knowledge.curricula (id)
    on delete restrict,
  constraint curriculum_levels_sequence_order_check
    check (sequence_order >= 0),
  constraint curriculum_levels_status_check
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

comment on table knowledge.curriculum_levels is
  'Ordered levels belonging to a curriculum.';
comment on column knowledge.curriculum_levels.curriculum_id is
  'Curriculum that owns the level.';
comment on column knowledge.curriculum_levels.code is
  'Stable human-readable identifier unique within the curriculum.';
comment on column knowledge.curriculum_levels.sequence_order is
  'Non-negative display and teaching order within the curriculum.';

create index curriculum_levels_curriculum_id_idx
  on knowledge.curriculum_levels (curriculum_id);

create trigger set_curriculum_levels_updated_at
before update on knowledge.curriculum_levels
for each row
execute function public.set_updated_at();

create table knowledge.teaching_frameworks (
  id uuid primary key default gen_random_uuid(),
  methodology_id uuid not null,
  code text not null,
  name text not null,
  description text,
  status text not null,
  version_number integer not null default 1,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  published_at timestamptz,
  archived_at timestamptz,
  constraint teaching_frameworks_methodology_id_code_key
    unique (methodology_id, code),
  constraint teaching_frameworks_methodology_id_fkey
    foreign key (methodology_id)
    references knowledge.methodologies (id)
    on delete restrict,
  constraint teaching_frameworks_version_number_check
    check (version_number > 0),
  constraint teaching_frameworks_status_check
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

comment on table knowledge.teaching_frameworks is
  'Versioned teaching frameworks defined by a Pilates methodology.';
comment on column knowledge.teaching_frameworks.methodology_id is
  'Methodology that owns the teaching framework.';
comment on column knowledge.teaching_frameworks.code is
  'Stable human-readable identifier unique within the methodology.';
comment on column knowledge.teaching_frameworks.version_number is
  'Positive version number for the current framework record.';
comment on column knowledge.teaching_frameworks.published_at is
  'Timestamp when this framework version was published.';

create index teaching_frameworks_methodology_id_idx
  on knowledge.teaching_frameworks (methodology_id);

create trigger set_teaching_frameworks_updated_at
before update on knowledge.teaching_frameworks
for each row
execute function public.set_updated_at();

create table knowledge.teaching_principles (
  id uuid primary key default gen_random_uuid(),
  teaching_framework_id uuid not null,
  code text not null,
  name text not null,
  description text,
  sequence_order integer not null,
  status text not null,
  version_number integer not null default 1,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  published_at timestamptz,
  archived_at timestamptz,
  constraint teaching_principles_teaching_framework_id_code_key
    unique (teaching_framework_id, code),
  constraint teaching_principles_teaching_framework_id_fkey
    foreign key (teaching_framework_id)
    references knowledge.teaching_frameworks (id)
    on delete restrict,
  constraint teaching_principles_sequence_order_check
    check (sequence_order >= 0),
  constraint teaching_principles_version_number_check
    check (version_number > 0),
  constraint teaching_principles_status_check
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

comment on table knowledge.teaching_principles is
  'Ordered, versioned principles belonging to a teaching framework.';
comment on column knowledge.teaching_principles.teaching_framework_id is
  'Teaching framework that owns the principle.';
comment on column knowledge.teaching_principles.code is
  'Stable human-readable identifier unique within the teaching framework.';
comment on column knowledge.teaching_principles.sequence_order is
  'Non-negative order of the principle within its teaching framework.';
comment on column knowledge.teaching_principles.version_number is
  'Positive version number for the current teaching-principle record.';
comment on column knowledge.teaching_principles.published_at is
  'Timestamp when this teaching-principle version was published.';

create index teaching_principles_teaching_framework_id_idx
  on knowledge.teaching_principles (teaching_framework_id);

create trigger set_teaching_principles_updated_at
before update on knowledge.teaching_principles
for each row
execute function public.set_updated_at();
