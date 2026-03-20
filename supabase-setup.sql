-- ============================================================
-- Atlanta by the Sea — Supabase Setup
-- ============================================================
-- 1. Go to your Supabase project → SQL Editor → New query
-- 2. Paste this entire file and click Run
-- ============================================================

create table if not exists rooms (
  id       text primary key,
  name     text not null,
  status   text not null default 'Not Started',
  progress integer not null default 0,
  notes    text default ''
);

create table if not exists tasks (
  id      text primary key,
  name    text not null,
  room_id text,
  done    boolean not null default false
);

create table if not exists team_entries (
  id    text primary key,
  name  text not null,
  week  text not null default '',
  hours numeric not null default 0,
  notes text default ''
);

create table if not exists payments (
  id          text primary key,
  payee       text not null,
  description text default '',
  amount      numeric not null default 0,
  date        text default '',
  status      text not null default 'Owed'
);

create table if not exists materials (
  id       text primary key,
  name     text not null,
  room_id  text,
  quantity text default '',
  notes    text default '',
  bought   boolean not null default false
);

create table if not exists photos (
  id       text primary key,
  filename text default '',
  room_id  text,
  date     text default '',
  data_url text default ''
);

-- ── Row Level Security ────────────────────────────────────────
-- The app handles authentication client-side via passwords.
-- These policies allow the anon key to read and write everything.

alter table rooms         enable row level security;
alter table tasks         enable row level security;
alter table team_entries  enable row level security;
alter table payments      enable row level security;
alter table materials     enable row level security;
alter table photos        enable row level security;

create policy "public_access" on rooms        for all using (true) with check (true);
create policy "public_access" on tasks        for all using (true) with check (true);
create policy "public_access" on team_entries for all using (true) with check (true);
create policy "public_access" on payments     for all using (true) with check (true);
create policy "public_access" on materials    for all using (true) with check (true);
create policy "public_access" on photos       for all using (true) with check (true);

-- ── Done! ────────────────────────────────────────────────────
-- After running this, copy your Project URL and anon/public key
-- from: Settings → API → Project API keys
-- and paste them into the top of index.html:
--
--   const SUPABASE_URL = 'https://xxxx.supabase.co';
--   const SUPABASE_KEY = 'eyJ...';
