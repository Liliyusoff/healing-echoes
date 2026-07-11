-- Lock every application table to its authenticated owner.
-- Legacy demo rows have user_id IS NULL and intentionally become inaccessible.
do $$
declare table_name text;
begin
  foreach table_name in array array['brand_voices','offerings','campaigns','content_pieces','audit_logs'] loop
    execute format('alter table %I alter column user_id set default auth.uid()', table_name);
    execute format('drop policy if exists %I on %I', table_name || '_v1_read', table_name);
    execute format('drop policy if exists %I on %I', table_name || '_v1_write', table_name);
    execute format('drop policy if exists %I on %I', table_name || '_owner_select', table_name);
    execute format('drop policy if exists %I on %I', table_name || '_owner_insert', table_name);
    execute format('drop policy if exists %I on %I', table_name || '_owner_update', table_name);
    execute format('create policy %I on %I for select to authenticated using (auth.uid() = user_id)', table_name || '_owner_select', table_name);
    execute format('create policy %I on %I for insert to authenticated with check (auth.uid() = user_id)', table_name || '_owner_insert', table_name);
    if table_name <> 'audit_logs' then
      execute format('create policy %I on %I for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id)', table_name || '_owner_update', table_name);
    end if;
  end loop;
end $$;

-- Audit history is append-only. Delete access is intentionally absent everywhere.
