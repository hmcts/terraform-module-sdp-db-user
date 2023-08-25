#!/usr/bin/env bash

export AZURE_CONFIG_DIR=~/.azure-db-manager
az login --identity

# shellcheck disable=SC2155

## Delay until DB DNS and propagated 
COUNT=0;
MAX=10;
while true; do
   ping -c 1 $DB_HOST_NAME &>/dev/null
   if [[ $? -eq 0 ]]; then
      break
   fi
   if [[ $COUNT -eq $MAX ]]; then
      break
   else
      COUNT=$[$COUNT+1]
   fi
   sleep 5
done

export PGPASSWORD=$DB_PASSWORD

SDP_SQL_COMMAND="
DO
\$do\$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_catalog.pg_roles WHERE rolname = '${DB_SDP_USER}') THEN

      CREATE USER \"${DB_SDP_USER}\" WITH PASSWORD '${DB_SDP_PASS}';

   END IF;

   ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO PUBLIC;
   REVOKE CREATE ON SCHEMA public FROM public;
   GRANT USAGE ON SCHEMA public TO \"${DB_SDP_USER}\";
   GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"${DB_SDP_USER}\";
END
\$do\$;
"

if [[ ${DB_ADD_SDP_USER} == "true" ]]; then
  psql "sslmode=require host=${DB_HOST_NAME} port=5432 dbname=${DB_NAME} user='${DB_ADMIN}'" -c "${SDP_SQL_COMMAND}"
fi
