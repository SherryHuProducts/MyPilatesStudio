# MyPilates AI

# 02_SystemArchitecture

Version: 1.0.0

Status: Draft

Owner: Xinlei Hu

Last Updated: 2026-07-24

---

# 1. Architecture Philosophy

MyPilates AI is a Knowledge Operating System.

Knowledge is the product.

Artificial Intelligence is only the reasoning interface.

The system is designed around structured knowledge rather than AI models.

Every feature, recommendation, workflow, and future capability must originate from the knowledge layer.

The architecture follows one fundamental principle:

Knowledge → Reasoning → Decision → Teaching

AI never replaces knowledge.

AI only reasons over knowledge.

---

# 2. Core Design Principles

The architecture follows seven principles.

## 2.1 Knowledge First

Knowledge is the foundation of every feature.

Nothing bypasses the knowledge layer.

---

## 2.2 AI is Replaceable

The AI provider is an implementation detail.

The system must support:

- OpenAI
- Anthropic
- Google Gemini
- Local LLMs
- Future AI models

Changing AI providers must not require redesigning the platform.

---

## 2.3 Structured Data

Every entity has:

- Unique identity
- Standard schema
- Version history
- Relationships
- Metadata

Knowledge must never exist only inside prompts.

---

## 2.4 Methodology Agnostic

The architecture must support multiple Pilates methodologies.

Examples include:

- STOTT Pilates
- Polestar Pilates
- BASI Pilates
- Classical Pilates
- Balanced Body

No module should be hardcoded for a single methodology.

---

## 2.5 Explainability

Every recommendation must be traceable.

The system should always answer:

Why?

Which knowledge?

Which rule?

Which assessment?

Which history?

---

## 2.6 Modular Design

Every subsystem should evolve independently.

Examples:

Movement Library

Assessment Engine

Lesson Engine

Knowledge Graph

AI Engine

Student Management

Each module should communicate through well-defined interfaces.

---

## 2.7 Continuous Expansion

New knowledge should be added without redesigning the database.

The platform grows by adding knowledge, not rewriting software.

---

# 3. High-Level Architecture

The platform is composed of five layers.

──────────────────────────────

Presentation Layer

↓

Application Layer

↓

Knowledge Layer

↓

Reasoning Layer

↓

Data Layer

──────────────────────────────

Each layer has a single responsibility.

---

# 4. Presentation Layer

Purpose

Provide interfaces for instructors.

Components

- Dashboard
- Student Profile
- Assessment
- Lesson Builder
- Movement Explorer
- Knowledge Search
- Reports
- Settings

No business logic should exist inside the UI.

---

# 5. Application Layer

Purpose

Coordinate workflows.

Responsibilities

- Authentication
- Authorization
- Student Management
- Lesson Management
- Assessment Management
- File Management
- API Gateway

The application layer never contains professional Pilates knowledge.

It only manages workflows.

---

# 6. Knowledge Layer

This is the heart of MyPilates AI.

Everything originates here.

Modules include:

Movement Knowledge Base

Cue Library

Teaching Frameworks

Methodologies

Curricula

Conditions

Anatomy

Equipment

Posture

Assessment Rules

Teaching Rules

Clinical Rules

Knowledge Graph

Every module stores structured knowledge.

No AI-generated knowledge is stored directly.

---

# 7. Reasoning Layer

Purpose

Transform knowledge into recommendations.

Submodules

Lesson Generator

Clinical Reasoning Engine

Progression Engine

Regression Engine

Cue Recommendation Engine

Exercise Selection Engine

Search Engine

Future Recommendation Engine

Reasoning operates only on structured knowledge.

---

# 8. Data Layer

Purpose

Persist all information.

Major Domains

Knowledge

Student

Lesson

Assessment

Analytics

Media

Configuration

Audit Logs

Future Expansion

Research

Certification

Studio Operations

---

# 9. Knowledge Flow

Knowledge enters the system through standardized data.

↓

Knowledge is validated.

↓

Knowledge is structured.

↓

Knowledge becomes searchable.

↓

Knowledge relationships are established.

↓

Knowledge Graph is updated.

↓

AI reasons over the graph.

↓

Recommendations are generated.

↓

Instructor reviews.

↓

Teaching occurs.

↓

Student history grows.

↓

Knowledge continuously improves.

Knowledge always flows forward.

---

# 10. AI Flow

Instructor Request

↓

Context Collection

↓

Relevant Knowledge Retrieval

↓

Reasoning

↓

Recommendation

↓

Explanation

↓

Instructor Review

↓

Final Decision

The instructor always approves the final lesson.

---

# 11. Knowledge Domains

The architecture organizes knowledge into independent domains.

Movement

Cue

Teaching Framework

Methodology

Curriculum

Anatomy

Equipment

Condition

Posture

Assessment

Lesson

Student

Clinical Reasoning

Each domain owns its own data.

Relationships connect domains.

Domains should never duplicate information.

---

# 12. System Boundaries

The platform provides:

✓ Knowledge

✓ Reasoning

✓ Recommendations

✓ Documentation

✓ Student Management

The platform does NOT provide:

Medical diagnosis

Medical treatment

Emergency care

Prescription advice

Legal advice

The instructor remains responsible for professional decisions.

---

# 13. Future Architecture

The architecture must support future capabilities.

Examples:

Multi-language knowledge

Voice coaching

Video analysis

Movement recognition

Computer vision

Wearable integration

Electronic Health Records

Research datasets

Additional Pilates methodologies

No redesign should be required.

---

# 14. Single Source of Truth

Every piece of information has one authoritative source.

Examples

Movement

↓

Movement Knowledge Base

Cue

↓

Cue Library

Teaching Principles

↓

Teaching Framework

Student History

↓

Lesson Records

Assessment

↓

Assessment Module

Duplicated knowledge is prohibited.

---

# 15. System Diagram

                            Instructor
                                 │
                                 ▼
                      Presentation Layer
                                 │
                                 ▼
                      Application Layer
                                 │
                                 ▼
                     Knowledge Retrieval
                                 │
                                 ▼
                      Knowledge Graph
                                 │
                                 ▼
                      Reasoning Engine
                                 │
                                 ▼
                     AI Recommendation
                                 │
                                 ▼
                      Instructor Review
                                 │
                                 ▼
                             Teaching
                                 │
                                 ▼
                         Student History
                                 │
                                 └──────────────┐
                                                │
                                                ▼
                                       Knowledge Growth

---

# 16. Architecture Principle

Knowledge is the Product.

Data is the Asset.

AI is the Reasoning Engine.

The Instructor is the Decision Maker.

The Student is the Beneficiary.

Every future feature must strengthen the knowledge layer rather than bypass it.