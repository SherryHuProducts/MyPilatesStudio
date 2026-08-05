# MyPilates AI

# 04 Database Design

**Document ID:** `04_Database`
**Version:** 1.0
**Status:** Draft
**Owner:** Xinlei Hu
**Last Updated:** 2026-08-03
**Target Platform:** Supabase / PostgreSQL

---

# 1. Purpose

This document defines the database architecture for MyPilates AI.

It translates:

* `02_SystemArchitecture.md`
* `03_DomainModel.md`
* `03.5_EntityRelationship.md`

into an implementable relational database design.

This document defines:

* PostgreSQL schema organization
* Table naming conventions
* Primary and foreign key strategy
* Core MVP tables
* Relationship tables
* Versioning rules
* Audit fields
* Archive and deletion behavior
* Indexing strategy
* Row Level Security boundaries
* AI traceability requirements

This document does not contain the complete SQL migration implementation.

SQL files should be generated separately under:

```text
database/
├── migrations/
├── seeds/
├── policies/
├── functions/
└── tests/
```

---

# 2. Database Philosophy

The database must preserve four distinct categories of data:

```text
Professional Knowledge
Student Context
Teaching History
AI Recommendations
```

These categories are related, but they must not be mixed.

Professional Knowledge defines what the system knows.

Student Context defines who is being taught.

Teaching History defines what occurred.

AI Recommendations define what the system suggested.

The database must enforce these distinctions through:

* Separate schemas
* Explicit foreign keys
* Structured relationships
* Versioned knowledge
* Immutable historical references
* Access control

---

# 3. Technology Stack

The initial implementation uses:

```text
Database:
PostgreSQL

Managed Platform:
Supabase

Authentication:
Supabase Auth

File Storage:
Supabase Storage

Authorization:
PostgreSQL Row Level Security

Vector Search:
pgvector

API:
Supabase Data API and application backend

Database Migrations:
SQL migration files tracked in Git
```

PostgreSQL remains the source of truth.

Supabase is the hosting and development platform, not the domain architecture.

---

# 4. PostgreSQL Schema Organization

MyPilates AI should use PostgreSQL schemas to separate business domains.

Recommended schemas:

```text
public
organization
knowledge
student
assessment
teaching
ai
system
analytics
```

---

## 4.1 `public`

The `public` schema should remain minimal.

It may contain:

* Public database functions
* Shared enums when necessary
* Safe public views
* Supabase integration helpers

Business tables should not be placed in `public` by default.

---

## 4.2 `organization`

Stores studio and instructor organization data.

Examples:

```text
organization.studios
organization.studio_locations
organization.instructors
organization.studio_instructors
```

---

## 4.3 `knowledge`

Stores canonical Pilates knowledge.

Examples:

```text
knowledge.methodologies
knowledge.curricula
knowledge.movement_concepts
knowledge.movement_variants
knowledge.cues
knowledge.teaching_principles
knowledge.equipment
knowledge.conditions
knowledge.contraindications
```

This is the central product schema.

---

## 4.4 `student`

Stores student-specific data.

Examples:

```text
student.students
student.student_goals
student.student_preferences
student.student_health_profiles
student.student_conditions
student.consent_records
```

This schema contains sensitive personal information.

---

## 4.5 `assessment`

Stores assessment templates and completed student assessments.

Examples:

```text
assessment.templates
assessment.items
assessment.records
assessment.observations
assessment.findings
```

---

## 4.6 `teaching`

Stores lesson plans and completed teaching records.

Examples:

```text
teaching.lesson_plans
teaching.lesson_blocks
teaching.lesson_exercises
teaching.lesson_records
teaching.exercise_performances
teaching.soap_notes
teaching.home_programs
```

---

## 4.7 `ai`

Stores AI request and recommendation history.

Examples:

```text
ai.recommendation_requests
ai.recommendations
ai.recommendation_items
ai.recommendation_evidence
ai.instructor_decisions
ai.model_executions
```

AI records must never become canonical knowledge automatically.

---

## 4.8 `system`

Stores platform-level entities.

Examples:

```text
system.roles
system.permissions
system.user_roles
system.audit_logs
system.translations
system.taxonomy_terms
system.entity_taxonomies
system.media_assets
```

---

## 4.9 `analytics`

Stores derived metrics and reporting data.

The analytics schema must not become a second source of truth.

Analytics tables may contain:

* Materialized views
* Aggregated lesson statistics
* Knowledge coverage metrics
* Recommendation acceptance rates

Analytics data should be rebuildable from source records.

---

# 5. Naming Conventions

## 5.1 General Naming

Use:

```text
snake_case
lowercase
plural table names
singular column names
```

Correct:

```text
movement_variants
teaching_principles
student_goals
```

Incorrect:

```text
MovementVariant
movementVariant
tbl_movement_variant
```

---

## 5.2 Primary Keys

Every main entity table uses:

```text
id uuid primary key
```

Default:

```sql
gen_random_uuid()
```

Example:

```sql
id uuid primary key default gen_random_uuid()
```

Do not use business names as primary keys.

---

## 5.3 Foreign Keys

Foreign key columns use:

```text
<singular_entity>_id
```

Examples:

```text
methodology_id
curriculum_id
movement_variant_id
student_id
lesson_plan_id
```

---

## 5.4 Timestamps

All mutable tables should normally include:

```text
created_at
updated_at
```

Use:

```text
timestamptz
```

Recommended defaults:

```sql
created_at timestamptz not null default now()
updated_at timestamptz not null default now()
```

Historical or approval workflows may also include:

```text
published_at
approved_at
archived_at
deleted_at
effective_from
effective_to
```

---

## 5.5 User Attribution

Where relevant, include:

```text
created_by
updated_by
approved_by
archived_by
```

These should reference:

```text
auth.users.id
```

or a platform user profile table.

---

## 5.6 Status Fields

Do not use uncontrolled free-text status values.

Prefer:

* PostgreSQL enum
* Controlled lookup table
* Check constraint

Examples:

```text
draft
in_review
approved
published
deprecated
archived
```

---

## 5.7 Codes and Slugs

