#############################################
# Postgres
#############################################

# custom_pg_dump honeylogic-db.com postgres hodovi_cc 5432
function custom_pg_dump {
  rm -rf $PWD/db_dump/*
  docker run -v $PWD/db_dump:/data/db_dump/ -i --rm --entrypoint='' --net=host postgres:11.5-alpine pg_dump -h $1 -U $2 -d $3 -p $4 -F d -f /data/db_dump
}

function pg_drop_db {
  dc exec postgres psql -U postgres -c "DROP DATABASE $1;"
}

function pg_create_db {
  dc exec postgres psql -U postgres -c "CREATE DATABASE $1;"
}

function pg_create_extension {
  dc exec postgres psql -U postgres -c "CREATE EXTENSION pg_trgm;"
}

function pg_create_user {
  dc exec postgres psql -U postgres -c "CREATE USER $1;"
}

function custom_pg_restore {
  dc exec postgres pg_restore --clean -d $1 -h 0.0.0.0 -U postgres /tmp/db_dump/
}

function pg_drop_and_restore {
  local pg_container=$(docker-compose ps postgres | awk 'NR>2 {print $1}' | tr -d '\n')

  if pg_drop_db $pg_container $1 ; then
    echo "Dropped database"
  fi
  if pg_create_db $pg_container $1 ; then
    echo "Created database"
  fi
  if ./manage.py migrate ; then
    echo "Ran Migrations"
  fi
  if custom_pg_restore $1 ; then
    echo "Restored DB"
  fi
}

