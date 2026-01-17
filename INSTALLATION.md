# Installation & Setup Guide - CurryFlow Restaurant App

## System Requirements

- **OS**: Windows 10+, macOS 10.13+, or Linux
- **RAM**: 4GB minimum (8GB recommended)
- **Disk Space**: 3GB free space
- **Internet**: Required for initial setup

## Step 1: Install Flutter

### Windows

1. Download Flutter SDK from [flutter.dev](https://flutter.dev/docs/get-started/install/windows)
2. Extract to a location (e.g., `C:\src\flutter`)
3. Add Flutter to PATH:
   - Open Environment Variables
   - Add `C:\src\flutter\bin` to System PATH
4. Verify installation:
   ```bash
   flutter --version
   ```

### macOS

```bash
# Using Homebrew
brew install flutter

# Verify
flutter --version
```

### Linux

```bash
# Download and extract
cd ~
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH (add to ~/.bashrc or ~/.zshrc)
export PATH="$PATH:$HOME/flutter/bin"

# Verify
flutter --version
```

## Step 2: Install Dependencies

### Android Setup (Windows/macOS/Linux)

1. Install Android Studio from [developer.android.com](https://developer.android.com/studio)
2. Run Flutter Doctor:
   ```bash
   flutter doctor
   ```
3. Accept Android licenses:
   ```bash
   flutter doctor --android-licenses
   ```

### iOS Setup (macOS only)

1. Install Xcode from App Store
2. Accept Xcode license:
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   ```

### Web Setup (Optional)

```bash
flutter config --enable-web
```

## Step 3: Clone/Open Project

```bash
# Navigate to project directory
cd "d:\PROJECTS\group\mobile application development\resturent app"

# Verify Flutter sees the project
flutter doctor
```

## Step 4: Install Project Dependencies

```bash
# Get all pub packages
flutter pub get

# Check if everything is correct
flutter doctor

# (Optional) Upgrade packages
flutter pub upgrade
```

## Step 5: Run the App

### On Emulator/Simulator

```bash
# List available devices
flutter devices

# Run on default device
flutter run

# Run on specific device
flutter run -d <device_id>
```

### On Physical Device

1. Enable Developer Mode on device
2. Connect via USB (with debugging enabled)
3. Run:
   ```bash
   flutter run
   ```

### On Web Browser

```bash
flutter run -d chrome
```

### On Windows Desktop (if enabled)

```bash
flutter run -d windows
```

## Step 6: Build for Release

### Android APK

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-app.apk
```

### Android App Bundle

```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
# Output: build/web/
```

## Troubleshooting

### Issue: "flutter: command not found"

**Solution**: Add Flutter to PATH
```bash
# macOS/Linux
export PATH="$PATH:$HOME/flutter/bin"

# Or add permanently to ~/.bashrc or ~/.zshrc
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
```

### Issue: "No devices found"

**Solution**: 
```bash
# Start Android emulator
emulator -list-avds
emulator -avd <emulator_name>

# Or connect physical device with USB debugging enabled
adb devices
```

### Issue: Gradle build issues

**Solution**:
```bash
flutter clean
flutter pub get
flutter run
```

### Issue: Pod install error (iOS)

**Solution**:
```bash
cd ios
rm -rf Pods
pod install
cd ..
flutter run
```

### Issue: "FLUTTER_ANDROID_HOME not set"

**Solution**: Set Android home
```bash
# Windows (PowerShell)
$env:ANDROID_HOME="C:\Users\<username>\AppData\Local\Android\sdk"

# macOS/Linux
export ANDROID_HOME=$HOME/Library/Android/sdk
```

## Development Workflow

### Hot Reload

During development, use hot reload for faster iteration:

```bash
flutter run
# Press 'r' to hot reload
# Press 'R' for hot restart
# Press 'q' to quit
```

### Debugging

Enable verbose logging:
```bash
flutter run -v
```

Use DevTools:
```bash
flutter pub global activate devtools
devtools
```

## Project Customization

### Change App Name

```bash
flutter pub run change_app_package_name:main com.example.curryflow
```

### Change App Icon

1. Replace `assets/icons/dreamflow_icon.jpg`
2. Run:
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

## Running Tests (Optional)

```bash
# Run all tests
flutter test

# Run specific test
flutter test test/widget_test.dart

# Generate coverage
flutter test --coverage
```

## Performance Optimization

### Enable Release Mode

```bash
flutter run --release
```

### Profile App

```bash
flutter run --profile
```

### Check Performance

```bash
flutter run -v --trace-skia
```

## Useful Commands

```bash
# Clean build
flutter clean

# Update packages
flutter pub upgrade

# Get outdated packages
flutter pub outdated

# Check code analysis
flutter analyze

# Format code
flutter format lib/

# Run static analysis
dart analyze lib/

# Check dependencies
flutter pub deps

# Downgrade packages
flutter pub downgrade

# Cache clean
flutter pub cache repair
```

## Common Errors & Solutions

| Error | Solution |
|-------|----------|
| `gradle build` fails | Run `flutter clean && flutter pub get` |
| Hot reload doesn't work | Do `flutter clean` and run again |
| Emulator not starting | Ensure virtualization is enabled in BIOS |
| Port 8080 in use | Kill process or use `--observed-pid` |
| Out of memory | Increase heap size: `flutter run --dart-define HEAP=2048m` |

## Next Steps

1. ✅ Install Flutter SDK
2. ✅ Install dependencies
3. ✅ Run `flutter pub get`
4. ✅ Set up emulator/device
5. ✅ Run `flutter run`
6. ✅ Test the app
7. 📝 Customize food items and colors
8. 🚀 Build for release

## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)
- [Material Design 3](https://m3.material.io/)
- [Provider Package](https://pub.dev/packages/provider)
- [GoRouter Package](https://pub.dev/packages/go_router)

## Support

For issues or questions:
1. Run `flutter doctor` for diagnostics
2. Check Flutter official documentation
3. Search existing GitHub issues
4. Review error messages carefully

---

**Happy Coding! 🚀**