Entities that need stable human-readable identifiers may include:

```text
code
slug
```

Examples:

```text
methodology code:
stott

curriculum code:
stott_reformer_essential

movement concept code:
footwork

movement variant code:
stott_reformer_essential_footwork_parallel_heels
```

Rules:

* `code` must be stable.
* `slug` may be used in URLs.
* Neither replaces the UUID primary key.

---

# 6. Shared Standard Columns

Most canonical entity tables should include:

```text
id
code
status
created_at
updated_at
created_by
updated_by
archived_at
```

Knowledge tables may additionally include:

```text
version_number
source_status
review_status
published_at
approved_at
approved_by
```

Studio-owned records should include:

```text
studio_id
```

Student historical records should include:

```text
student_id
instructor_id
recorded_at
```

---

# 7. Recommended Shared Enums

The exact implementation may use PostgreSQL enums or lookup tables.

Recommended enums include:

```text
knowledge_status
translation_status
record_status
recommendation_status
instructor_decision_type
relationship_type
requirement_type
severity_level
consent_status
condition_status
lesson_status
assessment_status
source_type
evidence_type
```

Example:

```text
knowledge_status:
draft
in_review
approved
published
deprecated
archived
```

Example:

```text
lesson_status:
draft
planned
approved
in_progress
completed
cancelled
archived
```

Lookup tables are preferred when administrators may need to add values without a migration.

Enums are preferred when values are fundamental and stable.

---

# 8. Organization Schema

## 8.1 `organization.studios`

Represents a studio or organization.

Key columns:

```text
id
name
code
status
default_language
timezone
created_at
updated_at
archived_at
```

Constraints:

* `code` must be unique.
* `timezone` must contain a valid IANA timezone.
* Archived studios remain queryable for historical records.

---

## 8.2 `organization.studio_locations`

Represents a studio location.

Key columns:

```text
id
studio_id
name
address_line_1
address_line_2
city
state_region
postal_code
country_code
timezone
status
created_at
updated_at
```

Relationships:

```text
studios 1:N studio_locations
```

Foreign keys:

```text
studio_id
    → organization.studios.id
```

Delete behavior:

```text
ON DELETE RESTRICT
```

---

## 8.3 `organization.instructors`

Represents the professional instructor profile.

Key columns:

```text
id
user_id
display_name
legal_name
email
preferred_language
bio
status
created_at
updated_at
archived_at
```

Relationships:

```text
auth.users 1:0..1 instructors
```

Constraints:

* `user_id` should be unique when present.
* An archived Instructor remains linked to completed teaching records.

---

## 8.4 `organization.studio_instructors`

Join table between Studios and Instructors.

Key columns:

```text
id
studio_id
instructor_id
role_id
status
joined_at
left_at
created_at
```

Unique constraint:

```text
unique(studio_id, instructor_id)
```

Relationships:

```text
studios N:N instructors
```

---

# 9. Knowledge Governance Tables

## 9.1 `knowledge.methodologies`

Key columns:

```text
id
code
name
description
status
created_at
updated_at
archived_at
```

Examples:

```text
stott
polestar
basi
classical
balanced_body
```

Constraints:

* `code` must be unique.
* Methodology must not be permanently deleted after publication.

---

## 9.2 `knowledge.curricula`

Key columns:

```text
id
methodology_id
code
name
description
status
created_at
updated_at
archived_at
```

Foreign key:

```text
methodology_id
    → knowledge.methodologies.id
```

Unique constraint:

```text
unique(methodology_id, code)
```

---

## 9.3 `knowledge.curriculum_levels`

Key columns:

```text
id
curriculum_id
code
name
sequence_order
description
status
```

Foreign key:

```text
curriculum_id
    → knowledge.curricula.id
```

Unique constraint:

```text
unique(curriculum_id, code)
```

---

## 9.4 `knowledge.knowledge_sources`

Stores source attribution.

Key columns:

```text
id
source_type
title
author
publisher
publication_year
edition
language_code
methodology_id
curriculum_id
rights_status
access_level
citation
notes
created_at
updated_at
```

Rules:

* Do not store copyrighted manuals directly in this table.
* Files should be stored in Supabase Storage.
* File references may be stored through `system.media_assets`.
* Restricted sources require stricter RLS.

---

## 9.5 `knowledge.knowledge_source_references`

Connects sources to knowledge entities.

Key columns:

```text
id
knowledge_source_id
entity_type
entity_id
source_location
relationship_type
notes
created_at
```

Because PostgreSQL cannot enforce a normal foreign key against multiple entity types, the implementation should choose one of two patterns:

### Option A: Polymorphic reference

```text
entity_type
entity_id
```

Advantages:

* Flexible
* Fewer tables

Disadvantages:

* No native target foreign key enforcement

### Option B: Separate source join tables

Examples:

```text
movement_variant_sources
cue_sources
teaching_principle_sources
```

Recommended MVP choice:

Use separate join tables for high-value knowledge entities where referential integrity matters.

Use polymorphic references only for lower-risk metadata relationships.

---

# 10. Teaching Framework Tables

## 10.1 `knowledge.teaching_frameworks`

Key columns:

```text
id
methodology_id
code
name
description
status
version_number
created_at
updated_at
published_at
archived_at
```

Foreign key:

```text
methodology_id
    → knowledge.methodologies.id
```

---

## 10.2 `knowledge.teaching_principles`

Key columns:

```text
id
teaching_framework_id
code
name
description
sequence_order
status
version_number
created_at
updated_at
published_at
archived_at
```

Foreign key:

```text
teaching_framework_id
    → knowledge.teaching_frameworks.id
```

Example records:

```text
breathing
pelvic_placement
rib_cage_placement
scapular_movement_and_stabilization
head_and_cervical_placement
```

---

# 11. Movement Knowledge Tables

## 11.1 `knowledge.movement_concepts`

Represents methodology-independent movement identity.

Key columns:

```text
id
code
canonical_name
description
status
created_at
updated_at
archived_at
```

Constraints:

* `code` must be unique.
* Movement Concept must not contain methodology-specific instructions.

---

