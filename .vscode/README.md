# VS Code Configuration untuk EventHub

## 🔍 Masalah yang Ditemukan

Ketika menggunakan **Run and Debug** di VS Code, error terjadi karena:

1. **VS Code menjalankan `flutter run` tanpa flavor**
2. **Android build membutuhkan flavor yang spesifik** (development/staging/production)
3. **Script `./run.sh` berhasil karena menggunakan `--flavor development`**

## ✅ Solusi yang Diterapkan

### 1. File `.vscode/launch.json`

Dibuat konfigurasi launch untuk setiap environment:

- **EventHub Development** - menggunakan `main_development.dart` + flavor `development`
- **EventHub Staging** - menggunakan `main_staging.dart` + flavor `staging`
- **EventHub Production** - menggunakan `main_production.dart` + flavor `production`
- **EventHub (Default main.dart)** - menggunakan `main.dart` + flavor `development`

### 2. File `.vscode/settings.json`

Menambahkan pengaturan default:

```json
"dart.flutterRunAdditionalArgs": [
    "--flavor",
    "development"
]
```

## 🚀 Cara Menggunakan di VS Code

### Opsi 1: Menggunakan Launch Configuration

1. Tekan `F5` atau pilih **Run and Debug**
2. Pilih konfigurasi yang diinginkan dari dropdown:
   - "EventHub Development" (recommended)
   - "EventHub Staging"
   - "EventHub Production"

### Opsi 2: Run dengan Default Settings

Sekarang ketika Anda menekan `F5` dengan file `main.dart` terbuka, VS Code akan otomatis menggunakan `--flavor development`.

## 🔧 Penjelasan Teknis

**Mengapa script berhasil:**

```bash
flutter run --flavor development --target lib/main_development.dart
```

**Mengapa VS Code gagal (sebelum fix):**

```bash
flutter run lib/main.dart  # Tanpa --flavor
```

**Setelah fix VS Code:**

```bash
flutter run --flavor development lib/main.dart
```

## 💡 Tips

- Gunakan launch configuration "EventHub Development" untuk development sehari-hari
- Gunakan "EventHub Staging" untuk testing
- Gunakan "EventHub Production" hanya untuk final testing sebelum release
