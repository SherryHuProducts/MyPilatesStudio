# MyPilatesStudio

# CODEX_GUIDE.md

**Version:** 1.0.0

**Status:** Active

**Owner:** Xinlei Hu

**Last Updated:** 2026-07-27

**Audience:** Codex AI

---

# 1. Purpose

This document defines the development rules that Codex must follow when contributing to the MyPilatesStudio repository.

It is not product documentation.

It is the operational guide for AI-assisted software development.

Codex must read this file before modifying the repository.

---

# 2. Repository Source of Truth

Before making any code changes, always read:

```
README.md

PROJECT_STRUCTURE.md

docs/architecture/01_ProductSpecification.md

docs/architecture/02_SystemArchitecture.md

docs/architecture/03_DomainModel.md

docs/architecture/03.5_EntityRelationship.md

docs/architecture/04_DatabaseDesign.md

docs/standards/05_KnowledgeStandard.md

docs/standards/06_MovementStandard.md

```

If a document has moved, always use the latest repository structure instead of assuming historical paths.

If implementation and documentation conflict:

**Never silently change the architecture.**

Instead:

- explain the conflict
- propose a solution
- wait for approval before changing architectural decisions

---

# 3. Project Philosophy

The project follows one core principle.

> Knowledge is the Product.
> AI is the Interface.

This affects every implementation decision.

Professional knowledge is the product.

The AI is only a reasoning layer.

The AI must never become the source of truth.

---

# 4. Development Principles

Always prefer:

- explicit architecture
- reusable components
- small modules
- readability
- maintainability
- type safety
- documentation

Avoid:

- unnecessary abstraction
- duplicated logic
- hidden business rules
- large unreviewable commits

---

# 5. Documentation Hierarchy

The documentation should be interpreted in the following order.

```
PROJECT_STRUCTURE.md

↓

00_ProjectVision.md

↓

01_ProductSpecification.md

↓

02_SystemArchitecture.md

↓

03_DomainModel.md

↓

03.5_EntityRelationship.md

↓

04_DatabaseDesign.md
```

Lower-level documents must never contradict higher-level documents.

---

# 6. Coding Style

Language:

```
TypeScript
```

Use:

- strict typing
- descriptive names
- async / await
- early returns
- composition over inheritance

Avoid:

```
any
```

unless there is no practical alternative.

Never disable strict mode to solve typing problems.

---

# 7. Folder Responsibilities

Do not create new root folders without approval.

Use existing folders.

Examples:

```
app/

components/

features/

lib/

services/

knowledge/

supabase/
```

If uncertain where a file belongs:

ask before creating a new structure.

---

# 8. Next.js Rules

Use:

- App Router
- Server Components by default
- Client Components only when required

Prefer:

- Server Actions
- Route Handlers

Avoid unnecessary client-side data fetching.

---

# 9. React Rules

Prefer:

- functional components
- composition
- reusable hooks

Avoid:

- giant components
- duplicated state
- unnecessary prop drilling

---

# 10. Database Rules

The database architecture is defined in:

```
docs/04_DatabaseDesign.md
```

Never invent tables.

Never invent relationships.

Never rename entities.

Every migration must follow the documented schema.

Migration order matters.

Never modify previously deployed migrations.

Always create a new migration.

---

# 11. Supabase Rules

Use:

- PostgreSQL
- RLS
- Supabase Auth
- Supabase Storage

Do not bypass Row Level Security.

Never expose Service Role Keys.

---

# 12. Knowledge Rules

Professional knowledge belongs in:

```
knowledge/
```

Production knowledge belongs in:

```
Supabase PostgreSQL
```

Do not hardcode knowledge inside React components.

Do not embed large movement libraries into source code.

Knowledge should remain structured.

---

# 13. AI Rules

AI is not authoritative.

Every AI recommendation must:

- be traceable
- be explainable
- reference structured knowledge
- preserve supporting evidence

Never:

- auto-publish AI knowledge
- auto-finalize student records
- auto-approve SOAP notes

---

# 14. Security Rules

Never expose:

- API keys
- Service Role Keys
- Secrets

Never commit:

```
.env.local
```

Only commit:

```
.env.example
```

---

# 15. Student Data Rules

Student data is private.

Every query must respect:

- Studio isolation
- Instructor permissions
- Row Level Security

Never create demo data using real students.

---

# 16. Copyright Rules

The project may organize professional knowledge.

It must not redistribute copyrighted manuals without authorization.

Knowledge files should include:

- source
- review status
- copyright status

Never copy entire commercial manuals into the repository.

---

# 17. Testing Rules

Every important change should include appropriate tests.

Test levels include:

- unit
- integration
- database
- end-to-end

High-risk changes should include regression tests.

---

# 18. Commit Rules

Prefer small commits.

Examples:

```
feat(database): add organization schema

fix(auth): correct RLS policy

docs(database): clarify movement relationships
```

Avoid huge commits touching unrelated features.

---

# 19. Pull Request Rules

Each PR should:

- solve one logical problem
- explain why
- describe architectural impact
- mention affected documents

Do not mix:

- refactoring
- feature development
- documentation
- bug fixes

inside one PR.

---

# 20. When You Are Unsure

Never guess.

If documentation is incomplete:

1. explain the ambiguity
2. propose options
3. wait for approval

Architecture decisions require approval.

Implementation details may be proposed.

---

# 21. Things You Must Never Do

Never:

- rewrite architecture
- disable RLS
- expose secrets
- delete migrations
- rename documented entities
- replace Supabase
- replace Next.js
- replace TypeScript
- hardcode STOTT into the architecture
- use AI output as production truth
- overwrite historical records
- silently change business rules

---

# 22. Preferred Development Order

Always develop in this order.

```
Documentation

↓

Database

↓

Backend

↓

Frontend

↓

AI

↓

Testing

↓

Optimization
```

Do not build UI before the underlying data model exists.

---

# 23. Communication Style

When reporting completed work:

Always include:

```
Summary

Files Changed

Why

Possible Risks

Next Recommended Step
```

When assumptions are made:

Clearly state:

```
Assumptions
```

Never hide implementation assumptions.

---

# 24. Definition of Success

A task is successful only if:

- architecture remains consistent
- documentation remains valid
- code compiles
- tests pass
- security is preserved
- AI remains explainable
- knowledge remains structured
- student privacy is protected

---

# 25. Final Principle

Every contribution should strengthen one or more of the following:

- Knowledge Quality
- Teaching Quality
- Student Safety
- Maintainability
- Explainability
- Scalability

Never trade long-term architecture for short-term convenience.

The goal is not simply to build software.

The goal is to build the operating system for modern Pilates education.