## 11.2 `knowledge.movement_variants`

Represents one teachable movement implementation.

Key columns:

```text
id
movement_concept_id
methodology_id
code
canonical_name
short_description
setup_summary
execution_summary
breathing_summary
difficulty_level
status
version_number
created_at
updated_at
approved_at
published_at
archived_at
```

Foreign keys:

```text
movement_concept_id
    → knowledge.movement_concepts.id

methodology_id
    → knowledge.methodologies.id
```

Constraints:

```text
unique(methodology_id, code)
```

Rules:

* A Movement Variant belongs to one Movement Concept.
* Methodology-specific execution belongs here.
* Student modifications must not be stored here.
* Published records should be versioned.

---

## 11.3 `knowledge.movement_phases`

Key columns:

```text
id
movement_variant_id
phase_type
name
sequence_order
instruction
breathing_instruction
observation_notes
created_at
updated_at
```

Foreign key:

```text
movement_variant_id
    → knowledge.movement_variants.id
```

Unique constraint:

```text
unique(movement_variant_id, sequence_order)
```

Delete behavior:

* Cascade may be allowed for unpublished draft variants.
* Published content should be replaced through versioning rather than destructive editing.

---

## 11.4 `knowledge.curriculum_movements`

Join table between Curricula and Movement Variants.

Key columns:

```text
id
curriculum_id
curriculum_level_id
movement_variant_id
sequence_group
sequence_order
required_status
curriculum_notes
created_at
updated_at
```

Foreign keys:

```text
curriculum_id
    → knowledge.curricula.id

curriculum_level_id
    → knowledge.curriculum_levels.id

movement_variant_id
    → knowledge.movement_variants.id
```

Unique constraint:

```text
unique(curriculum_id, movement_variant_id)
```

---

# 12. Equipment Tables

## 12.1 `knowledge.equipment`

Key columns:

```text
id
code
name
equipment_category
manufacturer_neutral_description
status
created_at
updated_at
archived_at
```

Examples:

```text
reformer
mat
cadillac
chair
ladder_barrel
small_ball
resistance_band
```

---

## 12.2 `knowledge.movement_equipment`

Join table.

Key columns:

```text
id
movement_variant_id
equipment_id
requirement_type
quantity
notes
```

Unique constraint:

```text
unique(movement_variant_id, equipment_id, requirement_type)
```

---

## 12.3 `knowledge.equipment_configurations`

Key columns:

```text
id
movement_variant_id
equipment_id
manufacturer
equipment_model
spring_setting
footbar_position
headrest_position
strap_setting
box_position
additional_setup
is_default
status
created_at
updated_at
```

Rules:

* `spring_setting` should initially remain text or structured JSON because manufacturer resistance systems differ.
* A future normalized spring-resistance model may be added.
* Manufacturer-specific settings must not be treated as universal.

---

# 13. Cue and Teaching Detail Tables

## 13.1 `knowledge.cues`

Key columns:

```text
id
code
canonical_text
cue_type
teaching_intent
methodology_id
status
version_number
created_at
updated_at
published_at
archived_at
```

Foreign key:

```text
methodology_id
    → knowledge.methodologies.id
```

Methodology may be nullable for universal internal cues.

---

## 13.2 `knowledge.movement_cues`

Join table.

Key columns:

```text
id
movement_variant_id
cue_id
movement_phase_id
priority
application_type
notes
```

Foreign keys:

```text
movement_variant_id
    → knowledge.movement_variants.id

cue_id
    → knowledge.cues.id

movement_phase_id
    → knowledge.movement_phases.id
```

---

## 13.3 `knowledge.movement_principles`

Join table.

Key columns:

```text
id
movement_variant_id
teaching_principle_id
relevance_type
priority
rationale
```

Unique constraint:

```text
unique(movement_variant_id, teaching_principle_id, relevance_type)
```

---

## 13.4 `knowledge.teaching_focuses`

Key columns:

```text
id
code
name
description
status
```

Examples:

```text
pelvic_stability
knee_tracking
scapular_control
breath_sequencing
movement_quality
```

---

# 14. Anatomy Tables

## 14.1 `knowledge.anatomy`

Initial MVP may use one unified anatomy table.

Key columns:

```text
id
code
name
anatomy_type
parent_id
description
status
```

Possible `anatomy_type` values:

```text
body_region
bone
joint
muscle
muscle_group
connective_tissue
anatomical_landmark
```

Self-reference:

```text
parent_id
    → knowledge.anatomy.id
```

Example:

```text
lower_body
└── hip
    ├── hip_joint
    ├── gluteus_maximus
    └── femur
```

A future version may split anatomy into more specialized tables.

---

## 14.2 `knowledge.movement_anatomy`

Join table.

Key columns:

```text
id
movement_variant_id
anatomy_id
movement_phase_id
relationship_type
priority
notes
```

Possible relationship types:

```text
primary_mover
secondary_mover
stabilizer
joint_action
body_region
load_bearing
movement_focus
```

---

# 15. Goal, Condition, and Safety Tables

## 15.1 `knowledge.training_goals`

Key columns:

```text
id
code
name
description
scope_type
status
```

Rules:

* Goals must not imply medical treatment.
* Examples should use movement and teaching language.

---

## 15.2 `knowledge.movement_goals`

Join table.

Key columns:

```text
id
movement_variant_id
training_goal_id
relevance
priority
rationale
```

---

## 15.3 `knowledge.conditions`

Key columns:

```text
id
code
name
description
condition_category
requires_clearance_default
status
created_at
updated_at
```

Rules:

* Conditions represent teaching context, not diagnosis.
* Student records should identify whether a condition is self-reported or documented.

---

## 15.4 `knowledge.contraindications`

Key columns:

```text
id
code
name
description
restriction_type
severity
rationale
required_action
status
version_number
created_at
updated_at
published_at
archived_at
```

Possible restriction types:

```text
avoid
modify
monitor
require_clearance
refer_out
```

---

## 15.5 `knowledge.condition_contraindications`

Join table.

Key columns:

```text
id
condition_id
contraindication_id
applicable_context
priority
notes
```

