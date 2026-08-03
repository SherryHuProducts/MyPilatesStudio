create table organization.studios (
  id uuid primary key default gen_random_uuid(),
  code text not null,
  name text not null,
  status text not null,
  default_language text not null,
  timezone text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  archived_at timestamptz,
  constraint studios_code_key unique (code),
  constraint studios_status_check
    check (status in ('active', 'inactive', 'archived'))
);

comment on table organization.studios is
  'Studios and organizations that own instructors, students, and teaching records.';
comment on column organization.studios.code is
  'Stable, unique human-readable identifier for the studio.';
comment on column organization.studios.default_language is
  'Default language code used by the studio.';
comment on column organization.studios.timezone is
  'IANA timezone name used for studio-local dates and times.';
comment on column organization.studios.archived_at is
  'Timestamp when the studio was archived; historical records remain available.';

create trigger set_studios_updated_at
before update on organization.studios
for each row
execute function public.set_updated_at();

create table organization.instructors (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  display_name text not null,
  legal_name text,
  email text,
  preferred_language text,
  bio text,
  status text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  archived_at timestamptz,
  constraint instructors_user_id_key unique (user_id),
  constraint instructors_user_id_fkey
    foreign key (user_id) references auth.users (id) on delete restrict,
  constraint instructors_status_check
    check (status in ('active', 'inactive', 'archived'))
);

comment on table organization.instructors is
  'Professional instructor profiles linked optionally to Supabase Auth users.';
comment on column organization.instructors.user_id is
  'Optional unique link to the instructor Supabase Auth account.';
comment on column organization.instructors.legal_name is
  'Private legal name, distinct from the instructor display name.';
comment on column organization.instructors.archived_at is
  'Timestamp when the instructor was archived; historical records remain available.';

create trigger set_instructors_updated_at
before update on organization.instructors
for each row
execute function public.set_updated_at();

create table organization.studio_instructors (
  id uuid primary key default gen_random_uuid(),
  studio_id uuid not null,
  instructor_id uuid not null,
  role_id uuid,
  status text not null,
  joined_at timestamptz not null default now(),
  left_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint studio_instructors_studio_id_instructor_id_key
    unique (studio_id, instructor_id),
  constraint studio_instructors_studio_id_fkey
    foreign key (studio_id)
    references organization.studios (id)
    on delete restrict,
  constraint studio_instructors_instructor_id_fkey
    foreign key (instructor_id)
    references organization.instructors (id)
    on delete restrict,
  constraint studio_instructors_status_check
    check (status in ('active', 'inactive', 'archived')),
  constraint studio_instructors_dates_check
    check (left_at is null or left_at >= joined_at)
);

comment on table organization.studio_instructors is
  'Studio membership records connecting studios and instructors.';
comment on column organization.studio_instructors.role_id is
  'Reserved nullable role identifier; no foreign key exists until role tables are created.';
comment on column organization.studio_instructors.joined_at is
  'Timestamp when the instructor joined the studio.';
comment on column organization.studio_instructors.left_at is
  'Timestamp when the instructor left the studio, when applicable.';

create index studio_instructors_studio_id_idx
  on organization.studio_instructors (studio_id);

create index studio_instructors_instructor_id_idx
  on organization.studio_instructors (instructor_id);

create trigger set_studio_instructors_updated_at
before update on organization.studio_instructors
for each row
execute function public.set_updated_at();
