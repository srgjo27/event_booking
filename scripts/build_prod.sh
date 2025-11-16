#!/bin/bash

# EventHub Build Script for Production Environment
# Usage: ./scripts/build_prod.sh [platform] [build-type]
# Platform: android, ios, web (default: android)
# Build Type: release (only release builds for production)

set -e

PLATFORM=${1:-android}
BUILD_TYPE="release"
FLAVOR="production"
TARGET="lib/main_production.dart"

echo "🚀 Building EventHub for Production Environment"
echo "Platform: $PLATFORM"
echo "Build Type: $BUILD_TYPE"
echo "Flavor: $FLAVOR"
echo "Target: $TARGET"
echo ""

# Clean previous build
echo "🧹 Cleaning previous build..."
flutter clean
flutter pub get

case $PLATFORM in
  "android")
    echo "📱 Building Android APK for Production..."
    flutter build apk --flavor $FLAVOR --target $TARGET --release
    echo "✅ Production APK built successfully!"
    echo "📍 Location: build/app/outputs/flutter-apk/app-$FLAVOR-release.apk"
    
    echo ""
    echo "📦 Building Android App Bundle (AAB) for Play Store..."
    flutter build appbundle --flavor $FLAVOR --target $TARGET --release
    echo "✅ Production AAB built successfully!"
    echo "📍 Location: build/app/outputs/bundle/productionRelease/app-$FLAVOR-release.aab"
    ;;
  "ios")
    echo "📱 Building iOS app for Production..."
    flutter build ios --flavor $FLAVOR --target $TARGET --release --no-codesign
    echo "✅ Production iOS app built successfully!"
    echo "📍 Open ios/Runner.xcworkspace in Xcode to archive and distribute to App Store"
    ;;
  "web")
    echo "🌐 Building Web app for Production..."
    flutter build web --target $TARGET --release
    echo "✅ Production Web app built successfully!"
    echo "📍 Location: build/web/"
    ;;
  *)
    echo "❌ Unsupported platform: $PLATFORM"
    echo "Supported platforms: android, ios, web"
    exit 1
    ;;
esac

echo ""
echo "🎉 Production build completed successfully!"
echo "⚠️  Remember to test thoroughly before releasing to production!"