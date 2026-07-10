# Data Model

## brand_voices
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | owner, set at lock-down sprint |
| created_at | timestamptz | |
| practitioner_name | text | |
| modality | text | e.g. "Sound Healing" |
| tone | text | e.g. "warm, grounded" |
| keywords | text[] | inject into prompts |
| avoid_phrases | text[] | negative prompt list |
| about_blurb | text | practitioner bio used in email/copy |

## offerings
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| created_at | timestamptz | |
| offering_type | text | workshop / service / product |
| name | text | |
| description | text | |
| target_audience | text | |
| scheduled_date | date nullable | |
| price_display | text nullable | |
| location_or_format | text nullable | |
| brand_voice_id | uuid FK → brand_voices | |

## campaigns
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| created_at | timestamptz | |
| offering_id | uuid FK → offerings | |
| title | text | |
| status | text | draft / ready / exported |
| exported_at | timestamptz nullable | |

## content_pieces
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| created_at | timestamptz | |
| campaign_id | uuid FK → campaigns | |
| piece_type | text | instagram_caption / carousel_copy / reel_script / whatsapp_broadcast / email |
| content_value | text | **AI-generated value** |
| content_source | text | "ai_generated" or "manual" |
| content_confidence | numeric | 0–1, model self-score |
| review_status | text | unreviewed / approved / rejected |
| edited_value | text nullable | user's edited version |
| word_count | integer nullable | |

## audit_logs
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| created_at | timestamptz | |
| action | text | e.g. generate_campaign, edit_piece, export_campaign |
| object_type | text | |
| object_id | uuid | |
| payload | jsonb | request summary, never raw AI key |

**RLS:** All tables have open v1 read+write policies. Lock-down sprint replaces with `auth.uid() = user_id`.
