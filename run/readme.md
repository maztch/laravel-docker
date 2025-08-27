# Laravel Docker Scripts

This directory contains utility scripts to interact with your Docker containers easily.

## 🚀 Quick Start

Run the setup script to get everything ready:

```bash
./run/setup
```

## 📋 Available Scripts

### Core Laravel Scripts

- **`./run/artisan`** - Execute Laravel Artisan commands
- **`./run/composer`** - Run Composer commands
- **`./run/php`** - Execute PHP commands

### Frontend Development

- **`./run/npm`** - Run NPM commands

### Database & Cache

- **`./run/mysql`** - MySQL client and utilities
- **`./run/redis`** - Redis client and utilities

### Utilities

- **`./run/logs`** - View container logs
- **`./run/setup`** - Initial environment setup

---

## 🔧 Script Usage

### Artisan Commands
```bash
# Run migrations
./run/artisan migrate

# Create a controller
./run/artisan make:controller UserController

# Clear cache
./run/artisan cache:clear

# Interactive tinker shell
./run/artisan tinker

# List all commands (no arguments)
./run/artisan
```

### Composer Commands
```bash
# Install dependencies
./run/composer install

# Add new package
./run/composer require laravel/sanctum

# Update packages
./run/composer update

# Show help (no arguments)
./run/composer
```

### NPM Commands
```bash
# Install dependencies
./run/npm install

# Start development server
./run/npm run dev

# Build for production
./run/npm run build

# Show help (no arguments)
./run/npm
```

### PHP Commands
```bash
# Check PHP version
./run/php --version

# Run a PHP file
./run/php script.php

# Interactive PHP shell (no arguments)
./run/php
```

### MySQL Commands
```bash
# Connect to MySQL shell (no arguments)
./run/mysql

# Connect as root user
./run/mysql root

# Create database dump
./run/mysql dump

# Import SQL file
./run/mysql import backup.sql

# Show MySQL logs
./run/mysql logs
```

### Redis Commands
```bash
# Connect to Redis CLI (no arguments)
./run/redis

# Flush current database
./run/redis flush

# Flush all databases
./run/redis flushall

# Show Redis info
./run/redis info

# List all keys
./run/redis keys

# Monitor Redis commands
./run/redis monitor
```

### Logs Commands
```bash
# View PHP logs
./run/logs php

# View all service logs
./run/logs all

# View last 50 lines without following
./run/logs nginx --tail 50 --no-follow

# Show help (no arguments)
./run/logs
```

---

## 💡 Tips

### Make Scripts Executable
If you get permission denied errors:
```bash
chmod +x run/*
```

### Environment Variables
All scripts automatically load environment variables from the root `.env` file.

### Container Names
Scripts automatically detect container names based on your `COMPOSE_PROJECT_NAME` setting.

### Error Handling
Scripts will automatically start containers if they're not running.

---

## 🔍 Troubleshooting

### Container Not Found
If you get "container not found" errors:
```bash
# Check running containers
docker compose ps

# Start all services
docker compose up -d
```

### Permission Issues
```bash
# Fix script permissions
chmod +x run/*

# Fix Laravel storage permissions
./run/artisan storage:link
```

### Database Connection Issues
```bash
# Check MySQL logs
./run/logs mysql

# Restart MySQL container
docker compose restart mysql
```

---

## 🎯 Common Workflows

### Starting a New Day
```bash
docker compose up -d
./run/npm run dev
```

### Installing New Package
```bash
./run/composer require vendor/package
./run/artisan migrate  # if package has migrations
```

### Database Reset
```bash
./run/artisan migrate:fresh --seed
```

### Production Build
```bash
./run/npm run build
./run/composer install --no-dev --optimize-autoloader
```

### Debugging
```bash
./run/logs php           # Check PHP errors
./run/artisan tinker     # Interactive debugging
./run/mysql              # Check database
```