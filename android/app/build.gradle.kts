plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.eventhub.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.eventhub.app.dev"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        resValue("string", "app_name", "EventHub Dev")
    }

    flavorDimensions += "default"
    productFlavors {
        create("development") {
            dimension = "default"
            applicationId = "com.eventhub.app.dev"
            versionNameSuffix = "-dev"
            resValue("string", "app_name", "EventHub Dev")
        }
        create("staging") {
            dimension = "default"
            applicationId = "com.eventhub.app.staging"
            versionNameSuffix = "-staging"
            resValue("string", "app_name", "EventHub Staging")
        }
        create("production") {
            dimension = "default"
            applicationId = "com.eventhub.app"
            resValue("string", "app_name", "EventHub")
        }
    }

    buildTypes {
        debug {
            isDebuggable = true
            signingConfig = signingConfigs.getByName("debug")
        }
        release {
            isDebuggable = false
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