---

## 15.6 `knowledge.movement_contraindications`

Join table.

Key columns:

```text
id
movement_variant_id
contraindication_id
severity
restriction_type
modification_guidance
rationale
```

Rules:

* Safety-critical relationships require review and source attribution.
* AI must query this table before recommending movements.

---

# 16. Common Error and Correction Tables

## 16.1 `knowledge.common_errors`

Key columns:

```text
id
code
name
description
observation_type
status
```

---

## 16.2 `knowledge.correction_strategies`

Key columns:

```text
id
code
name
description
strategy_type
status
```

Possible types:

```text
cue_change
range_change
resistance_change
support_change
position_change
regression
reassessment
```

---

## 16.3 `knowledge.movement_common_errors`

Key columns:

```text
id
movement_variant_id
common_error_id
movement_phase_id
priority
observation_notes
```

---

## 16.4 `knowledge.error_corrections`

Key columns:

```text
id
common_error_id
correction_strategy_id
priority
applicable_context
rationale
```

---

# 17. Movement Relationship Table

## 17.1 `knowledge.movement_relationships`

Self-referencing join table between Movement Variants.

Key columns:

```text
id
source_movement_variant_id
target_movement_variant_id
relationship_type
methodology_id
rationale
status
created_at
updated_at
```

Possible relationship types:

```text
progresses_to
regresses_to
prepares_for
alternative_to
similar_to
requires_competency_in
```

Constraints:

```text
source_movement_variant_id != target_movement_variant_id
```

Recommended unique constraint:

```text
unique(
    source_movement_variant_id,
    target_movement_variant_id,
    relationship_type
)
```

---

# 18. Translation Tables

## 18.1 `system.translations`

Initial flexible translation model:

```text
id
entity_type
entity_id
language_code
field_name
translated_text
status
reviewed_by
reviewed_at
created_at
updated_at
```

Example:

```text
entity_type:
movement_variant

entity_id:
<uuid>

language_code:
zh-CN

field_name:
canonical_name

translated_text:
足部训练——脚跟平行
```

Recommended unique constraint:

```text
unique(
    entity_type,
    entity_id,
    language_code,
    field_name
)
```

Limitations:

* Polymorphic foreign keys cannot be enforced natively.
* Application validation and database triggers may be required.

Alternative future design:

Use one translation table per major entity.

MVP recommendation:

Use a shared translation table to reduce schema complexity.

---

# 19. Taxonomy Tables

## 19.1 `system.taxonomy_terms`

Key columns:

```text
id
taxonomy_type
code
name
parent_id
description
status
```

Self-reference:

```text
parent_id
    → system.taxonomy_terms.id
```

---

## 19.2 `system.entity_taxonomies`

Key columns:

```text
id
taxonomy_term_id
entity_type
entity_id
relationship_type
created_at
```

Use for secondary classification only.

Do not use taxonomy to replace important domain relationships such as:

* Curriculum membership
* Contraindications
* Teaching principles
* Movement progression

---

# 20. Student Schema

## 20.1 `student.students`

Key columns:

```text
id
studio_id
external_reference
first_name
last_name
display_name
email
phone
date_of_birth
preferred_language
status
created_at
updated_at
archived_at
```

Foreign key:

```text
studio_id
    → organization.studios.id
```

Privacy rules:

* Date of birth, contact details, and health information require RLS.
* Avoid exposing full student records to knowledge-search services.
* Student data should never be publicly readable.

---

## 20.2 `student.student_goals`

Key columns:

```text
id
student_id
training_goal_id
goal_text
priority
status
start_date
target_date
completed_at
created_at
updated_at
```

Foreign keys:

```text
student_id
    → student.students.id

training_goal_id
    → knowledge.training_goals.id
```

---

## 20.3 `student.student_preferences`

Key columns:

```text
id
student_id
preference_type
preference_value
notes
status
created_at
updated_at
```

Examples:

```text
preferred_cue_style
preferred_language
tactile_cue_preference
exercise_preference
transition_speed
```

Some important preferences may later become dedicated structured columns.

---

## 20.4 `student.student_health_profiles`

Recommended relationship:

```text
students 1:1 student_health_profiles
```

Key columns:

```text
id
student_id
general_notes
current_activity_level
emergency_contact_name
emergency_contact_phone
last_reviewed_at
created_at
updated_at
```

Unique constraint:

```text
unique(student_id)
```

Sensitive details should preferably be normalized into related tables rather than stored in one large text field.

---

## 20.5 `student.student_conditions`

Join table between Student and Condition.

Key columns:

```text
id
student_id
condition_id
status
source_type
onset_date
resolved_date
clearance_status
clearance_date
notes
created_at
updated_at
```

Possible `source_type` values:

```text
self_reported
medical_document
instructor_observed
unknown
```

Rules:

* `instructor_observed` must not imply diagnosis.
* Historical conditions should not be deleted.
* Use active, historical, resolved, or uncertain status.

---

## 20.6 `student.consent_records`

Key columns:

```text
id
student_id
consent_type
terms_version
status
granted_at
revoked_at
expires_at
collection_method
recorded_by
created_at
```

Rules:

* Consent history must be immutable.
* Current consent is derived from the most recent applicable record.
* Do not overwrite a granted record when consent is revoked.

---

## 20.7 `student.student_equipment_access`

Key columns:

```text
id
student_id
equipment_id
location_type
availability_status
manufacturer
equipment_model
notes
created_at
updated_at
```

Useful for home program generation.

---

# 21. Assessment Schema

## 21.1 `assessment.frameworks`

Key columns:

```text
id
methodology_id
code
name
description
status
version_number
```

---

## 21.2 `assessment.templates`

Key columns:

```text
id
assessment_framework_id
code
name
description
applicable_population
status
version_number
created_at
updated_at
published_at
archived_at
```

---

## 21.3 `assessment.items`

Key columns:

```text
id
assessment_template_id
code
item_type
prompt
response_type
sequence_order
is_required
safety_stop_criteria
configuration
created_at
updated_at
```

`configuration` may use `jsonb` for item-specific settings such as:

