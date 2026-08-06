# 05_KnowledgeStandard.md

Version: 1.0.0

Status: Stable

Owner: Xinlei Hu

Last Updated: 2026-08-05

---

# MyPilatesStudio Knowledge Standard

## Purpose

This document defines the standard representation of all Pilates knowledge used by MyPilatesStudio.

The purpose is to ensure that every movement, cue, assessment, condition, progression, and teaching recommendation follows the same structure regardless of Pilates methodology.

The Knowledge Standard is independent of:

- STOTT Pilates
- BASI Pilates
- Polestar Pilates
- Balanced Body
- Future methodologies

Different methodologies may provide different content, but all knowledge must follow the same data structure.

Only knowledge that may vary between methodologies, evolve over time, or require evidence should include a Source reference. Static properties and AI-generated metadata do not require source attribution.只有可能因教学体系不同、随着时间变化或需要证据支持的知识，才需要记录来源（Source）。固定属性和 AI 自动生成的元数据无需记录来源。

---

# Design Principles

The knowledge base should satisfy the following principles.

## 1. Knowledge Before Interface

The website is only one way to use the knowledge.

The knowledge must remain independent of:

- Website
- Mobile App
- AI Model
- Database

---

## 2. One Concept = One Canonical Object

Every Pilates concept should have exactly one canonical record.

Examples:

Movement

Cue

Equipment

Muscle

Condition

Assessment

Teaching Goal

Breathing Pattern

This avoids duplicate knowledge.

---

## 3. Structured Before Text

Knowledge should always be stored as structured data whenever possible.

Preferred

✓ equipment_id

✓ body_position

✓ difficulty

✓ cue_type

Avoid

Large paragraphs that AI cannot reason about.

---

## 4. Relationships Are First-Class

Knowledge is represented by relationships instead of long descriptions.

Example:

Movement

↓

Uses Equipment

↓

Reformer

Movement

↓

Targets

↓

Hip Extension

Movement

↓

Contraindicated For

↓

Acute Lumbar Disc Herniation

---

## 5. Multi-language Support

Every user-facing field should support multiple languages.

Minimum:

Chinese

English

Future:

Japanese

Korean

Spanish

---

## 6. AI Friendly

Every knowledge object should be understandable by an AI model.

Objects should be:

Atomic

Consistent

Searchable

Composable

Traceable

---

# Knowledge Layers

Knowledge is divided into multiple layers.

Layer 1

Movement Knowledge

Exercises

Movement Variations

Movement Phases

Movement Goals

Movement Progressions

Movement Regressions

---

Layer 2

Teaching Knowledge

Instructor Cue

Observation

Correction

Common Errors

Teaching Tips

Teaching Sequence

---

Layer 3

Clinical Knowledge

Indications

Contraindications

Pain Management

Pregnancy

Postpartum

Posture

Rehabilitation

Risk Factors

---

Layer 4

Student Knowledge

Assessment

Lesson History

Feedback

Performance

Restrictions

Goals

Progress

---

Layer 5

AI Knowledge

Search Metadata

Embedding Metadata

Recommendation Rules

Lesson Planning Rules

Knowledge Relationships

---

# Canonical Knowledge Object

Every knowledge object should contain the following metadata.

ID

Code

Canonical Name

Display Name

Description

Category

Subcategory

Version

Status

Source

Language

Created At

Updated At

---

# Knowledge Relationships

Knowledge objects may be connected using relationships.

Supported relationship types include:

Uses Equipment

Requires Principle

Targets Muscle

Mobilizes Joint

Strengthens Muscle

Stretches Muscle

Improves Condition

Contraindicated For

Progresses To

Regresses To

Alternative Of

Part Of

Recommended For

Avoid When

Requires Skill

Requires Assessment

---

# Knowledge Sources

Every knowledge object must record its origin.

Examples:

STOTT Pilates Essential Reformer

STOTT Pilates Intermediate Reformer

Polestar Pilates

Original Clinical Knowledge

Studio Teaching Experience

Internal AI Recommendation

Research Literature

Every source should include:

Source Name

Edition

Year

Copyright Status

License Status

Confidence Level

---

# Data Quality Rules

Every knowledge object must satisfy the following rules.

Completeness

No duplicated concepts

Consistent naming

Unique IDs

Traceable sources

Relationship validation

Version history

Review status

---

# Copyright

MyPilatesStudio does not store copyrighted materials as its own intellectual property.

The system stores structured knowledge extracted from legally owned learning resources together with internally created teaching knowledge.

Every knowledge object should retain source attribution.

---

# Future Expansion

The Knowledge Standard is designed to support multiple Pilates methodologies.

Examples include:

STOTT Pilates

Polestar Pilates

Balanced Body

BASI Pilates

Classical Pilates

Future methodologies should extend the knowledge base without changing the standard.

---

End of Document
