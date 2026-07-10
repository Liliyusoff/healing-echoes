# Security

## Secret Handling
- AI API key stored in Vercel environment variable (`AI_API_KEY`) — server-side only
- Never referenced in any client component or exposed in API responses
- Supabase service role key used only in server API routes; anon key only in client
- All AI calls go through `/api/generate-campaign` — client never contacts AI provider directly

## Permission Model (v1 → lock-down)
- **v1:** Open RLS policies — all rows readable and writable by anyone (demo mode)
- **Lock-down sprint:** Replace with `auth.uid() = user_id` policies; every write sets `user_id = auth.uid()`
- `audit_logs` table append-only in production; no client-side delete permitted

## Approved Tools Rule
- Agent may only call named tools (`tool:generate_campaign`, `tool:save_content_pieces`, `tool:export_campaign`, `tool:write_audit_log`)
- No `run_any`, `eval`, or dynamic code execution
- Tool inputs validated server-side before AI call; response parsed against strict JSON schema before DB write

## Audit Principle
- Every campaign generation, piece edit, and export writes a row to `audit_logs`
- Audit rows are never deleted by the app
- If a future outbound action (send/schedule) is added, it must write to audit_log before and after execution

## What to Stop and Get Help With
- Outbound messaging (WhatsApp API, email SMTP) — do not implement without reviewing provider compliance requirements
- Payment handling — out of scope; never add without a dedicated security review
