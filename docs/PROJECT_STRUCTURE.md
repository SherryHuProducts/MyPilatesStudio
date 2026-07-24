# MyPilatesStudio Repository Structure

**Version:** 1.1.0  
**Status:** Active Draft  
**Owner:** Xinlei Hu  
**Last Updated:** 2026-07-24

---

## 1. Project Overview

MyPilatesStudio is an AI-assisted teaching and student-management platform for Pilates instructors and studios.

The platform is designed to help instructors:

- Manage student profiles
- Record lessons and student feedback
- Track student goals and progress
- Build and maintain a structured Pilates movement library
- Build a reusable teaching cue library
- Search and filter movements by teaching context
- Generate instructor-reviewed lesson recommendations
- Manage studio and instructor accounts
- Support subscriptions and payments in future versions

The first supported Pilates methodology is:

```text
STOTT Pilates
```

The first supported curriculum is:

```text
STOTT Reformer Essential
```

The architecture must remain methodology-agnostic so additional systems can be added later, including:

- Polestar Pilates
- BASI Pilates
- Classical Pilates
- Balanced Body
- Other future methodologies

---

## 2. Core Product Principle

> Knowledge is the Product. AI is the Interface.

The primary product asset is not the AI model.

The primary product assets are:

```text
Movement Knowledge
Teaching Knowledge
Assessment Knowledge
Safety Knowledge
Student Context
Teaching History
Instructor Experience
```

AI is a replaceable reasoning and interaction layer built on top of structured knowledge.

The AI may:

- Retrieve knowledge
- Compare relevant records
- Generate recommendations
- Explain recommendations
- Draft instructor-facing content

The AI must not:

- Invent professional knowledge
- Create medical diagnoses
- Replace instructor judgment
- Automatically publish knowledge
- Automatically finalize student records
- Treat its own output as a source of truth

---

## 3. System Boundaries

MyPilatesStudio provides:

- Pilates knowledge organization
- Student management
- Assessment documentation
- Lesson planning
- Lesson history
- Instructor-reviewed AI recommendations
- Home-program preparation
- Progress tracking

MyPilatesStudio does not provide:

- Medical diagnosis
- Medical treatment
- Physical therapy
- Prescription
- Emergency medical services
- Fully autonomous teaching decisions
- Legal or insurance advice

The instructor remains responsible for final teaching decisions.

---

## 4. Technology Direction

The initial implementation should use:

```text
Frontend:
Next.js
React
TypeScript

Styling:
Tailwind CSS

Database:
PostgreSQL through Supabase

Authentication:
Supabase Auth

Authorization:
PostgreSQL Row Level Security

File Storage:
Supabase Storage

Server Logic:
Next.js Server Actions
Next.js Route Handlers
Supabase Edge Functions when appropriate

AI Integration:
Server-side only

Deployment:
Vercel or another compatible Next.js platform

Source Control:
GitHub
```

The exact AI provider must remain replaceable.

Do not design core business logic around one AI vendor.

---

## 5. Repository Structure

```text
MyPilatesStudio/
│
├── app/
│   ├── (auth)/
│   ├── (dashboard)/
│   ├── api/
│   ├── layout.tsx
│   ├── page.tsx
│   └── globals.css
│
├── components/
│   ├── ui/
│   ├── layout/
│   ├── forms/
│   └── shared/
│
├── features/
│   ├── auth/
│   ├── studios/
│   ├── instructors/
│   ├── students/
│   ├── assessments/
│   ├── movements/
│   ├── cues/
│   ├── lesson-plans/
│   ├── lesson-records/
│   ├── soap-notes/
│   ├── home-programs/
│   ├── progress/
│   └── ai-recommendations/
│
├── lib/
│   ├── supabase/
│   ├── ai/
│   ├── auth/
│   ├── validation/
│   ├── permissions/
│   ├── errors/
│   └── constants/
│
├── prompts/
│   ├── lesson-generation/
│   ├── cue-recommendation/
│   ├── soap-note-drafting/
│   ├── home-program/
│   ├── shared/
│   └── README.md
│
├── knowledge/
│   ├── methodology/
│   ├── curriculum/
│   ├── movements/
│   ├── cues/
│   ├── teaching-principles/
│   ├── assessment/
│   ├── safety/
│   ├── taxonomy/
│   ├── imports/
│   └── README.md
│
├── types/
│   ├── database.ts
│   ├── domain.ts
│   ├── api.ts
│   └── ai.ts
│
├── config/
│   ├── app.ts
│   ├── navigation.ts
│   ├── feature-flags.ts
│   └── environment.ts
│
├── hooks/
│
├── services/
│   ├── knowledge/
│   ├── students/
│   ├── assessments/
│   ├── teaching/
│   └── ai/
│
├── utils/
│
├── public/
│   ├── images/
│   ├── icons/
│   └── videos/
│
├── tests/
│   ├── unit/
│   ├── integration/
│   ├── database/
│   └── e2e/
│
├── scripts/
│   ├── import-knowledge/
│   ├── validate-knowledge/
│   ├── seed-development/
│   └── generate-types/
│
├── docs/
│   ├── 00_ProjectVision.md
│   ├── 01_ProductSpecification.md
│   ├── 02_SystemArchitecture.md
│   ├── 03_DomainModel.md
│   ├── 03.5_EntityRelationship.md
│   ├── 04_DatabaseDesign.md
│   └── ...
│
├── supabase/
│   ├── migrations/
│   ├── seed/
│   ├── functions/
│   ├── tests/
│   ├── config.toml
│   └── README.md
│
├── middleware.ts
├── .env.example
├── .env.local
├── .gitignore
├── README.md
├── PROJECT_STRUCTURE.md
├── package.json
├── tsconfig.json
├── next.config.ts
└── eslint.config.mjs
```

