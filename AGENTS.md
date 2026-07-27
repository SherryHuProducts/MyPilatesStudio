# AGENTS.md

**Project:** MyPilatesStudio

**version:** 1.0.0

**Status:** Draft

**Owner:** Xinlei Hu

**Last Updated:** 2026-07-27

**Audience:** AI Coding Agents

- Codex
- ChatGPT
- Claude Code
- Cursor
- Gemini CLI
- Aider
- OpenHands
- Future AI development agents

---

# Purpose

This file is the entry point for every AI agent working on this repository.

Before making any changes, read the project documentation in the required order.

Do not skip documentation.

---

# Required Reading Order

Always read these files before modifying code.

```
README.md

↓

PROJECT_STRUCTURE.md

↓

CODEX_GUIDE.md

↓

docs/
```

Inside `/docs`, read documents in numerical order.

```
00_ProjectVision.md

01_ProductSpecification.md

02_SystemArchitecture.md

03_DomainModel.md

03.5_EntityRelationship.md

04_DatabaseDesign.md
```

Documentation is the source of truth.

Never contradict documented architecture.

---

# Project Philosophy

Core principle:

> Knowledge is the Product.
>
> AI is the Interface.

The primary asset of this repository is structured professional knowledge.

AI is only an interface and reasoning layer.

Never treat AI output as professional truth.

---

# Project Goals

MyPilatesStudio is an AI-assisted operating system for Pilates instructors and studios.

The platform focuses on:

- Knowledge management
- Student management
- Lesson planning
- Teaching support
- AI recommendations
- Instructor-reviewed workflows

It is **not** intended to replace instructor judgment.

---

# General Rules

Always:

- preserve architecture
- preserve documentation
- preserve security
- preserve data integrity
- preserve student privacy

Never:

- invent architecture
- rewrite documented relationships
- expose secrets
- disable RLS
- hardcode business rules
- bypass documentation

---

# Technology Stack

Frontend

- Next.js
- React
- TypeScript

Backend

- Supabase
- PostgreSQL

Authentication

- Supabase Auth

Storage

- Supabase Storage

AI

- Provider independent
- Server-side only

---

# Repository Rules

Use the existing project structure.

Do not create new root folders without approval.

Prefer modifying existing modules instead of introducing new patterns.

---

# Database Rules

The database design is defined in:

```
docs/04_DatabaseDesign.md
```

Never invent tables or relationships that are not documented.

Always use migrations.

Never edit historical migrations.

---

# Knowledge Rules

Professional knowledge belongs in:

```
knowledge/
```

Production knowledge belongs in Supabase.

Do not hardcode professional knowledge into application code.

---

# AI Rules

AI recommendations must always be:

- explainable
- reviewable
- traceable

Never automatically approve AI output.

Never overwrite historical records.

---

# Development Workflow

Preferred order:

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
```

Do not build UI before the underlying data model exists.

---

# If Documentation Is Missing

Do not guess.

Instead:

1. Explain the ambiguity.
2. Propose one or more solutions.
3. Wait for approval.

---

# If Documentation And Code Conflict

Documentation wins.

Report the inconsistency before changing implementation.

Do not silently modify architecture.

---

# Output Expectations

When completing a task, report:

- Summary
- Files changed
- Assumptions
- Risks
- Next recommended step

---

# Additional Instructions

Read:

```
CODEX_GUIDE.md
```

for complete development rules.

This file intentionally remains concise.

The detailed implementation standards are maintained in `CODEX_GUIDE.md`.