* Allowed responses
* Numeric range
* Unit
* Side selection
* Conditional display

Rules:

* JSONB may support variable configuration.
* Core searchable concepts must remain relational.

---

## 21.4 `assessment.records`

Key columns:

```text
id
studio_id
student_id
instructor_id
assessment_template_id
template_version_number
status
started_at
completed_at
summary
created_at
updated_at
```

Historical rule:

* Store the template version used.
* Completed Assessment Records should not be destructively edited.

---

## 21.5 `assessment.observations`

Key columns:

```text
id
assessment_record_id
assessment_item_id
observation_type
response_text
response_number
response_boolean
response_json
body_side
confidence_level
observed_at
recorded_by
created_at
updated_at
```

Only one response format should normally be populated per row.

A database check constraint may enforce this later.

---

## 21.6 `assessment.findings`

Key columns:

```text
id
assessment_record_id
finding_type
summary
description
priority
status
approved_by
approved_at
created_at
updated_at
```

Rules:

* AI-suggested findings remain unapproved until reviewed.
* Findings are instructional interpretations, not diagnoses.

---

## 21.7 `assessment.finding_evidence`

Key columns:

```text
id
finding_id
assessment_observation_id
relevance
notes
```

---

## 21.8 `assessment.finding_teaching_focuses`

Key columns:

```text
id
finding_id
teaching_focus_id
priority
rationale
```

---

## 21.9 `assessment.finding_movements`

Key columns:

```text
id
finding_id
movement_variant_id
relationship_type
priority
rationale
```

Possible relationship types:

```text
recommend
consider
monitor
modify
avoid
```

---

# 22. Teaching Schema

## 22.1 `teaching.lesson_plans`

Key columns:

```text
id
studio_id
student_id
instructor_id
methodology_id
curriculum_id
recommendation_id
title
planned_date
planned_duration_minutes
status
overall_goal
teaching_focus_summary
safety_notes
created_at
updated_at
approved_at
archived_at
```

Rules:

* `recommendation_id` is optional.
* AI-generated plans must be reviewed before approval.
* Lesson Plans should not be overwritten by completed session data.

---

## 22.2 `teaching.lesson_blocks`

Key columns:

```text
id
lesson_plan_id
name
block_type
sequence_order
planned_duration_minutes
purpose
notes
created_at
updated_at
```

Unique constraint:

```text
unique(lesson_plan_id, sequence_order)
```

---

## 22.3 `teaching.lesson_exercises`

Key columns:

```text
id
lesson_block_id
movement_variant_id
sequence_order
planned_repetitions
planned_duration_seconds
planned_sets
planned_resistance
planned_range
planned_side
planned_modification
selection_rationale
notes
created_at
updated_at
```

Rules:

* Student-specific parameters belong here.
* Do not modify the referenced Movement Variant.

---

## 22.4 `teaching.lesson_exercise_cues`

Key columns:

```text
id
lesson_exercise_id
cue_id
sequence_order
notes
```

---

## 22.5 `teaching.lesson_exercise_focuses`

Key columns:

```text
id
lesson_exercise_id
teaching_focus_id
priority
notes
```

---

## 22.6 `teaching.lesson_records`

Key columns:

```text
id
studio_id
student_id
instructor_id
lesson_plan_id
status
started_at
completed_at
actual_duration_minutes
session_summary
safety_event_occurred
created_at
updated_at
finalized_at
```

Rules:

* A Lesson Record stores actual teaching.
* It may exist without a Lesson Plan for unplanned sessions.
* Completed records should be append-only except through controlled correction workflows.

---

## 22.7 `teaching.exercise_performances`

Key columns:

```text
id
lesson_record_id
lesson_exercise_id
movement_variant_id
sequence_order
completion_status
actual_repetitions
actual_duration_seconds
actual_sets
actual_resistance
actual_range
actual_side
assistance_level
movement_quality
pain_response
student_response
instructor_observation
created_at
updated_at
```

Rules:

* `lesson_exercise_id` may be null for an exercise added during the session.
* `movement_variant_id` remains required for structured movements.

---

## 22.8 `teaching.performance_cues`

Optional table recording Cues actually used.

Key columns:

```text
id
exercise_performance_id
cue_id
effectiveness_rating
student_response
notes
```

This table can support future cue personalization.

---

## 22.9 `teaching.session_feedback`

Key columns:

```text
id
lesson_record_id
feedback_source
perceived_effort
comfort_rating
pain_rating
confidence_rating
difficulty_rating
comments
recorded_at
created_at
```

Possible feedback sources:

```text
student
instructor
follow_up
```

---

## 22.10 `teaching.soap_notes`

Key columns:

```text
id
studio_id
student_id
instructor_id
lesson_record_id
status
subjective
objective
assessment
plan
ai_generated
approved_by
approved_at
created_at
updated_at
finalized_at
```

Constraints:

```text
unique(lesson_record_id)
```

Rules:

* `ai_generated` only indicates origin of the draft.
* Approval identifies professional responsibility.
* Final notes must not include invented facts.

---

## 22.11 `teaching.home_programs`

Key columns:

```text
id
studio_id
student_id
instructor_id
title
goal
status
start_date
end_date
review_date
frequency_instructions
safety_notes
recommendation_id
approved_at
created_at
updated_at
```

---

## 22.12 `teaching.home_exercises`

Key columns:

```text
id
home_program_id
movement_variant_id
sequence_order
repetitions
duration_seconds
sets
frequency
instructions
selected_cues
safety_limits
stop_conditions
notes
```

`selected_cues` may initially be JSONB, but a normalized join table is preferred if cue analytics are required.

---

## 22.13 `teaching.progress_records`

Key columns:

```text
id
student_id
student_goal_id
assessment_finding_id
movement_variant_id
progress_type
measurement_value
measurement_unit
subjective_summary
objective_summary
recorded_at
recorded_by
created_at
```

Rules:

* At least one source relationship or progress description should exist.
* Subjective and objective progress should remain distinguishable.

---

# 23. AI Schema

## 23.1 `ai.recommendation_requests`

Key columns:

