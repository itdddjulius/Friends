DROP ROLE IF EXISTS rails_docker;
CREATE ROLE rails_docker LOGIN PASSWORD 'rails_docker';
ALTER USER rails_docker WITH SUPERUSER;
