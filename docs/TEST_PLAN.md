# Test Plan

## Core Success Scenario (manual, run after Sprint 2)

1. Open `/campaigns` — confirm 3 demo campaigns listed, no login required
2. Click demo campaign "Roots & Belonging" — confirm all 5 piece types render with text
3. Click "New Campaign"
4. Fill form: type=workshop, name="Moonrise Yoga Retreat", description (2–3 sentences), audience, date, price, select existing brand voice
5. Click Generate — loading state appears
6. Confirm redirect to new campaign detail page
7. Confirm all 5 pieces contain text (not placeholder "[ERROR]")
8. Open Supabase table editor → `content_pieces` → confirm 5 rows with correct `campaign_id`
9. Edit the Instagram caption inline → click Save
10. Hard-reload the page → confirm edited text persists (not original AI text)
11. Check `review_status = 'approved'` on edited piece in Supabase
12. Click Export → `.txt` file downloads → open file → confirm edited caption text appears (not original)
13. Open `audit_logs` in Supabase → confirm rows for `generate_campaign` and `export_campaign`

## Empty State Tests
- Delete all campaigns from Supabase → load `/campaigns` → "No campaigns yet" message and CTA visible
- Load `/campaigns/nonexistent-id` → 404 or "Campaign not found" message, no crash

## Error State Tests
- Disable AI API key in env → submit New Campaign form → error banner appears, campaign row saved in DB, retry button visible
- Disconnect network mid-edit → save attempt → error toast, data not silently lost

## Brand Voice Tests (Sprint 3)
- Create brand voice with keyword "sacred" → generate campaign → check that at least one piece contains "sacred"
- Add avoid-phrase "transformation guaranteed" → regenerate piece → confirm phrase absent

## Lock-Down Tests (Sprint 4)
- Create two accounts (A and B), each with one campaign
- Logged in as A: fetch `/campaigns` → only A's campaign visible
- Attempt direct Supabase query as A for B's campaign ID → returns 0 rows
- Log out → attempt to load `/campaigns/new` → redirected to `/login`