Not every folder must be created immediately.

Folders should be created when the corresponding feature begins implementation.

Avoid empty directory trees that provide no immediate value.

---

## 6. Directory Responsibilities

### 6.1 `app/`

Contains Next.js routes, layouts, pages, loading states, error boundaries, Route Handlers, and Server Actions.

Examples:

```text
app/(auth)/login/
app/(dashboard)/students/
app/(dashboard)/movement-library/
app/api/ai/lesson-plan/
```

Rules:

- Keep route files thin.
- Do not place complex business logic directly in pages.
- Move reusable business logic into `features/`, `services/`, or `lib/`.
- API endpoints must use Next.js `app/api/`.
- Do not create a second root-level `api/` directory.

---

### 6.2 `components/`

Contains reusable presentation components.

```text
components/ui/
```

Low-level generic UI components such as:

- Button
- Input
- Dialog
- Table
- Badge
- Card

```text
components/layout/
```

Application layout components such as:

- Sidebar
- Header
- Page container
- Navigation

```text
components/forms/
```

Reusable form controls and form layout components.

```text
components/shared/
```

Components reused across multiple features.

Rules:

- Components should not contain direct database access.
- Feature-specific components should remain inside their feature directory.
- Generic components should not depend on Pilates-specific business logic.

---

### 6.3 `features/`

Contains domain-oriented application modules.

Each feature may contain:

```text
components/
actions/
queries/
schemas/
types/
utils/
tests/
index.ts
```

Example:

```text
features/students/
├── components/
├── actions/
├── queries/
├── schemas/
├── types/
└── index.ts
```

Rules:

- Organize code by business capability.
- Avoid one global folder containing all actions or all schemas.
- Features may use shared utilities from `lib/`.
- Features must not import private internals from unrelated features.
- Public feature APIs should be exported through the feature's `index.ts`.

---

### 6.4 `lib/`

Contains shared infrastructure code.

```text
lib/supabase/
```

Contains:

- Browser Supabase client
- Server Supabase client
- Admin client
- Auth helpers
- Generated database helpers

```text
lib/ai/
```

Contains:

- AI provider adapters
- Structured-output helpers
- Retrieval helpers
- Safety validation
- Model configuration

```text
lib/validation/
```

Contains shared validation utilities and schemas.

```text
lib/permissions/
```

Contains authorization helpers.

Rules:

- Do not store business-domain entities in `lib/`.
- Do not expose service-role credentials to browser code.
- Server-only modules must use clear server-only boundaries.

---

### 6.5 `prompts/`

Contains version-controlled AI prompt templates.

Examples:

```text
lesson-generation/
cue-recommendation/
soap-note-drafting/
home-program/
```

Rules:

- Prompt execution must occur server-side.
- Full prompts must never be delivered to the browser.
- Prompt templates must be versioned.
- Prompts must request structured output where possible.
- Prompts must not contain the only copy of professional or safety rules.
- Professional rules must come from structured database knowledge.
- Prompt changes must be reviewable through Git history.
- Student-sensitive information must be minimized before being sent to an AI provider.

Prompt files may include:

```text
system.md
developer.md
output-schema.ts
examples.json
README.md
```

---

### 6.6 `knowledge/`

Contains source-controlled knowledge assets used for review, import, validation, and seeding.

Examples:

```text
knowledge/movements/
knowledge/cues/
knowledge/teaching-principles/
knowledge/safety/
knowledge/taxonomy/
```

