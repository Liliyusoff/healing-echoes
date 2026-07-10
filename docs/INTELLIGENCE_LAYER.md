# Intelligence Layer

## Messy Inputs the AI Must Handle
- Vague offering descriptions: "a healing day for women" → AI asks clarifying questions in prompt
- Missing dates or prices → AI omits or uses placeholder tokens `[DATE]` / `[PRICE]`
- Informal tone notes: "sound like me, not corporate" → mapped to brand voice tone field

## Prompt Structure (auto-assembled on server)
```json
{
  "practitioner": "Luna Rivera",
  "modality": "Family Constellation & Somatic Work",
  "tone": "warm, grounded, inviting",
  "keywords": ["healing", "belonging", "ancestral"],
  "avoid": ["hustle", "quick fix"],
  "offering_type": "workshop",
  "name": "Roots & Belonging",
  "description": "Full-day immersive...",
  "audience": "Adults feeling stuck in repeating patterns",
  "date": "16 August 2025",
  "price": "R1,200",
  "outputs_required": ["instagram_caption", "carousel_copy", "reel_script", "whatsapp_broadcast", "email"]
}
```

## Scoring (rule-based, v1)
- `content_confidence` set by model's self-reported score in structured JSON response
- If confidence < 0.7 → piece flagged as `review_status = 'unreviewed'` with yellow UI indicator
- If confidence ≥ 0.85 → auto-marked `review_status = 'approved'` but user can override

## What Gets Ranked
- Pieces shown in fixed order: caption → carousel → Reel → WhatsApp → email
- Later: rank by estimated engagement potential (rule-based word-count + CTA presence score)

## v1 vs Later
- **v1:** Single prompt → 5 pieces; rule-based confidence threshold
- **Next:** Regenerate individual piece; A/B variant generation
- **Later:** Learn from user edits to improve voice matching; modality-specific templates
