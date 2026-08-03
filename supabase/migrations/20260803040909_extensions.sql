create extension if not exists pgcrypto;

do $block$
begin
  if exists (
    select 1
    from pg_available_extensions
    where name = 'vector'
  ) then
    create extension if not exists vector;
  end if;
end
$block$;
