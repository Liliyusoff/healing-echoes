# Agentic Layer

## Risk Classification

### Low Risk — Auto-execute (no approval needed)
- `generate_campaign_content` — calls AI, stores results as `unreviewed`; fires on button click
- `score_content_piece` — assigns confidence score from AI response
- `log_action` — writes to audit_logs on every meaningful event

### Medium Risk — Show draft, user confirms before saving
- `regenerate_single_piece` — rewrites one content piece; shows diff before overwriting original
- `update_campaign_status` — draft → ready → exported; confirmed by explicit button

### High Risk — Always requires explicit user approval
- (v1 has no external sends — WhatsApp/email content is copy-paste only, no send action)
- **Future:** `send_whatsapp_broadcast` — approval required before any outbound message
- **Future:** `schedule_social_post` — approval required before publishing

### Human-Only (never automated)
- Deleting a campaign or content piece
- Any irreversible data removal

## Named Tools (server-side only)
- `tool:generate_campaign` — assembles prompt, calls AI API, parses structured JSON response
- `tool:save_content_pieces` — writes pieces to Supabase `content_pieces` table
- `tool:export_campaign` — collects pieces (edited_value preferred), formats for download
- `tool:write_audit_log` — appends to `audit_logs`; called after every tool execution

## Audit Log Fields
`action | object_type | object_id | user_id | created_at | payload (JSON summary)`
Payload never includes raw AI API key or full model response — only action summary and piece IDs.

## v1 vs Later
- **v1:** generate + save + export (low risk only)
- **Next:** regenerate single piece (medium risk, diff UI)
- **Later:** outbound send actions (high risk, approval gate)