This directory is not the production database.

Production knowledge is stored in Supabase PostgreSQL.

The `knowledge/` directory may contain:

- JSON
- YAML
- CSV
- Markdown
- Import manifests
- Validation schemas
- Editorial review files

Rules:

- Knowledge files must use stable IDs or codes.
- Knowledge should be structured rather than stored only as prose.
- Every imported knowledge record should include source and review metadata where appropriate.
- Copyright status must be documented.
- Restricted manuals must not be committed to a public repository.
- Student data must never be stored in this directory.
- AI-generated knowledge must not be added without human review.

Suggested structure:

```text
knowledge/
├── methodology/
│   └── stott/
├── curriculum/
│   └── stott-reformer-essential/
├── movements/
│   └── stott-reformer-essential/
├── cues/
├── teaching-principles/
├── assessment/
├── safety/
├── taxonomy/
├── imports/
└── README.md
```

---

### 6.7 `types/`

Contains shared TypeScript type definitions.

Examples:

```text
database.ts
domain.ts
api.ts
ai.ts
```

Rules:

- Database-generated types should be generated from Supabase.
- Do not manually duplicate database types without a reason.
- Domain types may wrap or refine generated database types.
- API request and response types must be explicit.
- AI structured-output types must be validated at runtime.

---

### 6.8 `config/`

Contains non-sensitive application configuration.

Examples:

- Navigation
- Feature flags
- Supported languages
- Application metadata
- Public configuration

Rules:

- Never store secrets here.
- Environment-dependent values should come from environment variables.
- Core business knowledge should not be hardcoded in configuration files.

---

### 6.9 `hooks/`

Contains reusable React hooks.

Rules:

- Hooks should be browser-oriented.
- Server database logic does not belong here.
- Domain-specific hooks may remain inside their feature folder.

---

### 6.10 `services/`

Contains reusable application and domain service orchestration.

Examples:

```text
services/knowledge/
services/students/
services/teaching/
services/ai/
```

Services may:

- Coordinate multiple database queries
- Apply business rules
- Prepare AI context
- Validate recommendation results
- Convert domain entities into application responses

Rules:

- Services must not bypass authorization.
- Services must not silently swallow errors.
- AI services must not write final student records without instructor confirmation.
- Safety validation should occur outside the language model as well as inside prompts.

---

### 6.11 `utils/`

Contains small, stateless, broadly reusable utility functions.

Examples:

- Date formatting
- Text normalization
- Slug generation
- Safe parsing
- Array helpers

Do not place major business logic in `utils/`.

---

### 6.12 `public/`

Contains public static assets.

Examples:

- Logos
- Public icons
- Public images
- Non-sensitive demonstration videos

Rules:

- Files in `public/` are publicly accessible.
- Do not place student files here.
- Do not place copyrighted training manuals here.
- Do not place restricted movement videos here.
- Private files belong in Supabase Storage private buckets.

---

### 6.13 `tests/`

Contains cross-feature and system-level tests.

```text
tests/unit/
tests/integration/
tests/database/
tests/e2e/
```

Feature-local tests may remain inside their feature directories.

Required test areas include:

- Authorization
- Row Level Security
- Studio data isolation
- Student data isolation
- Knowledge filtering
- Safety filtering
- AI structured-output validation
- Lesson plan approval
- Historical record preservation

---

### 6.14 `scripts/`

Contains controlled developer and data-management scripts.

Examples:

```text
import-knowledge/
validate-knowledge/
seed-development/
generate-types/
```

Rules:

- Scripts must be repeatable.
- Scripts should support dry-run mode for destructive or high-volume operations.
- Scripts must validate input before database insertion.
- Import scripts must not silently overwrite published knowledge.
- Scripts requiring secrets must read them from environment variables.

---

### 6.15 `docs/`

Contains architecture, product, database, AI, and operational documentation.

Current document sequence:

```text
00_ProjectVision.md
01_ProductSpecification.md
02_SystemArchitecture.md
03_DomainModel.md
03.5_EntityRelationship.md
04_DatabaseDesign.md
```

Future documents may include:

```text
05_KnowledgeGraph.md
06_API.md
07_AIArchitecture.md
08_SecurityAndPrivacy.md
09_KnowledgeEntryGuide.md
10_ClinicalBoundary.md
11_TestingStrategy.md
12_Deployment.md
13_Roadmap.md
```

Rules:

- Documentation is part of the product.
- Significant architectural changes must update the relevant document.
- Code must follow approved documentation unless a documented change is made.
- Codex must not silently reinterpret architectural decisions.

---

### 6.16 `supabase/`

Contains the Supabase local-development and database implementation files.

