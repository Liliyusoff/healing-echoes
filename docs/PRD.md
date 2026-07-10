# Healing Echoes — Product Requirements Document

## Problem
Independent healers and wellness practitioners spend hours writing marketing content from scratch, often settling for generic AI copy that doesn't sound like them. They need a tool they fully own that turns one offering into a complete, authentic campaign — fast.

## Target User
Sole-practitioner healers: Family Constellation facilitators, sound healers, somatic coaches, yoga teachers, energy workers, therapists. Solo operators, not agencies.

## Core Objects
- **Brand Voice** — practitioner name, modality, tone, keywords, avoid-phrases
- **Offering** — type (workshop / service / product), name, description, audience, date, price, format
- **Campaign** — groups all content pieces for one offering
- **Content Piece** — one generated asset (caption, carousel, Reel script, WhatsApp broadcast, email)

## MVP Must-Haves
- [ ] Create an offering (workshop, service, or product) via a form
- [ ] Generate all 5 content piece types in one click from offering details
- [ ] Brand voice settings injected into every generation
- [ ] Edit any generated piece and save edits to the database
- [ ] Export full campaign (copy-to-clipboard or text download)
- [ ] Campaign list and detail pages load with seed data — no login required
- [ ] Graceful error state if AI generation fails; partial results are saved

## Non-Goals (v1)
Social media scheduling, CRM, payments, booking, analytics dashboard, team/multi-user, course platform, community features.

## Success Criteria
**End-to-end scenario:** A healer opens the app, fills in the New Campaign form for a weekend workshop, clicks Generate, reviews five ready-to-use content pieces (Instagram caption, carousel copy, Reel script, WhatsApp broadcast, email), edits the caption, and exports the full campaign — in under 10 minutes. All five pieces are stored in the database and reflect the saved edits on reload.
