# 06_MovementStandard.md

Version: 1.0.0

Status: Stable

Owner: Xinlei Hu

Last Updated: 2026-08-05

---

# MyPilatesStudio Movement Standard

## Purpose

This document defines the canonical structure for every Pilates movement stored in MyPilatesStudio.

A Movement represents one exercise concept.

Different methodologies may teach different variations of the same movement, but every movement must follow the same data standard.

---

# Design Principles

Every movement should be:

- Atomic
- Reusable
- Searchable
- Versioned
- AI-readable
- Multi-language

---

# Movement Hierarchy

Curriculum

↓

Equipment

↓

Movement

↓

Movement Variant

↓

Movement Phase

↓

Teaching Cue

↓

Clinical Application

---

Example

STOTT

↓

Reformer Essential

↓

Footwork

↓

Toes Apart Heels Together

↓

Setup

↓

Press through both feet

↓

Suitable for beginners

---

# Canonical Movement Object

Every movement contains the following sections.

---

## 1. Identity

Required fields

movement_id

movement_code

canonical_name

display_name_en

display_name_zh

curriculum

level

equipment

category

subcategory

status

version

---

## 2. Overview

Purpose

Movement Description

Teaching Goal

Difficulty

Movement Type

Recommended Experience Level

---

## 3. Equipment

Equipment

Machine Settings

Spring Settings

Footbar

Headrest

Straps

Box

Accessories

Notes

---

## 4. Setup

Starting Position

Body Position

Hand Position

Foot Position

Pelvis Position

Spine Position

Scapula Position

Head Position

Breathing Preparation

---

## 5. Movement Variants

One movement may contain multiple variants.

Example

Footwork

Variant 1

Toes Apart Heels Together

Variant 2

Wrap Toes on Bar

Variant 3

Heels on Bar

Variant 4

High Half Toe

Variant 5

Lower & Lift

Each variant should have its own:

Starting Position

Movement

Cue

Errors

Clinical Notes

---

## 6. Movement Phases

Every variant should be divided into phases.

Typical phases

Preparation

Movement

Return

Completion

---

## 7. Breathing

Preparation Breath

Movement Breath

Return Breath

Breathing Notes

---

## 8. Teaching Cues

Cue objects are independent.

Each cue should contain

Cue

Cue Type

Body Region

Purpose

Timing

Priority

Language

Example

"Maintain neutral pelvis."

Body Region

Pelvis

Purpose

Stability

---

## 9. Observation Points

Instructor should observe

Alignment

Movement Quality

Breathing

Control

Balance

Range of Motion

Symmetry

Compensation

---

## 10. Common Errors

Each error should include

Error

Cause

Correction

Priority

---

## 11. Corrections

Verbal Cue

Tactile Cue

Visual Cue

Regression

Progression

---

## 12. Muscles

Primary Muscles

Secondary Muscles

Stabilizers

Mobilizers

Stretch Targets

---

## 13. Joints

Primary Joint Motion

Secondary Joint Motion

Joint Stability

Joint Mobility

---

## 14. STOTT Five Basic Principles

Each movement should indicate which principles are emphasized.

Breathing

Pelvic Placement

Rib Cage Placement

Scapular Movement

Head and Cervical Placement

Each principle should include

Priority

Teaching Notes

Common Errors

---

## 15. Movement Goals

Examples

Warm-up

Core Stability

Hip Mobility

Lower Limb Alignment

Shoulder Stability

Spinal Mobility

Balance

Coordination

Strength

Flexibility

---

## 16. Clinical Applications

Suitable Conditions

Contraindications

Pregnancy

Postpartum

Low Back Pain

Neck Pain

Shoulder Dysfunction

Hip Dysfunction

Knee Pain

Osteoporosis

Hypermobile Clients

Neurological Conditions

---

## 17. Progression

Harder movements

Prerequisites

Required skills

---

## 18. Regression

Simplified versions

Support methods

Reduced range

Alternative movement

---

## 19. Lesson Planning Metadata

Movement Stage

Beginning

Middle

End

Typical Repetitions

Typical Tempo

Typical Duration

Energy Demand

Difficulty Score

Teaching Priority

---

## 20. AI Metadata

Embedding Tags

Search Keywords

Clinical Tags

Teaching Tags

Movement Relationships

Recommended Next Movements

Prerequisite Movements

Alternative Movements

---

## 21. Source Information

Methodology

Curriculum

Edition

Page Number

Copyright Status

Evidence Level

Review Status

Reviewer

Last Review Date

---

# Relationships

Every movement may relate to

Equipment

Cue

Principle

Condition

Assessment

Lesson

Student Goal

Muscle

Joint

Teacher Feedback

Movement Variant

---

# Naming Rules

Movement Code

Uppercase

Example

REF-ESS-001

Variant

REF-ESS-001-V01

Cue

REF-ESS-001-C01

---

# Future Compatibility

This standard supports

STOTT Pilates

Polestar Pilates

Balanced Body

BASI Pilates

Classical Pilates

Future methodologies should add knowledge without changing this standard.

---

End of Document