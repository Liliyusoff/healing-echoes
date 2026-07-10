# Tasks & Sprints

## Sprint 1 — Database, seed data, campaign list and detail pages
**Goal:** App is browsable with realistic data. No login required.

- [ ] Run migration SQL against Supabase project
- [ ] Verify seed data visible in Supabase table editor
- [ ] Build `/campaigns` page: list all campaigns, show title + status + offering name
- [ ] Build `/campaigns/[id]` detail page: show all content pieces grouped by type
- [ ] Loading state: skeleton cards while fetching
- [ ] Empty state: "No campaigns yet — create your first one" with CTA button
- [ ] Error state: banner if Supabase fetch fails
- [ ] Confirm seeded campaign detail renders all 5 piece types correctly

**Definition of Done:** Opening `/campaigns` in a browser with no login shows 3 demo campaigns. Clicking one shows all its content pieces. Empty and error states render correctly.

---

## Sprint 2 — Core engine: campaign creation + AI generation ✦ v1 functional milestone
**Goal:** A healer can create a campaign and get 5 generated content pieces stored in the DB.

- [ ] Build `/campaigns/new` form: offering type, name, description, audience, date, price, format, brand voice selector
- [ ] On submit: write `offering` row + `campaign` row to Supabase
- [ ] POST to `/api/generate-campaign`: build prompt from offering + brand voice; call AI API (server-side)
- [ ] Parse AI JSON response into 5 typed content pieces
- [ ] Write each piece to `content_pieces` with `source`, `confidence`, `review_status`
- [ ] Redirect to campaign detail page; pieces load from DB (not from in-memory response)
- [ ] Edit-in-place for each piece: textarea saves `edited_value`, sets `review_status = 'approved'`
- [ ] Export button: downloads all pieces as `.txt` file (prefers `edited_value`)
- [ ] AI error state: if generation fails, campaign row saved, error banner shown, retry button available
- [ ] Write audit_log row for generate and export actions

**Definition of Done:** Fill form → click Generate → 5 pieces appear on detail page → edit caption → reload page → edited text persists → export downloads correct file. All steps verified against live Supabase data, not seed rows.

---

## Sprint 3 — Brand voice settings + content refinement
**Goal:** Generations sound like the practitioner, not generic AI.

- [ ] Build `/brand-voice` settings page: all brand_voice fields, save to Supabase
- [ ] Brand voice selector on New Campaign form populated from saved voices
- [ ] Inject brand voice fields into AI prompt
- [ ] Regenerate single piece button: calls `/api/regenerate-piece`, shows new version inline, confirm to save
- [ ] Word count displayed on each piece
- [ ] Campaign status transitions: draft → ready → exported (explicit button per state)
- [ ] Empty state for brand voice page: "Set up your voice first" prompt

**Definition of Done:** Create a brand voice with specific keywords → generate campaign → at least 3 of the 5 pieces contain at least one of the saved keywords. Regenerate one piece → new text appears → confirm → DB row updated.

---

## Sprint 4 — Lock it down (auth + per-user RLS)
**Goal:** Each practitioner sees only their own data.

- [ ] Enable Supabase Auth; add email/password sign-up and login pages
- [ ] Set `user_id = auth.uid()` on all inserts
- [ ] Replace v1 open RLS policies with `auth.uid() = user_id` owner-scoped policies
- [ ] Public `/` landing page remains accessible without login (shows demo campaign screenshot, not live data)
- [ ] Authenticated routes redirect to `/login` if session absent
- [ ] Test: logged-in user A cannot read or write user B's rows (confirm via Supabase policy check + manual test)

**Definition of Done:** Two test accounts created. Each sees only their own campaigns. Cross-user fetch returns 0 rows. No secrets in client bundle.

---

## Sprint 5 — Content calendar + export polish
**Goal:** Healer can see all upcoming content at a glance and export cleanly.

- [ ] `/calendar` page: monthly grid, content pieces plotted by campaign scheduled_date
- [ ] Campaign duplication: copy offering + campaign + pieces as new draft
- [ ] PDF export of full campaign (html-to-pdf or print CSS)
- [ ] Onboarding checklist for new users: set brand voice → create first campaign

**Definition of Done:** Calendar shows pieces on correct dates. Duplicate campaign creates new rows in DB. PDF downloads with all 5 pieces formatted.

---

## Gantt (sprint → feature)
```
Sprint 1  |  DB migration · seed data · campaign list · campaign detail
Sprint 2  |  New campaign form · AI generation · edit · export · audit log   ← v1 functional
Sprint 3  |  Brand voice page · prompt injection · regenerate piece · word count
Sprint 4  |  Auth · per-user RLS · login/signup · lock-down
Sprint 5  |  Content calendar · duplication · PDF export · onboarding
```
