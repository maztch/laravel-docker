-- docker/postgresql/init/01-init.sql
-- PostgreSQL initialization script

-- Create extensions that might be useful for Laravel
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
CREATE EXTENSION IF NOT EXISTS "unaccent";

-- Set default timezone
SET timezone = 'UTC';

-- Grant necessary permissions
GRANT ALL PRIVILEGES ON DATABASE laravel TO laravel_user;