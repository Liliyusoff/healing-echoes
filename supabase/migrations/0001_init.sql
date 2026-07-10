create table if not exists brand_voices (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  practitioner_name text not null default '',
  modality text not null default '',
  tone text not null default '',
  keywords text[] not null default '{}',
  avoid_phrases text[] not null default '{}',
  about_blurb text not null default ''
);

alter table brand_voices enable row level security;
drop policy if exists "brand_voices_v1_read" on brand_voices;
create policy "brand_voices_v1_read" on brand_voices for select using (true);
drop policy if exists "brand_voices_v1_write" on brand_voices;
create policy "brand_voices_v1_write" on brand_voices for all using (true) with check (true);

create table if not exists offerings (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  offering_type text not null default 'workshop',
  name text not null default '',
  description text not null default '',
  target_audience text not null default '',
  scheduled_date date,
  price_display text,
  location_or_format text,
  brand_voice_id uuid references brand_voices(id)
);

alter table offerings enable row level security;
drop policy if exists "offerings_v1_read" on offerings;
create policy "offerings_v1_read" on offerings for select using (true);
drop policy if exists "offerings_v1_write" on offerings;
create policy "offerings_v1_write" on offerings for all using (true) with check (true);

create table if not exists campaigns (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  offering_id uuid references offerings(id),
  title text not null default '',
  status text not null default 'draft',
  exported_at timestamptz
);

alter table campaigns enable row level security;
drop policy if exists "campaigns_v1_read" on campaigns;
create policy "campaigns_v1_read" on campaigns for select using (true);
drop policy if exists "campaigns_v1_write" on campaigns;
create policy "campaigns_v1_write" on campaigns for all using (true) with check (true);

create table if not exists content_pieces (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  campaign_id uuid references campaigns(id),
  piece_type text not null default '',
  content_value text not null default '',
  content_source text not null default 'ai_generated',
  content_confidence numeric not null default 0.8,
  review_status text not null default 'unreviewed',
  edited_value text,
  word_count integer
);

alter table content_pieces enable row level security;
drop policy if exists "content_pieces_v1_read" on content_pieces;
create policy "content_pieces_v1_read" on content_pieces for select using (true);
drop policy if exists "content_pieces_v1_write" on content_pieces;
create policy "content_pieces_v1_write" on content_pieces for all using (true) with check (true);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  action text not null,
  object_type text not null,
  object_id uuid,
  payload jsonb
);

alter table audit_logs enable row level security;
drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);
drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

insert into brand_voices (id, practitioner_name, modality, tone, keywords, avoid_phrases, about_blurb) values
  ('a1000000-0000-0000-0000-000000000001', 'Luna Rivera', 'Family Constellation & Somatic Work', 'warm, grounded, inviting', ARRAY['healing', 'belonging', 'ancestral', 'embodied'], ARRAY['hustle', 'transformation guaranteed', 'quick fix'], 'Luna holds space for deep systemic healing, drawing on Family Constellation and somatic practices to help people find belonging and release generational patterns.'),
  ('a1000000-0000-0000-0000-000000000002', 'Kai Okafor', 'Sound Healing & Breathwork', 'poetic, spacious, heart-centred', ARRAY['resonance', 'breath', 'ceremony', 'stillness'], ARRAY['productivity hack', 'results', 'perform'], 'Kai guides sound journeys and breathwork ceremonies that open the body to deep rest and energetic recalibration.');