```text
supabase/
├── migrations/
├── seed/
├── functions/
├── tests/
├── config.toml
└── README.md
```

#### `supabase/migrations/`

Contains immutable SQL migration files.

Example:

```text
202607240001_extensions.sql
202607240002_schemas.sql
202607240003_organization.sql
202607240004_knowledge_governance.sql
```

Rules:

- Never edit a migration after it has been deployed to a shared environment.
- Create a new migration for subsequent changes.
- Migrations must be committed to Git.
- Migrations must follow dependency order.

#### `supabase/seed/`

Contains development and controlled seed data.

Use seed files for:

- Roles
- Permissions
- Methodologies
- Curricula
- Initial taxonomy
- Development fixtures

Do not put student production data in seed files.

#### `supabase/functions/`

Contains Supabase Edge Functions.

Use Edge Functions when:

- A server-side endpoint must run independently of Next.js
- A webhook is required
- A background process is required
- A protected AI request is better handled at the Supabase layer

Do not duplicate the same business endpoint in both Next.js and an Edge Function.

#### `supabase/tests/`

Contains database and RLS tests.

---

## 7. Database Source of Truth

The production database source of truth is:

```text
supabase/migrations/
```

The database documentation source of truth is:

```text
docs/04_DatabaseDesign.md
```

The current deployed database must be reproducible from committed migrations.

Do not manually change production tables without creating a migration.

---

## 8. Data Storage Rules

### GitHub stores

```text
Application code
Database migrations
Documentation
Prompt templates
Knowledge import files
Validation schemas
Tests
Configuration without secrets
```

### Supabase PostgreSQL stores

```text
Canonical professional knowledge
Studio records
Instructor records
Student records
Assessments
Lesson plans
Lesson history
SOAP notes
Home programs
AI recommendation history
Audit records
```

### Supabase Storage stores

```text
Private source documents
Student attachments
Medical-clearance documents
Movement images
Movement videos
Other uploaded files
```

### AI provider receives

Only the minimum context required for the current request.

The AI provider must not become permanent storage for student or knowledge data.

---

## 9. Environment Variables

Local secrets belong in:

```text
.env.local
```

Example variable names:

```text
NEXT_PUBLIC_SUPABASE_URL
NEXT_PUBLIC_SUPABASE_ANON_KEY
SUPABASE_SERVICE_ROLE_KEY
AI_PROVIDER_API_KEY
```

Rules:

- `.env.local` must never be committed.
- `.env.example` contains variable names only.
- `.env.example` must not contain real credentials.
- Variables beginning with `NEXT_PUBLIC_` are visible to the browser.
- Never place service-role keys or AI API keys in browser-visible variables.
- Secret access should occur only in server-side code.

---

## 10. Security Rules

### 10.1 Row Level Security

RLS must be enabled from the beginning for:

- Studio-owned records
- Student records
- Health profiles
- Assessments
- Lesson plans
- Lesson records
- SOAP notes
- Home programs
- AI recommendations

A user may access a student record only when authorized through the relevant Studio relationship and permissions.

---

### 10.2 Server-Only AI Calls

AI calls must occur through:

- Next.js Route Handlers
- Next.js Server Actions
- Supabase Edge Functions

AI calls must not occur directly from the browser using a secret API key.

---

### 10.3 Input and Output Validation

All untrusted data must be validated.

Use runtime schemas such as:

```text
Zod
```

Validate:

- Form input
- API input
- AI structured output
- Knowledge import files
- Database-bound payloads

AI output must be treated as untrusted input.

---

### 10.4 Sensitive Data

Sensitive student data must not appear in:

- Browser logs
- Public URLs
- Public Storage buckets
- Git commits
- Test fixtures committed with real identities
- AI prompts unless necessary
- General application error messages

---

## 11. Knowledge and Copyright Rules

The platform may organize knowledge from:

- Legally owned educational materials
- Instructor-created notes
- Original MyPilatesStudio content
- Approved public sources
- Properly licensed content

Rules:

- Do not copy and commercially redistribute copyrighted manuals without authorization.
- Do not commit restricted training manuals to a public repository.
- Structured knowledge must record its source where appropriate.
- Source status and copyright status must be distinguishable.
- Original source documents and structured interpretations must remain separate.
- AI must not reproduce large sections of copyrighted material.
- Knowledge imported from AI output requires human review.

---

## 12. AI Recommendation Rules

AI recommendations must be stored separately from canonical knowledge.

Correct flow:

```text
Structured Knowledge
        +
Student Context
        +
Teaching History
        ↓
AI Recommendation
        ↓
Validation
        ↓
Instructor Review
        ↓
Approved Lesson Plan or Record
```

