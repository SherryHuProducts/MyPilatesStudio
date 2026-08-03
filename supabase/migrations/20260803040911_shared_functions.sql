create or replace function public.set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $function$
begin
  new.updated_at = now();
  return new;
end;
$function$;

comment on function public.set_updated_at() is
  'Sets a row updated_at value to the current timestamp before an update.';