```text
id
studio_id
student_id
instructor_id
request_type
request_text
methodology_id
curriculum_id
constraints
status
created_at
completed_at
```

`constraints` may use JSONB for request-specific values such as:

* Available time
* Available equipment
* Excluded movements
* Required lesson sections

Important stable fields should be normalized if heavily queried.

---

## 23.2 `ai.model_executions`

Key columns:

```text
id
provider
model_name
model_version
prompt_template_version
retrieval_version
started_at
completed_at
status
input_token_count
output_token_count
error_code
error_message
created_at
```

Rules:

* Avoid storing full sensitive prompts unless required.
* Store hashes or redacted versions when possible.
* Provider-specific metadata should not leak into domain tables.

---

## 23.3 `ai.recommendations`

Key columns:

```text
id
recommendation_request_id
model_execution_id
recommendation_type
status
summary
confidence_level
safety_flag
created_at
reviewed_at
```

Foreign keys:

```text
recommendation_request_id
    → ai.recommendation_requests.id

model_execution_id
    → ai.model_executions.id
```

---

## 23.4 `ai.recommendation_items`

Key columns:

```text
id
recommendation_id
item_type
sequence_order
movement_variant_id
cue_id
teaching_focus_id
proposed_action
proposed_parameters
rationale
confidence_level
safety_notes
created_at
```

`proposed_parameters` may use JSONB because different recommendation types require different values.

Examples:

```text
repetitions
duration
resistance
range
modification
lesson_block
```

---

## 23.5 `ai.recommendation_evidence`

Key columns:

```text
id
recommendation_id
recommendation_item_id
evidence_type
evidence_entity_type
evidence_entity_id
knowledge_version_number
relevance
explanation
created_at
```

Rules:

* Evidence must identify the exact source record.
* Evidence must distinguish student context from professional knowledge.
* Historical Recommendations must retain evidence references.

---

## 23.6 `ai.recommendation_explanations`

Key columns:

```text
id
recommendation_id
summary
student_factors
knowledge_factors
safety_factors
excluded_options
uncertainty_notes
created_at
```

Recommended relationship:

```text
recommendations 1:1 recommendation_explanations
```

---

## 23.7 `ai.instructor_decisions`

Key columns:

```text
id
recommendation_id
recommendation_item_id
instructor_id
decision_type
modification_summary
reason
created_at
```

Decision types:

```text
accepted
accepted_with_modification
rejected
deferred
```

Rules:

* Use multiple rows to preserve decision history.
* The latest applicable decision represents current state.

---

# 24. Media Asset Table

## 24.1 `system.media_assets`

Stores metadata for files held in Supabase Storage.

Key columns:

```text
id
studio_id
storage_bucket
storage_path
file_name
mime_type
file_size_bytes
media_type
access_level
checksum
uploaded_by
created_at
archived_at
```

Possible media types:

```text
image
video
document
audio
thumbnail
medical_clearance
knowledge_source
```

Rules:

* File binaries remain in Storage.
* Database stores metadata and ownership.
* Sensitive student files require private buckets and signed URLs.
* Copyright-restricted manuals should never use public buckets.

---

# 25. Versioning Strategy

Knowledge versioning is essential.

Two implementation patterns are available.

## 25.1 In-Place Version Number

The main record includes:

```text
version_number
status
updated_at
```

Advantages:

* Simple

Disadvantages:

* Previous content may be lost
* Historical reconstruction is difficult

This is insufficient for important published knowledge.

---

## 25.2 Main Entity Plus Version Table

Recommended model:

```text
movement_variants
movement_variant_versions
```

Main entity stores stable identity:

```text
id
movement_concept_id
methodology_id
code
current_version_id
status
```

Version table stores content:

```text
id
movement_variant_id
version_number
canonical_name
setup_summary
execution_summary
breathing_summary
change_summary
created_by
approved_by
created_at
approved_at
```

Advantages:

* Full history
* Stable entity ID
* Precise AI evidence
* Historical lesson reconstruction

Recommended entities for full version tables:

```text
movement_variants
cues
teaching_principles
contraindications
assessment_templates
teaching_rules
clinical_rules
```

MVP implementation may begin with version columns, but migration to version tables should occur before large-scale production content is published.

---

# 26. Soft Delete Strategy

Core entities should not use destructive deletion.

Recommended fields:

```text
status
archived_at
archived_by
```

Optional:

```text
deleted_at
```

Rules:

* `deleted_at` should be reserved for privacy or administrative workflows.
* Historical references remain valid.
* Archived knowledge is excluded from default AI retrieval.
* Archived students are excluded from active student lists.
* Completed records should normally never be hard-deleted through the application.

---

# 27. Foreign Key Delete Behavior

Use deliberate delete actions.

## `ON DELETE RESTRICT`

Use when the referenced entity must remain because history depends on it.

Examples:

```text
movement_variants referenced by lesson_exercises
students referenced by lesson_records
instructors referenced by soap_notes
curricula referenced by lesson_plans
```

---

## `ON DELETE CASCADE`

Use only for dependent data with no independent meaning.

Examples:

```text
draft lesson_plan
    → lesson_blocks
    → lesson_exercises
```

```text
recommendation
    → recommendation_items
```

Even where cascade is technically allowed, finalized records may be protected through status rules.

---

## `ON DELETE SET NULL`

Use when an optional relationship may disappear without invalidating history.

Examples may include:

```text
lesson_plan.recommendation_id
student_goal.training_goal_id
```

Use carefully.

---

# 28. Indexing Strategy

All foreign key columns should generally have indexes.

Important indexes include:

```text
movement_variants.methodology_id
movement_variants.movement_concept_id
curriculum_movements.curriculum_id
curriculum_movements.movement_variant_id

students.studio_id
student_conditions.student_id
student_conditions.condition_id

assessment_records.student_id
assessment_records.instructor_id
assessment_records.completed_at

lesson_plans.student_id
lesson_plans.instructor_id
lesson_plans.planned_date

lesson_records.student_id
lesson_records.completed_at

exercise_performances.lesson_record_id
exercise_performances.movement_variant_id

recommendation_requests.student_id
recommendations.recommendation_request_id
recommendation_evidence.evidence_entity_id
```

