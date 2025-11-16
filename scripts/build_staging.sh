#!/bin/bash

# EventHub Build Script for Staging Environment
# Usage: ./scripts/build_staging.sh [platform] [build-type]
# Platform: android, ios, web (default: android)
# Build Type: debug, release (default: release)

set -e

PLATFORM=${1:-android}
BUILD_TYPE=${2:-release}
FLAVOR="staging"
TARGET="lib/main_staging.dart"

echo "🚀 Building EventHub for Staging Environment"
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
    echo "📱 Building Android APK..."
    if [ "$BUILD_TYPE" = "release" ]; then
      flutter build apk --flavor $FLAVOR --target $TARGET --release
      echo "✅ APK built successfully!"
      echo "📍 Location: build/app/outputs/flutter-apk/app-$FLAVOR-release.apk"
    else
      flutter build apk --flavor $FLAVOR --target $TARGET --debug
      echo "✅ Debug APK built successfully!"
      echo "📍 Location: build/app/outputs/flutter-apk/app-$FLAVOR-debug.apk"
    fi
    ;;
  "ios")
    echo "📱 Building iOS app..."
    if [ "$BUILD_TYPE" = "release" ]; then
      flutter build ios --flavor $FLAVOR --target $TARGET --release --no-codesign
      echo "✅ iOS app built successfully!"
      echo "📍 Open ios/Runner.xcworkspace in Xcode to archive and distribute"
    else
      echo "🏃 Running iOS simulator..."
      flutter run --flavor $FLAVOR --target $TARGET --debug
    fi
    ;;
  "web")
    echo "🌐 Building Web app..."
    flutter build web --target $TARGET
    echo "✅ Web app built successfully!"
    echo "📍 Location: build/web/"
    ;;
  *)
    echo "❌ Unsupported platform: $PLATFORM"
    echo "Supported platforms: android, ios, web"
    exit 1
    ;;
esac

echo ""
echo "🎉 Build completed successfully!"