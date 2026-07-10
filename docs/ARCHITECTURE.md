# Architecture

## Stack
- **Frontend:** Next.js 14 (App Router) on Vercel
- **Database + Auth:** Supabase (Postgres + RLS + Supabase Auth added in lock-down sprint)
- **AI:** OpenAI GPT-4o or Anthropic Claude via server-side Next.js API route (key never in client)
- **Export:** Client-side clipboard API + plain-text file download

## What to Build Now vs Later
**Now:** campaign form → AI generation → edit → export (all five content types, brand voice, seed demo data)
**Next:** auth + per-user RLS, content calendar, PDF export, regenerate single piece
**Later:** scheduling integrations, template library by modality, analytics

## Key User Action — Step by Step
1. Healer fills New Campaign form (offering details + brand voice selection)
2. Form POSTs to `/api/generate-campaign` (server route — AI key stays server-side)
3. Server builds prompt from offering + brand voice; calls AI API
4. Response parsed into 5 typed content pieces; each saved to `content_pieces` table with `source`, `confidence`, `review_status = 'unreviewed'`
5. Campaign detail page fetches pieces from Supabase and renders them
6. Healer edits inline; save writes `edited_value` and sets `review_status = 'approved'`
7. Export collects all pieces (preferring `edited_value` over `content_value`) and downloads

## Layer Order
1. **Data** — tables + RLS + seed rows (app runs and is browsable)
2. **App logic** — forms, CRUD, campaign detail (works without AI)
3. **Intelligence** — AI generation endpoint plugged in on top

Core CRUD functions correctly even if the AI endpoint is disabled or returns an error.
