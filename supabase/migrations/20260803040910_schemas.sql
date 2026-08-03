create schema if not exists organization;
comment on schema organization is
  'Studio, location, instructor, and organizational membership data.';

create schema if not exists knowledge;
comment on schema knowledge is
  'Canonical Pilates knowledge and its governed relationships.';

create schema if not exists student;
comment on schema student is
  'Private student profiles, goals, preferences, health context, and consent data.';

create schema if not exists assessment;
comment on schema assessment is
  'Assessment frameworks, templates, observations, findings, and student assessment records.';

create schema if not exists teaching;
comment on schema teaching is
  'Lesson plans, completed teaching records, SOAP notes, home programs, and progress data.';

create schema if not exists ai;
comment on schema ai is
  'AI request, execution, recommendation, evidence, explanation, and review history.';

create schema if not exists system;
comment on schema system is
  'Platform-level authorization, translation, taxonomy, media, and audit support.';

create schema if not exists analytics;
comment on schema analytics is
  'Rebuildable reporting data, derived metrics, and materialized analytics views.';