Partial indexes may be useful:

```sql
where archived_at is null
```

Example:

```text
active students by studio
published movement variants
active curricula
unreviewed recommendations
```

---

# 29. Search and Vector Indexing

## 29.1 Full-Text Search

Searchable knowledge may include:

```text
name
description
setup
execution
cue text
aliases
translations
```

Use PostgreSQL:

```text
tsvector
GIN index
```

English and Chinese may require different tokenization strategies.

---

## 29.2 Vector Search

Use `pgvector` for semantic retrieval.

Recommended table:

```text
knowledge.embeddings
```

Key columns:

```text
id
entity_type
entity_id
entity_version_id
language_code
content_hash
embedding_model
embedding vector
created_at
```

Rules:

* Embeddings are derived data.
* Embeddings may be regenerated.
* Embeddings do not replace canonical text.
* Embedding records must identify entity version and model.
* Archived or deprecated knowledge must be excluded from active retrieval.

---

# 30. JSONB Usage Rules

JSONB is appropriate for:

* Flexible configuration
* AI generation parameters
* Assessment item configuration
* Model execution metadata
* Low-value provider-specific metadata

JSONB should not replace:

* Core entities
* Important relationships
* Safety rules
* Curriculum membership
* Movement progression
* Student conditions
* Contraindications
* Knowledge sources

Rule:

> Use relational columns for information that must be filtered, validated, joined, explained, or governed.

---

# 31. Row Level Security

RLS must be enabled for all studio-owned and student-related tables.

## 31.1 Knowledge Data

Possible access model:

```text
Published shared knowledge:
Readable by authorized platform users

Draft knowledge:
Readable only by editors and reviewers

Restricted source material:
Readable only by explicitly authorized users
```

Knowledge write access should require roles such as:

```text
knowledge_editor
knowledge_reviewer
platform_admin
```

---

## 31.2 Student Data

Users may access student data only when:

* They belong to the Student's Studio.
* Their Role permits Student access.
* Their access has not been revoked.
* Additional assignment rules are satisfied, if enabled.

Example conceptual RLS rule:

```text
current_user belongs to student.studio_id
AND
current_user has student_read permission
```

---

## 31.3 Teaching Records

Only authorized Studio members may access:

* Lesson Plans
* Lesson Records
* SOAP Notes
* Home Programs
* Assessments

SOAP Notes and health data may require stricter permissions than basic Lesson Plans.

---

## 31.4 AI Records

Recommendation records inherit access from:

* Studio
* Student
* Requesting Instructor

Users must not access a Recommendation if they cannot access the related Student.

---

# 32. Audit Logging

Important operations should create Audit Log records.

Recommended table:

```text
system.audit_logs
```

Key columns:

```text
id
studio_id
user_id
action_type
entity_type
entity_id
before_state
after_state
reason
ip_address
user_agent
created_at
```

Audit-worthy actions include:

```text
knowledge published
knowledge deprecated
student health data viewed
student condition modified
assessment finalized
SOAP note finalized
consent revoked
AI recommendation approved
safety rule overridden
record archived
permission changed
```

Sensitive data should be minimized or redacted in `before_state` and `after_state`.

---

# 33. Database Functions and Triggers

Recommended functions and triggers include:

## 33.1 Updated Timestamp

Automatically update:

```text
updated_at
```

---

## 33.2 Audit Trigger

Create audit events for high-risk table changes.

---

## 33.3 Archive Validation

Prevent archived knowledge from being selected for new Lesson Plans.

---

## 33.4 Published Knowledge Protection

Prevent direct destructive updates to published knowledge.

Require:

* New version
* Approval workflow
* Controlled publishing function

---

## 33.5 Lesson Finalization

When a Lesson Record becomes finalized:

* Prevent ordinary edits
* Allow controlled amendments
* Record finalization timestamp and user

---

## 33.6 SOAP Approval

Prevent a SOAP Note from becoming finalized unless:

* `approved_by` is present
* `approved_at` is present
* Required sections satisfy validation rules

---

# 34. Data Validation Rules

Examples of required database checks:

```text
planned_duration_minutes >= 0
actual_duration_minutes >= 0
sequence_order >= 0
priority >= 0
pain_rating within allowed range
confidence_level within allowed range
start_date <= end_date
source_movement_variant_id != target_movement_variant_id
revoked_at >= granted_at
completed_at >= started_at
```

Application validation does not replace database constraints.

Both layers should validate important rules.

---

# 35. MVP Table List

The initial MVP should implement the following tables first.

## Phase 1: Organization and Knowledge Foundation

```text
organization.studios
organization.instructors
organization.studio_instructors

knowledge.methodologies
knowledge.curricula
knowledge.curriculum_levels
knowledge.teaching_frameworks
knowledge.teaching_principles
knowledge.movement_concepts
knowledge.movement_variants
knowledge.movement_phases
knowledge.curriculum_movements
knowledge.equipment
knowledge.movement_equipment
knowledge.equipment_configurations
knowledge.cues
knowledge.movement_cues
knowledge.movement_principles
knowledge.training_goals
knowledge.movement_goals
knowledge.conditions
knowledge.contraindications
knowledge.condition_contraindications
knowledge.movement_contraindications
knowledge.knowledge_sources

system.translations
system.taxonomy_terms
system.entity_taxonomies
```

---

## Phase 2: Student and Assessment

```text
student.students
student.student_goals
student.student_preferences
student.student_health_profiles
student.student_conditions
student.consent_records
student.student_equipment_access

assessment.frameworks
assessment.templates
assessment.items
assessment.records
assessment.observations
assessment.findings
assessment.finding_evidence
assessment.finding_teaching_focuses
assessment.finding_movements
```

---

## Phase 3: Teaching Delivery

```text
teaching.lesson_plans
teaching.lesson_blocks
teaching.lesson_exercises
teaching.lesson_exercise_cues
teaching.lesson_exercise_focuses
teaching.lesson_records
teaching.exercise_performances
teaching.session_feedback
teaching.soap_notes
teaching.home_programs
teaching.home_exercises
teaching.progress_records
```

