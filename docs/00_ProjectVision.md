# MyPilates AI

Version: 1.0.0

Status: Draft

Owner: Xinlei Hu

Technical Architect: AI Engineering Documentation/ChatGPT

Last Updated: 2026-07-24

---

# Vision

Build the best AI-powered Pilates Operating System for professional Pilates instructors.

The system is designed to help instructors make better clinical decisions, create personalized lesson plans, manage students, and continuously improve teaching quality through structured knowledge and artificial intelligence.

MyPilates AI is not a chatbot.

It is an AI Teaching Operating System.

---

# Mission

Transform professional Pilates knowledge into a structured, searchable, and continuously evolving knowledge system.

Every lesson should be:

- Personalized
- Explainable
- Evidence-informed
- Repeatable
- Continuously optimized

The platform should reduce lesson planning time while improving teaching consistency and student outcomes.

---

# Long-term Goal

Create the world's most comprehensive Pilates knowledge platform.
The platform is methodology-agnostic. It supports multiple teaching methodologies and curricula through a unified data model.
The platform should support:

- STOTT Pilates
- Classical Pilates
- BASI Pilates
- Balanced Body
- Polestar Pilates

The architecture must remain methodology-independent so that additional teaching systems can be added without redesigning the database.

---

# Product Philosophy

Knowledge First.

Data Second.

AI Third.

User Experience Fourth.

AI should never generate recommendations without structured knowledge.
Every AI recommendation must be traceable to data stored inside the system.

---

# Product Principles

## 1. Knowledge Driven

Every recommendation comes from structured knowledge.
The system should never rely only on prompting.

---

## 2. Instructor First

The instructor always makes the final decision.

AI assists.
AI never replaces professional judgement.

---

## 3. Explainable AI

Every recommendation should answer:

- Why was this movement selected?
- Which assessment supports this decision?
- Which teaching rule was applied?
- Which knowledge source was referenced?

The AI must always be able to explain its reasoning.

---

## 4. Continuous Learning

Student history improves future lesson planning.

Each completed lesson becomes new knowledge for future recommendations.

The system continuously evolves.

---

## 5. Standardized Data

Everything stored in the database must follow a predefined data standard.

No duplicated concepts.
No duplicated terminology.
No inconsistent naming.

---

# Target Users

Primary Users

- Professional Pilates Instructors
- Pilates Studio Owners
- Clinical Pilates Instructors

Future Users

- Multi-location studios
- Pilates education organizations
- Pilates certification programs

---

# MVP Scope

Version 1.0 includes:

✓ Movement Library

✓ Five Basic Principles

✓ Cue Library

✓ Student Management

✓ Assessment

✓ Lesson Planning

✓ AI Lesson Generator

✓ SOAP Notes

✓ Home Exercise Generator

---

# Out of Scope

Version 1.0 will NOT include:

- Online booking
- Payment system
- Live video classes
- Community
- Marketplace
- Instructor certification

These features may be considered after the teaching platform becomes stable.

---

# System Modules

Core Knowledge

- Movement Library
- Cue Library
- Five Principles
- Anatomy
- Conditions
- Posture
- Equipment

Teaching

- Assessment
- Lesson Planning
- Lesson History
- SOAP
- Home Exercise

Business

- Student
- Studio
- Instructor
- Reports

Artificial Intelligence

- Lesson Recommendation
- Progression Engine
- Clinical Reasoning
- Student Timeline
- Knowledge Graph

---

# Core Architecture

Knowledge Base

↓

Structured Database

↓

Knowledge Graph

↓

AI Reasoning Engine

↓

Lesson Generator

↓

Instructor

↓

Student

The AI must never bypass the knowledge layer.

---

# Design Principles

The system must satisfy the following requirements.

Scalable

Support thousands of students.

Maintainable

New movements can be added without changing the database.

Extensible

New Pilates systems can be integrated.

Auditable

Every recommendation should be traceable.

Versioned

Knowledge should support version control.

Secure

Student data must be protected.

---

# Success Metrics

The project succeeds when:

- An instructor can generate a personalized lesson in under one minute.

- Every lesson has a clear reasoning path.

- Student progress is measurable over time.

- Knowledge can continuously expand without redesign.

- New instructors can use the system with minimal training.

---

# Definition of Success

MyPilates AI is successful when it becomes the daily operating system for Pilates instructors rather than simply another AI tool.

The product should become the single source of truth for teaching knowledge, lesson planning, student management, and professional decision support.