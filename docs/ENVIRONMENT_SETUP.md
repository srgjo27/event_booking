# Environment Setup Guide for EventHub

This document explains how to build and deploy EventHub for different environments: **Development**, **Staging**, and **Production**.

## 🏗️ Environment Configuration

### Available Environments

| Environment     | App Name         | Package ID                 | API Endpoint                       | Debug Mode |
| --------------- | ---------------- | -------------------------- | ---------------------------------- | ---------- |
| **Development** | EventHub Dev     | `com.eventhub.app.dev`     | `https://api-dev.eventhub.com`     | ✅ Yes     |
| **Staging**     | EventHub Staging | `com.eventhub.app.staging` | `https://api-staging.eventhub.com` | ✅ Yes     |
| **Production**  | EventHub         | `com.eventhub.app`         | `https://api.eventhub.com`         | ❌ No      |

## 🚀 Quick Start

### Running the App

Use the convenient run script:

```bash
# Development (default)
./scripts/run.sh
./scripts/run.sh dev

# Staging
./scripts/run.sh staging

# Production
./scripts/run.sh prod
```

### Manual Flutter Commands

```bash
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart
```

## 📱 Building for Distribution

### Development Build

```bash
# Android APK
./scripts/build_dev.sh android debug
./scripts/build_dev.sh android release

# iOS
./scripts/build_dev.sh ios debug
./scripts/build_dev.sh ios release

# Web
./scripts/build_dev.sh web
```

### Staging Build

```bash
# Android APK
./scripts/build_staging.sh android

# iOS
./scripts/build_staging.sh ios

# Web
./scripts/build_staging.sh web
```

### Production Build

```bash
# Android APK + AAB (Play Store)
./scripts/build_prod.sh android

# iOS (App Store)
./scripts/build_prod.sh ios

# Web (Production)
./scripts/build_prod.sh web
```

## 🔧 Manual Build Commands

### Android

```bash
# Development
flutter build apk --flavor development --target lib/main_development.dart

# Staging
flutter build apk --flavor staging --target lib/main_staging.dart

# Production APK
flutter build apk --flavor production --target lib/main_production.dart --release

# Production App Bundle (Play Store)
flutter build appbundle --flavor production --target lib/main_production.dart --release
```

### iOS

```bash
# Development
flutter build ios --flavor development --target lib/main_development.dart --no-codesign

# Staging
flutter build ios --flavor staging --target lib/main_staging.dart --no-codesign

# Production
flutter build ios --flavor production --target lib/main_production.dart --release --no-codesign
```

### Web

```bash
# Development
flutter build web --target lib/main_development.dart

# Staging
flutter build web --target lib/main_staging.dart

# Production
flutter build web --target lib/main_production.dart --release
```

## 📂 Project Structure

```
lib/
├── config/
│   ├── app_config.dart              # Base configuration class
│   ├── development_config.dart      # Development settings
│   ├── staging_config.dart          # Staging settings
│   └── production_config.dart       # Production settings
├── main.dart                        # Default entry (uses development)
├── main_development.dart            # Development entry point
├── main_staging.dart               # Staging entry point
└── main_production.dart            # Production entry point

scripts/
├── build_dev.sh                    # Build development version
├── build_staging.sh               # Build staging version
├── build_prod.sh                  # Build production version
└── run.sh                         # Quick run script

android/app/build.gradle.kts        # Android flavors configuration
ios/Flutter/Configs/               # iOS configuration files
```

## ⚙️ Configuration Details

### Android Configuration

Each flavor has its own:

- **Application ID**: Unique package identifier
- **App Name**: Display name in launcher
- **Version Suffix**: Helps identify build type

### iOS Configuration

Environment-specific xcconfig files:

- `Development.xcconfig`
- `Staging.xcconfig`
- `Production.xcconfig`

Each defines:

- Bundle identifier
- Display name
- Build settings

### App Configuration

The `AppConfig` class provides runtime configuration:

```dart
// Access current environment
print(AppConfig.instance.environment);
print(AppConfig.instance.baseUrl);
print(AppConfig.instance.isDebugMode);

// Environment checks
if (AppConfig.instance.isDevelopment) {
  // Development-specific code
}
```

## 🛠️ Development Workflow

1. **Local Development**: Use `./scripts/run.sh dev`
2. **Testing**: Use `./scripts/run.sh staging`
3. **QA/Testing**: Build staging version for testers
4. **Production**: Use production builds for app stores

## 📋 Deployment Checklist

### Before Production Release:

- [ ] Test all environments work correctly
- [ ] Verify API endpoints are correct
- [ ] Update version numbers in `pubspec.yaml`
- [ ] Test production build on physical devices
- [ ] Configure proper signing certificates
- [ ] Update app store metadata
- [ ] Prepare release notes

### Build Output Locations:

- **Android APK**: `build/app/outputs/flutter-apk/`
- **Android AAB**: `build/app/outputs/bundle/`
- **iOS**: Open `ios/Runner.xcworkspace` in Xcode
- **Web**: `build/web/`

## 🔍 Troubleshooting

### Common Issues:

1. **Flavor not found**: Ensure you're using the correct flavor name
2. **iOS build fails**: Check Xcode project settings and signing
3. **Android build fails**: Verify Gradle configuration
4. **App crashes**: Check environment configuration is properly initialized

### Debug Steps:

1. Run `flutter clean && flutter pub get`
2. Check the target file exists
3. Verify flavor configuration in build files
4. Check console output for specific errors

## 📞 Support

For issues with environment setup:

1. Check this documentation
2. Verify build scripts are executable: `chmod +x scripts/*.sh`
3. Ensure Flutter SDK is up to date: `flutter doctor`
4. Check flavor configuration matches this guide