---

## Phase 4: AI Traceability

```text
ai.recommendation_requests
ai.model_executions
ai.recommendations
ai.recommendation_items
ai.recommendation_evidence
ai.recommendation_explanations
ai.instructor_decisions
```

---

# 36. Recommended Migration Order

Migration files should follow dependency order.

Example:

```text
0001_extensions.sql
0002_schemas.sql
0003_shared_types.sql
0004_organization.sql
0005_knowledge_governance.sql
0006_teaching_frameworks.sql
0007_movements.sql
0008_equipment.sql
0009_cues.sql
0010_anatomy.sql
0011_conditions_and_safety.sql
0012_taxonomy_and_translations.sql
0013_students.sql
0014_assessments.sql
0015_lesson_plans.sql
0016_lesson_records.sql
0017_home_programs.sql
0018_ai_recommendations.sql
0019_media_assets.sql
0020_indexes.sql
0021_functions_and_triggers.sql
0022_rls_policies.sql
0023_seed_core_data.sql
```

Migration files must never be edited after deployment to a shared environment.

Create a new migration for every subsequent change.

---

# 37. Seed Data Strategy

Seed data should include:

```text
Core system roles
Core permissions
Supported languages
Initial taxonomy types
STOTT methodology
Reformer Essential curriculum
Essential curriculum level
Reformer equipment
Five Basic Principles framework
Five Basic Principles
Initial knowledge statuses
Initial lesson statuses
Initial recommendation statuses
```

Movement knowledge should be imported through a separate controlled process.

Do not place the full Movement Knowledge Base inside one large migration file.

Recommended:

```text
database/seeds/
├── system/
├── methodology/
├── curriculum/
├── teaching_frameworks/
├── movements/
├── cues/
└── taxonomy/
```

---

# 38. Database Testing Requirements

Automated database tests should verify:

* Foreign key integrity
* Unique constraints
* RLS isolation
* Archived records excluded from active queries
* Published knowledge cannot be destructively changed
* Student data cannot be accessed across Studios
* Lesson Plan and Lesson Record remain separate
* AI Recommendations cannot modify Knowledge automatically
* Contraindicated movements are retrievable by safety queries
* Translation uniqueness
* Curriculum order integrity
* Recommendation evidence remains traceable

---

# 39. Example Core Query Paths

The database must efficiently support queries such as:

## Movement Retrieval

```text
Find all published STOTT Reformer Essential movements.
```

## Goal-Based Search

```text
Find beginner Reformer movements supporting pelvic stability.
```

## Safety Filtering

```text
Find candidate movements for a Student,
excluding active contraindications.
```

## Lesson History

```text
Retrieve the Student's last five Lessons,
performed movements,
feedback,
and instructor observations.
```

## AI Explanation

```text
Show why a Movement was recommended,
including Student Goals,
Assessment Findings,
Teaching Rules,
and Movement Knowledge.
```

## Progression

```text
Find valid progressions from a completed Movement Variant.
```

---

# 40. Database Anti-Patterns

The following designs are prohibited.

## 40.1 One Large Movement Table

Do not store everything in one table such as:

```text
movement_name
cue_1
cue_2
muscle_1
condition_1
contraindication_1
```

Use normalized relationships.

---

## 40.2 Language-Specific Duplicate Records

Do not create separate Movement rows for Chinese and English.

Use translations.

---

## 40.3 AI Text as Source of Truth

Do not store AI-generated lesson text without structured Movement references.

---

## 40.4 Student Modifications in Knowledge Tables

Do not modify a canonical Movement Variant because one Student used less range.

Store the change in Lesson Exercise or Exercise Performance.

---

## 40.5 Safety Rules in Prompts Only

Contraindications and safety rules must exist in structured tables.

---

## 40.6 Uncontrolled Tags

Do not use comma-separated tags as the main classification system.

Use Taxonomy Terms and explicit join tables.

---

## 40.7 Hardcoded Methodology Columns

Do not create columns such as:

```text
stott_level
stott_principle
polestar_category
```

Use Methodology, Curriculum, Framework, and relationship tables.

---

# 41. MVP Implementation Decisions

For the initial implementation, the following decisions are recommended:

```text
Database:
Supabase PostgreSQL

Primary Key:
UUID

Studio Model:
Multi-studio capable, one Studio used initially

Methodology Model:
Multi-methodology capable, STOTT used initially

Languages:
English and Simplified Chinese

Translations:
Shared polymorphic translation table

Knowledge Versioning:
Version number initially,
dedicated version tables before production scale

Search:
PostgreSQL full-text search first

Semantic Retrieval:
pgvector added after structured knowledge import

Deletion:
Archive by default

Student Security:
RLS enabled from first migration

AI:
Recommendations stored separately from Knowledge

Knowledge Publishing:
Manual review and approval
```

---

# 42. Definition of Done

The database design is ready for implementation when:

* Every MVP entity maps to a table.
* Every important relationship has a foreign key or join table.
* Student data and Knowledge data are separated.
* Lesson Plans and Lesson Records are separated.
* AI Recommendations and canonical Knowledge are separated.
* STOTT is represented as data, not application logic.
* Polestar can be added without changing core table structure.
* English and Chinese use shared canonical identities.
* Safety rules are structured and queryable.
* Historical records survive Knowledge updates.
* RLS boundaries are defined.
* Migration order is documented.
* Codex can generate SQL without inventing new domain concepts.

---

# 43. Final Database Principle

The database is not merely application storage.

It is the structured foundation of the MyPilates AI product.

The database must preserve:

```text
Knowledge integrity
Methodology context
Student privacy
Teaching history
AI explainability
```

Every database decision must support the central product principle:

> Knowledge is the Product. AI is the Interface.

---

# Relationship to Knowledge Standards

This document defines the relational database schema.

Knowledge representation, movement structures, cue structures,
clinical reasoning,
and AI retrieval metadata
are defined separately in the Knowledge Standards.

Database tables store the knowledge.

Knowledge Standards define the content of that knowledge.