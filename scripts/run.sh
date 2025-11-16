#!/bin/bash

# EventHub Run Script - Easy development runner
# Usage: ./scripts/run.sh [environment]
# Environment: dev, staging, prod (default: dev)

set -e

ENVIRONMENT=${1:-dev}

echo "🚀 Running EventHub in $ENVIRONMENT environment"
echo ""

case $ENVIRONMENT in
  "dev"|"development")
    echo "🔧 Starting Development Environment..."
    flutter run --flavor development --target lib/main_development.dart
    ;;
  "staging"|"stage")
    echo "🧪 Starting Staging Environment..."
    flutter run --flavor staging --target lib/main_staging.dart
    ;;
  "prod"|"production")
    echo "🏭 Starting Production Environment..."
    flutter run --flavor production --target lib/main_production.dart --release
    ;;
  *)
    echo "❌ Unknown environment: $ENVIRONMENT"
    echo "Available environments: dev, staging, prod"
    exit 1
    ;;
esac