insert into offerings (id, brand_voice_id, offering_type, name, description, target_audience, scheduled_date, price_display, location_or_format) values
  ('b1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'workshop', 'Roots & Belonging — Family Constellation Day', 'A full-day immersive workshop exploring family systems, ancestral patterns and the healing power of belonging. Participants set up constellations and witness systemic movements toward resolution.', 'Adults feeling stuck in repeating patterns, estrangement or unexplained grief', '2025-08-16', 'R1,200 / €60', 'In-person, Cape Town'),
  ('b1000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000002', 'service', 'Private Sound Journey & Integration Session', 'A 90-minute one-on-one sound bath using crystal bowls, tuning forks and guided breath. Followed by 30 minutes of integration coaching.', 'Individuals seeking deep nervous system reset and emotional release', NULL, 'R900 / €45', 'Online or Johannesburg studio'),
  ('b1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000001', 'workshop', 'Women''s Somatic Circle — Monthly Gathering', 'Monthly half-day gathering for women to reconnect with body wisdom through somatic movement, sharing and gentle constellation work.', 'Women seeking community and embodied healing', '2025-07-26', 'R450 / €22', 'In-person, Cape Town');

insert into campaigns (id, offering_id, title, status) values
  ('c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'Roots & Belonging — August Campaign', 'ready'),
  ('c1000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000002', 'Private Sound Journey — Evergreen Campaign', 'draft'),
  ('c1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000003', 'Women''s Circle — July Launch', 'ready');

insert into content_pieces (campaign_id, piece_type, content_value, content_source, content_confidence, review_status, word_count) values
  ('c1000000-0000-0000-0000-000000000001', 'instagram_caption', 'Some patterns aren''t ours to carry — they were handed down before we had words. 🌿 On August 16 I''m holding a full-day Family Constellation workshop in Cape Town where we gently lay those burdens down and find our way back to belonging. If something in you is already leaning forward, trust that. Link in bio to reserve your place. #FamilyConstellations #AncestralHealing #BelongingIsABirthright', 'ai_generated', 0.87, 'approved', 72),
  ('c1000000-0000-0000-0000-000000000001', 'carousel_copy', 'Slide 1: You are not just yourself. You carry your family.\nSlide 2: Family Constellation work makes the invisible visible — loyalties, exclusions, traumas that ripple through generations.\nSlide 3: In one day you can feel the shift: a burden lifted, a belonging restored.\nSlide 4: Roots & Belonging Workshop · Cape Town · 16 August · R1,200\nSlide 5: DM me "ROOTS" or tap the link in bio to book your place.', 'ai_generated', 0.82, 'approved', 68),
  ('c1000000-0000-0000-0000-000000000001', 'reel_script', 'HOOK (0–3s): "What if the sadness you carry… isn''t yours?"\nBODY (3–25s): Show a hand placing a stone down. Voiceover: "Family Constellation work reveals the hidden loyalties and unspoken stories that live in our bodies. In a single day, something can shift — not because we force it, but because we finally see it."\nCTA (25–30s): "Roots & Belonging Workshop, Cape Town, August 16. Link in bio."', 'ai_generated', 0.79, 'unreviewed', 75),
  ('c1000000-0000-0000-0000-000000000001', 'whatsapp_broadcast', 'Hi ✨ I wanted to reach out personally about something I''m holding next month.\n\nOn 16 August I''m running a full-day Family Constellation workshop in Cape Town — Roots & Belonging.\n\nIt''s a space for anyone who feels caught in repeating patterns, unexplained grief, or a sense of not quite fitting in.\n\nCost: R1,200. Spaces are limited to keep it intimate.\n\nReply to this message if you''d like details or to reserve your place. 🌿', 'ai_generated', 0.85, 'approved', 88),
  ('c1000000-0000-0000-0000-000000000001', 'email', 'Subject: Something I want you to know about August 16\n\nHi [First Name],\n\nI''ve been sitting with what to write to you, and I keep coming back to this: some of what we carry was never ours to carry.\n\nFamily Constellation work has shown me, again and again, that when we make the invisible visible — the loyalties, the exclusions, the losses that weren''t mourned — something in the system can finally breathe.\n\nOn August 16 I''m holding a full-day Roots & Belonging workshop in Cape Town. It''s intimate, in-person, and held with great care.\n\nInvestment: R1,200\nDate: Saturday 16 August\nLocation: Cape Town (address shared on booking)\n\nIf this is calling you, I''d love to hold space for you. You can reserve your place here: [LINK]\n\nWith warmth,\nLuna', 'ai_generated', 0.88, 'approved', 155),
  ('c1000000-0000-0000-0000-000000000002', 'instagram_caption', 'Your nervous system remembers everything your mind has tried to forget. 🔔 A private Sound Journey gives it permission to let go — gently, on its own terms. 90 minutes of crystal bowls, tuning forks and guided breath, followed by integration. Available online or in Johannesburg. DM me to book. #SoundHealing #NervousSystemReset #SoundBath', 'ai_generated', 0.83, 'unreviewed', 55),
  ('c1000000-0000-0000-0000-000000000003', 'instagram_caption', 'Your body knows things your mind is still catching up to. 🌙 The Women''s Somatic Circle returns on 26 July — a half-day of movement, sharing and gentle constellation work for women ready to come home to themselves. Cape Town. R450. Tap the link in bio to join us. #WomensCircle #SomaticHealing #EmbodiedWisdom', 'ai_generated', 0.86, 'approved', 57);