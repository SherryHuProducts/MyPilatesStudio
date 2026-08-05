# MyPilates AI

# Product Specification

Version: 1.0.0

Status: Draft

Owner: Xinlei Hu

Last Updated: 2026-07-24

---

# 1. Product Vision

MyPilates AI is an AI-powered Pilates Operating System designed for professional Pilates instructors.

The platform combines structured knowledge, artificial intelligence, and standardized teaching workflows to help instructors deliver safer, more consistent, and more personalized lessons.

The system is not designed to replace instructors.

Its purpose is to augment professional decision-making through explainable AI.

---

# 2. Problem Statement

Professional Pilates knowledge is fragmented.

Most instructors rely on:

- Certification manuals
- Personal notes
- Experience
- Memory
- Individual teaching style

This creates several challenges:

- Inconsistent lesson quality
- Time-consuming lesson planning
- Knowledge difficult to reuse
- Limited scalability
- Difficult instructor onboarding

The goal of MyPilates AI is to transform professional knowledge into structured, reusable, searchable, and continuously evolving data.

---

# 3. Product Philosophy

The platform follows six core principles.

## 3.1 Instructor First

The instructor always makes the final decision.

AI provides recommendations but never replaces professional judgment.

---

## 3.2 Knowledge First

Knowledge is the foundation.

AI reasons over structured knowledge rather than generating unsupported advice.

---

## 3.3 Methodology Agnostic

The system is designed to support multiple Pilates methodologies.

Version 1 begins with STOTT Pilates.

Future versions may include:

- Polestar Pilates
- BASI Pilates
- Classical Pilates
- Balanced Body
- Peak Pilates
- Fletcher Pilates

The database architecture must not depend on any single methodology.

---

## 3.4 Explainable AI

Every AI recommendation must explain:

- Why this recommendation was made
- Which student data was considered
- Which teaching framework was applied
- Which movement relationships were used

Every recommendation should be traceable.

---

## 3.5 Structured Data

All knowledge must follow standardized schemas.

No duplicate terminology.

No duplicated concepts.

No ambiguous naming.

---

## 3.6 Continuous Evolution

The knowledge base should continuously expand without requiring database redesign.

---

# 4. Target Users

## Primary Users

Professional Pilates Instructors

Clinical Pilates Instructors

Pilates Studio Owners

---

## Future Users

Pilates Education Organizations

Certification Programs

Rehabilitation Clinics

Fitness Organizations

---

# 5. Product Scope

## Version 1

The MVP focuses entirely on instructor productivity.

Included:

- Student Management
- Assessment
- Lesson Planning
- Movement Knowledge Base
- Cue Library
- Teaching Frameworks
- SOAP Notes
- Home Exercise Programs
- AI Lesson Recommendation

Excluded:

- Payment
- Scheduling
- Booking
- Messaging
- Membership
- Video Classes
- Marketplace

---

# 6. Product Architecture

The product consists of four logical layers.

## Knowledge Layer

The source of truth for all AI reasoning.

Modules:

- Movement Knowledge Base
- Cue Library
- Teaching Frameworks
- Anatomy
- Conditions
- Equipment
- Knowledge Graph

---

## Teaching Layer

Instructor workflow.

Modules:

- Assessment
- Lesson Builder
- Lesson History
- SOAP Notes
- Home Exercise Programs
- Progress Tracking

---

## Business Layer

Studio operations.

Modules:

- Dashboard
- Student Management
- Instructor Management
- Studio Management

---

## AI Layer

Decision support.

Modules:

- Lesson Generator
- Clinical Reasoning
- Progression Engine
- Recommendation Engine
- AI Teaching Assistant

---

# 7. Teaching Frameworks

Teaching Frameworks organize professional knowledge independently of any single Pilates methodology.

Each methodology may define its own:

- Teaching Principles
- Assessment Framework
- Cue System
- Progression Rules
- Clinical Reasoning
- Movement Variations

---

## Version 1

Supported Methodology

STOTT Pilates

Supported Curriculum

- Reformer Essential

Teaching Framework

Five Basic Principles

- Breathing
- Pelvic Placement
- Rib Cage Placement
- Scapular Movement & Stabilization
- Head & Cervical Placement

---

Future methodologies should be added by configuration rather than application redesign.

---

# 8. User Workflow

Typical instructor workflow

Student

↓

Assessment

↓

AI Analysis

↓

Lesson Recommendation

↓

Instructor Review

↓

Teaching

↓

SOAP Notes

↓

Student History

↓

Next Lesson Recommendation

---

# 9. AI Principles

AI never invents knowledge.

AI reasons over structured data.

AI recommendations are editable.

AI recommendations are explainable.

AI continuously learns from historical teaching records.

---

# 10. Data Philosophy

Every entity inside the system has a unique identity.

Knowledge is version controlled.

Relationships are reusable.

Every object should be linked rather than duplicated.

The database is the single source of truth.

---

# 11. MVP Success Criteria

The MVP is complete when an instructor can:

- Create a student
- Complete an assessment
- Search movements
- Build a lesson
- Generate an AI lesson
- Record SOAP notes
- Generate a home exercise program
- View lesson history

All AI recommendations must be traceable to structured knowledge.

---

# 12. Long-term Roadmap

Phase 1

STOTT Pilates

Reformer Essential

---

Phase 2

Additional STOTT curricula

- Reformer Intermediate
- Matwork
- Cadillac
- Chair
- Barrels

---

Phase 3

Polestar Pilates

---

Phase 4

BASI Pilates

---

Phase 5

Multi-methodology AI

The instructor may choose a preferred teaching methodology when generating lessons.

---

# 13. Guiding Principle

MyPilates AI is not simply an AI application.

It is a professional Pilates knowledge platform.

Artificial intelligence is only one capability.

The true foundation of the product is structured knowledge.