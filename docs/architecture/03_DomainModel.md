# MyPilates AI

# 03_DomainModel

Version: 1.0.0

Status: Draft

Owner: Xinlei Hu

Last Updated: 2026-08-03

---

> This document defines the business domain entities of MyPilatesStudio.

> It does not define how movement knowledge is represented.

> Detailed knowledge representation is defined in the Knowledge Standards.

# 1. Purpose

The Domain Model defines the core business concepts of MyPilates AI.

It answers three questions:

- What objects exist?
- What does each object represent?
- How are they related?

The Domain Model is independent of:

- Database design
- API implementation
- Frontend
- AI models

It represents the business language of the platform.

---

# 2. Core Principle

> Knowledge is the Product.
>
> AI is the Interface.

Professional knowledge is the foundation.

Student data provides context.

Teaching records capture history.

AI reasons over knowledge but never owns it.

---

# 3. Domain Overview

The system contains six core domains.

```text
Knowledge
Teaching
Student
Studio
AI
System
```

Each domain owns its own entities.

Relationships connect domains together.

---

# 4. Knowledge Domain

The Knowledge Domain stores professional Pilates knowledge.

It is the single source of truth for AI reasoning.

## Entities

### Methodology

Examples

- STOTT Pilates
- Polestar
- BASI
- Classical Pilates

Owns

- Curriculum
- Teaching Framework

---

### Curriculum

Examples

- Reformer Essential
- Reformer Intermediate
- Matwork Essential

Belongs to

- Methodology

Contains

- Movement Variants

---

### Teaching Framework

Examples

STOTT Five Basic Principles

Contains

- Teaching Principles

---

### Teaching Principle

Examples

- Breathing
- Pelvic Placement
- Rib Cage Placement
- Scapular Stabilization
- Head & Cervical Placement

Referenced by

- Movements
- Assessments
- Cues

---

### Movement Concept

Represents the universal identity of a movement.

Example

Footwork

Referenced by

- Movement Variants

---

### Movement Variant

Represents one teachable implementation.

Example

STOTT Footwork — Parallel Heels

References

- Movement Concept
- Curriculum
- Equipment
- Cue
- Anatomy
- Contraindication

---

### Cue

Represents one teaching instruction.

Examples

- Push through your heels.
- Lengthen your spine.

References

- Movement Variant
- Teaching Principle

---

### Equipment

Examples

- Reformer
- Cadillac
- Chair
- Barrel
- Mat

Referenced by

- Movement Variants

---

### Anatomy

Examples

- Gluteus Maximus
- Pelvis
- Scapula

Referenced by

- Movements
- Assessments

---

### Condition

Examples

- Pregnancy
- Osteoporosis
- Low Back Pain

Referenced by

- Contraindications
- Teaching Rules

---

### Contraindication

Defines situations where a movement should be modified or avoided.

Referenced by

- Movement Variant

---

# 5. Student Domain

The Student Domain stores individualized teaching information.

## Entities

### Student

Owns

- Assessments
- Lessons
- Goals
- Progress

---

### Assessment

Captures student evaluation.

References

- Student
- Assessment Template

Produces

- Findings

---

### Finding

Represents instructor interpretation.

Examples

- Limited hip extension
- Poor pelvic stability

Used by

- Lesson Builder
- AI

---

### Goal

Represents desired teaching outcome.

Examples

- Improve posture
- Reduce neck tension
- Improve balance

---

### Progress

Tracks change over time.

References

- Student
- Goal

---

# 6. Teaching Domain

The Teaching Domain records instructor work.

## Entities

### Lesson Plan

Represents planned teaching.

Contains

- Lesson Exercises

---

### Lesson Exercise

Represents one movement inside a lesson.

References

- Movement Variant

---

### Lesson Record

Represents what actually happened.

References

- Lesson Plan

---

### SOAP Note

Documents

- Subjective
- Objective
- Assessment
- Plan

---

### Home Program

Represents assigned homework.

Contains

- Home Exercises

---

# 7. Studio Domain

The Studio Domain manages business operations.

## Entities

### Studio

Owns

- Instructors
- Students

---

### Instructor

Creates

- Assessments
- Lessons
- SOAP Notes

Approves

- AI Recommendations

---

# 8. AI Domain

The AI Domain contains generated content.

AI never owns professional knowledge.

## Entities

### Recommendation

Examples

- Lesson Recommendation
- Cue Recommendation
- Home Program

---

### Evidence

Represents why AI made a recommendation.

May reference

- Assessment
- Goal
- Lesson History
- Teaching Rule
- Movement

---

### Explanation

Human-readable reasoning.

Explains

Why this recommendation exists.

---

# 9. System Domain

The System Domain supports platform operation.

## Entities

- User
- Role
- Permission
- Translation
- Audit Log

---

# 10. Domain Relationships

```text
Methodology
    │
    ├── Curriculum
    │       │
    │       └── Movement Variant
    │
    └── Teaching Framework
            │
            └── Teaching Principle

Movement Concept
        │
        └── Movement Variant
                │
                ├── Cue
                ├── Equipment
                ├── Anatomy
                ├── Contraindication
                └── Teaching Principle

Student
    │
    ├── Assessment
    │       └── Finding
    │
    ├── Goal
    ├── Lesson Plan
    ├── Lesson Record
    ├── SOAP Note
    └── Progress

Lesson Plan
    │
    └── Lesson Exercise
            │
            └── Movement Variant

AI Recommendation
    │
    ├── Evidence
    └── Explanation
```

---

# 11. Ownership Rules

Knowledge owns professional information.

Students own personal information.

Lessons own teaching history.

AI owns recommendations only.

Professional knowledge must never be stored inside AI outputs.

---

# 12. Design Rules

The Domain Model follows these principles.

## One Concept

One real-world concept equals one entity.

---

## Single Source of Truth

Every entity has one owner.

No duplicated knowledge.

---

## Methodology Agnostic

Support multiple Pilates methodologies.

Never hardcode STOTT.

---

## Explainable AI

Every recommendation must reference structured knowledge.

---

## Extensible

Adding Polestar or BASI must require new data, not new architecture.

---

# 13. MVP Scope

Version 1 implements:

Methodology

- STOTT Pilates

Curriculum

- Reformer Essential

Knowledge

- Movements
- Cues
- Teaching Principles
- Equipment
- Contraindications

Student

- Assessment
- Lesson
- SOAP
- Home Program

AI

- Lesson Recommendation
- Cue Recommendation

---

# 14. Future Expansion

Future versions may add:

- Additional STOTT curricula
- Polestar Pilates
- BASI Pilates
- Classical Pilates
- Computer Vision
- Voice Coaching
- Research Database
- Certification Platform

No redesign of the Domain Model should be required.

---

# 15. Final Principle

The Domain Model defines the language of MyPilates AI.

Everything else—

the database,

the API,

the frontend,

and AI—

must be built on top of this shared language.

---

## Related Documents

- 04_DatabaseDesign.md
- 05_KnowledgeStandard.md
- 06_MovementStandard.md