Incorrect flow:

```text
AI Output
    ↓
Automatically saved as professional truth
```

Every recommendation should preserve:

- Request context
- Selected movement references
- Supporting evidence
- Safety flags
- Explanation
- Instructor decision
- Model and prompt version

---

## 13. Coding Rules for Codex

Codex must follow these rules when modifying the repository.

### Before making changes

Codex must:

1. Read `README.md`.
2. Read `PROJECT_STRUCTURE.md`.
3. Read relevant files under `docs/`.
4. Inspect the existing repository.
5. Reuse existing patterns where reasonable.
6. Identify conflicts between code and documentation.

### While making changes

Codex must:

- Make the smallest coherent change.
- Avoid unrelated refactoring.
- Preserve existing behavior unless change is requested.
- Use TypeScript strict typing.
- Add runtime validation at system boundaries.
- Use server-only modules for secrets.
- Add or update tests.
- Follow Supabase migration rules.
- Preserve studio and student isolation.
- Preserve historical records.
- Use structured foreign-key references instead of AI-generated names where possible.

### Codex must not

- Add a new framework without approval.
- Replace Supabase without approval.
- Hardcode STOTT-specific columns into general architecture.
- Put secrets into the repository.
- Disable RLS for convenience.
- expose service-role keys to the client.
- Store production student data in Git.
- Modify published migration files.
- Automatically publish AI-generated knowledge.
- Automatically finalize AI-generated student documentation.
- Create duplicate root-level folders with overlapping responsibility.
- Create a root-level `api/` folder when `app/api/` already exists.
- place business logic directly into page components without reason.
- use JSONB as a replacement for core relational entities.
- silently change documented architecture.

---

## 14. Implementation Priorities

Development should proceed in this order.

### Phase 1: Repository Foundation

Create:

```text
app/
components/
features/
lib/
docs/
knowledge/
supabase/
tests/
scripts/
```

Add:

- TypeScript
- ESLint
- Environment validation
- Supabase clients
- Basic CI
- Basic test setup

---

### Phase 2: Database Foundation

Implement:

```text
Supabase extensions
PostgreSQL schemas
Studios
Instructors
Roles
Permissions
Methodologies
Curricula
Teaching frameworks
Teaching principles
Movement concepts
Movement variants
```

Enable RLS from the beginning.

---

### Phase 3: Movement Library

Implement:

- Movement library browsing
- Movement detail page
- Bilingual translations
- Cue relationships
- Equipment configuration
- Teaching principles
- Safety relationships
- Knowledge source metadata

Initial content:

```text
STOTT Reformer Essential
```

---

### Phase 4: Student and Teaching Records

Implement:

- Student profiles
- Student goals
- Health context
- Assessments
- Lesson plans
- Lesson records
- SOAP notes
- Home programs
- Progress history

---

### Phase 5: AI Assistance

Implement:

- Knowledge retrieval
- Lesson recommendations
- Cue recommendations
- SOAP-note drafting
- Recommendation evidence
- Instructor approval workflow

AI must be added only after the underlying structured data and permissions are working.

---

### Phase 6: Studio Operations

Future capabilities:

- Multi-instructor workflow
- Scheduling
- Subscription
- Billing
- Payments
- Studio analytics

These features are not part of the initial knowledge-platform MVP.

---

## 15. Current MVP Scope

The MVP should support:

```text
One active Studio
One primary Instructor
STOTT Pilates
Reformer Essential
English
Simplified Chinese
Movement Library
Cue Library
Five Basic Principles
Student Profiles
Assessments
Lesson Planning
Lesson Records
SOAP Notes
Home Programs
AI Lesson Recommendations
Instructor Review
```

The architecture should still support future multi-studio and multi-methodology use.

---

## 16. Definition of Done

A feature is not complete until:

- Code is typed.
- Inputs are validated.
- Authorization is enforced.
- RLS is considered and tested.
- Errors are handled.
- Loading and empty states are handled.
- Tests are added where appropriate.
- Documentation is updated when architecture changes.
- AI output is validated when AI is involved.
- Student privacy is preserved.
- Historical teaching data is not silently overwritten.

---

## 17. Final Architectural Principle

MyPilatesStudio must grow by adding:

```text
Structured knowledge
Explicit relationships
Reviewed teaching rules
Secure student context
Traceable recommendations
```

It must not grow by adding:

```text
More hardcoded prompts
More uncontrolled free text
More duplicated data
More hidden business logic
More AI assumptions
```

The repository, database, frontend, and AI layer must all follow the same principle:

> Knowledge is the Product. AI is the Interface.