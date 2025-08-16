# Laravel Docker Environment

A complete Docker-based development environment for Laravel applications with nginx, PHP 8.4, MySQL, Redis, phpMyAdmin, and Node.js.

## 🚀 Quick Start

### Prerequisites
- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/) installed
- Git (for cloning repositories)

### 1. Clone and Setup

```bash
# Clone your project or create new directory
git clone git@github.com:maztch/laravel-docker.git laravel-docker
cd laravel-docker

# make scripts executable
chmod +x scripts/*

# Run the setup script
./scripts/setup
```

Laravel is ready for you: Visit [http://localhost](http://localhost)

### 2. Install Laravel (manual setup)

If you don't have an existing Laravel project, you can create a new one:

**Option A: Use the setup script (recommended)**
```bash
# The setup script will detect if Laravel is missing and guide you
./scripts/setup

# If Laravel is not found, it will ask you for a fresh install
```

**Option B: Use your existing Laravel project directly in src/**
```bash
# Copy your Laravel project in src/ directory
cp -r /your/laravel/* src/
cp -r /tmp/laravel/.* src/ 2>/dev/null || true

# Start containers
docker compose up -d
```


**Option C: Manual installation**
```bash
# Start containers
docker compose up -d

# Install Laravel in src/ directory
./scripts/composer create-project laravel/laravel . --prefer-dist

# Set proper permissions
sudo chown -R $USER:$USER .
chmod -R 755 storage bootstrap/cache
```

### 3. Configure Laravel Environment

If you have done a manual install or using an existing project you may need to configure it and/or install dependencies. If you used the setup with a fresh install it's already configured and ready to use.

```bash
# Copy environment file (if not already done)
cp src/.env.example src/.env

# Generate application key
./scripts/artisan key:generate

# Install composer dependencies
./scripts/composer install

# Update database settings in src/.env (should already be correct)
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel_user
DB_PASSWORD=laravel_password

REDIS_HOST=redis
REDIS_PASSWORD=null
REDIS_PORT=6379

CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis

# Run initial migrations
./scripts/artisan migrate
```

### 4. Install Frontend Dependencies
```bash
# Install NPM packages
./scripts/npm install

# Start development server (optional)
./scripts/npm run dev
```

### 5. Access Your Application
- **Laravel App**: http://localhost
- **Vite Dev Server**: http://localhost:5173 (with hot reload)
- **phpMyAdmin**: http://localhost:8080

## 📁 Project Structure

```
project/
├── .env                     # Docker Compose configuration
├── docker-compose.yml       # Container orchestration
├── scripts/                 # Helper scripts for development
│   ├── artisan              # Laravel Artisan commands
│   ├── composer             # Composer package manager
│   ├── npm                  # Node.js package manager
│   ├── php                  # PHP interpreter
│   ├── mysql                # MySQL client
│   ├── redis                # Redis client
│   ├── crontab              # Cron service for schedule
│   ├── queue                # Laravel job queue
│   ├── logs                 # View container logs
│   ├── setup                # Initial setup script
|   └── reset                # This scripts restarts all project
├── docker/                  # Docker configuration files
│   ├── nginx/               # Nginx configuration
│   ├── php/                 # PHP-FPM configuration
│   ├── mysql/               # MySQL configuration
│   └── redis/               # Redis configuration
└── src/                     # Your Laravel application goes here
    ├── .env                 # Laravel environment variables
    ├── app/
    ├── config/
    └── ...
```

## 🆕 Starting a New Laravel Project

If you're starting from scratch without an existing Laravel application:

### Complete Fresh Installation
```bash
# 1. Clone or create project directory
git clone git@github.com:maztch/laravel-docker.git my-laravel-project
cd my-laravel-project

# 2. Start Docker containers
docker compose up -d

# 3. Create Laravel project
./scripts/composer create-project laravel/laravel src --prefer-dist

# 4. Set permissions (Linux/macOS)
sudo chown -R $USER:$USER src/
chmod -R 755 src/storage src/bootstrap/cache

# 5. Configure environment
cp src/.env.example src/.env
./scripts/artisan key:generate

# 6. Update database config in src/.env
sed -i 's/DB_HOST=127.0.0.1/DB_HOST=mysql/' src/.env
sed -i 's/DB_DATABASE=laravel/DB_DATABASE=laravel/' src/.env
sed -i 's/DB_USERNAME=root/DB_USERNAME=laravel_user/' src/.env
sed -i 's/DB_PASSWORD=/DB_PASSWORD=laravel_password/' src/.env

# Add Redis config to src/.env
echo "" >> src/.env
echo "REDIS_HOST=redis" >> src/.env
echo "REDIS_PASSWORD=null" >> src/.env
echo "REDIS_PORT=6379" >> src/.env
echo "" >> src/.env
echo "CACHE_DRIVER=redis" >> src/.env
echo "SESSION_DRIVER=redis" >> src/.env
echo "QUEUE_CONNECTION=redis" >> src/.env

# 7. Run migrations
./scripts/artisan migrate

# 8. Install frontend dependencies
./scripts/npm install

# 9. Start development
./scripts/npm run dev
```

## 🐳 Services

| Service | Container | Port | Purpose |
|---------|-----------|------|---------|
| **Nginx** | `laravel_nginx` | 80, 443 | Web server & reverse proxy |
| **PHP** | `laravel_php` | 9000 | PHP 8.4-FPM application server |
| **MySQL** | `laravel_mysql` | 3306 | Database server |
| **Redis** | `laravel_redis` | 6379 | Cache & session storage |
| **phpMyAdmin** | `laravel_phpmyadmin` | 8080 | Database management |
| **Node.js** | `laravel_node` | 3000, 5173 | Frontend asset compilation |
| **Queue** | `laravel_queue` | - | Laravel queue worker |
| **Scheduler** | `laravel_scheduler` | - | Laravel task scheduler |

## ⚙️ Configuration

### Environment Variables
The root `.env` file controls Docker Compose settings:

```env
# Project Configuration
COMPOSE_PROJECT_NAME=laravel-app

# Service Versions
PHP_VERSION=8.4
MYSQL_VERSION=8.0
NODE_VERSION=18-alpine

# Database Settings
MYSQL_DATABASE=laravel
MYSQL_USER=laravel_user
MYSQL_PASSWORD=laravel_password
MYSQL_ROOT_PASSWORD=root_password

# Port Configuration
HTTP_PORT=80
MYSQL_PORT=3306
PHPMYADMIN_PORT=8080
VITE_PORT=5173
```

### Laravel Configuration
The `src/.env` file contains your Laravel application settings:

```env
DB_HOST=mysql
DB_DATABASE=laravel
DB_USERNAME=laravel_user
DB_PASSWORD=laravel_password

REDIS_HOST=redis
CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
```

## 🛠️ Development Workflow

### Daily Development
```bash
# Start all services
docker compose up -d

# Start frontend development server
./scripts/npm run dev

# Watch logs
./scripts/logs php
```

### Laravel Commands
```bash
# Run Artisan commands
./scripts/artisan migrate
./scripts/artisan make:controller UserController
./scripts/artisan tinker

# Composer operations
./scripts/composer install
./scripts/composer require laravel/sanctum

# Clear application cache
./scripts/artisan cache:clear
./scripts/artisan config:clear
```

### Frontend Development
```bash
# Install NPM dependencies
./scripts/npm install

# Start development server with hot reload
./scripts/npm run dev

# Build for production
./scripts/npm run build

# Run linting
./scripts/npm run lint
```

### Database Operations
```bash
# Connect to MySQL shell
./scripts/mysql

# Create database dump
./scripts/mysql dump

# Import SQL file
./scripts/mysql import backup.sql

# Run migrations
./scripts/artisan migrate

# Seed database
./scripts/artisan db:seed
```

### Cache Operations
```bash
# Connect to Redis CLI
./scripts/redis

# Clear Redis cache
./scripts/redis flushdb

# Monitor Redis commands
./scripts/redis monitor
```

## 🔧 Advanced Usage

### Custom Commands
All scripts support direct command execution:

```bash
# Direct PHP execution
./scripts/php -v

# Custom Composer commands  
./scripts/composer show --outdated

# Custom NPM commands
./scripts/npm audit

# Custom Artisan commands
./scripts/artisan route:list
```

### Container Management
```bash
# Start specific services
docker compose up -d nginx php mysql

# Rebuild containers
docker compose up -d --build

# Stop all services
docker compose down

# View running containers
docker compose ps

# Follow logs for specific service
./scripts/logs nginx -f
```

### Production Deployment
```bash
# Build production assets
./scripts/npm run build

# Optimize Composer autoloader
./scripts/composer install --no-dev --optimize-autoloader

# Cache Laravel configuration
./scripts/artisan config:cache
./scripts/artisan route:cache
./scripts/artisan view:cache
```

## 📊 Monitoring & Debugging

### View Logs
```bash
# All services
./scripts/logs all

# Specific service
./scripts/logs php
./scripts/logs nginx
./scripts/logs mysql

# Last 50 lines without following
./scripts/logs php --tail 50 --no-follow
```

### Performance Monitoring
```bash
# Redis info
./scripts/redis info

# MySQL processes
./scripts/mysql -e "SHOW PROCESSLIST;"

# Container resource usage
docker stats
```

### Common Debugging
```bash
# Check Laravel logs
./scripts/logs php

# Test database connection
./scripts/artisan tinker
# > DB::connection()->getPdo();

# Check queue jobs
./scripts/artisan queue:work --once

# Verify Redis connection
./scripts/redis ping
```

## 🔒 Security Considerations

### Production Setup
1. Change default passwords in `.env`
2. Use strong `MYSQL_ROOT_PASSWORD`
3. Configure SSL certificates in `docker/nginx/ssl/`
4. Set `APP_ENV=production` in Laravel `.env`
5. Use `APP_DEBUG=false` in production

### SSL Configuration
Place SSL certificates in `docker/nginx/ssl/` and update nginx configuration.

## 🐛 Troubleshooting

### Common Issues

**Port Already in Use**
```bash
# Change ports in .env file
HTTP_PORT=8080
MYSQL_PORT=3307
```

**Permission Denied**
```bash
# Make scripts executable
chmod +x scripts/*

# Fix Laravel storage permissions
./scripts/artisan storage:link
sudo chown -R www-data:www-data src/storage src/bootstrap/cache
```

**Database Connection Failed**
```bash
# Check if MySQL is running
./scripts/logs mysql

# Verify credentials in src/.env match docker .env
```

**Node Modules Issues**
```bash
# Clear node modules and reinstall
./scripts/npm run clean
./scripts/npm install
```

### Reset Environment
```bash
# Complete reset
docker compose down -v
docker compose up -d --build
./scripts/artisan migrate:fresh --seed
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📝 License

This project is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).

---

## 🎯 What's Included

✅ **Laravel-ready environment** with PHP 8.4  
✅ **Frontend tooling** with Vite and hot reload  
✅ **Database management** with MySQL and phpMyAdmin  
✅ **Caching** with Redis  
✅ **Queue processing** and task scheduling  
✅ **Development scripts** for common tasks  
✅ **Production-ready** configurations  
✅ **SSL support** ready to configure  
✅ **Environment-based** configuration  

---

**Happy coding! 🚀**

For more detailed information about individual scripts, see [`scripts/README.md`](scripts/README.md).