# Flutter Setup Guide for Restaurant App

## Issue
`flutter: The term 'flutter' is not recognized...`

This means Flutter SDK is not installed or not in your system PATH.

---

## Solution 1: Install Flutter (Recommended)

### Step 1: Download Flutter
1. Go to **https://flutter.dev/docs/get-started/install/windows**
2. Click **"Download"** (Get the stable version)
3. Extract the ZIP file to a permanent location, e.g.:
   ```
   C:\flutter
   ```
   (Do NOT extract to a path with spaces)

### Step 2: Add Flutter to System PATH
1. Press **Win + X** → **Settings**
2. Search for **"Environment Variables"** → Click **"Edit the system environment variables"**
3. Click **"Environment Variables"** button
4. Under **User variables** or **System variables**, click **"New"**
5. **Variable name:** `FLUTTER_HOME`
6. **Variable value:** `C:\flutter` (or wherever you extracted it)
7. Click **OK**

8. Now find the **Path** variable and click **Edit**
9. Click **New** and add:
   ```
   C:\flutter\bin
   ```
10. Click **OK** on all dialogs

### Step 3: Verify Installation
Close PowerShell and open a **NEW** PowerShell window, then run:
```powershell
flutter --version
```

You should see the Flutter version info.

---

## Solution 2: Use Full Flutter Path (Quick Fix)
If you don't want to install, use the full path:

```powershell
"C:\flutter\bin\flutter" pub get
"C:\flutter\bin\flutter" run -d chrome
```

Replace `C:\flutter` with your actual Flutter installation path.

---

## Solution 3: Check if Flutter is Already Installed
Run this in PowerShell:

```powershell
where.exe flutter
```

If it returns a path, Flutter IS installed but not in your PATH. Add that path to your system environment variables.

---

## After Installation: Run the App

### 1. Get Dependencies
```powershell
cd "d:\PROJECTS\group\mobile application development\resturent app"
flutter pub get
```

### 2. Run on Web (Chrome)
```powershell
flutter run -d chrome
```

### 3. Run on Mobile (Android/iOS)
```powershell
flutter run -d physical-device
```

---

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| `flutter pub get` fails | Check internet, then run `flutter doctor` |
| Build fails with "Chrome not found" | Install Chrome or use `flutter run -d web` |
| "No devices found" | Connect Android phone or enable Android emulator |
| PATH not working | Restart your terminal/IDE after adding to PATH |

---

## Verify Installation Complete
After everything is set up, run:

```powershell
flutter doctor
```

This shows if all dependencies are installed. Look for ✓ (checkmarks) for required tools.

---

**Need Help?** Check https://flutter.dev/docs/get-started/install
