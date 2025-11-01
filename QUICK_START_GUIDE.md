# 🚀 BlinkPay - Quick Start Guide

## 📋 Prerequisites

Before running the BlinkPay app, ensure you have:

- **Flutter SDK** installed (version >=3.3.0 <4.0.0)
- **Chrome** browser (for web version)
- **Android Studio** or **Xcode** (for mobile)
- **Git** (optional, for version control)

---

## ⚡ Quick Start (3 Steps)

### Step 1: Install Dependencies
```bash
flutter pub get
```

### Step 2: Run the App
```bash
# For Web (Chrome)
flutter run -d chrome

# For Mobile (connected device)
flutter run

# For specific device
flutter devices  # List available devices
flutter run -d <device-id>
```

### Step 3: Test the App
- Watch the splash screen animation
- Sign up with a new account
- Login and explore features

---

## 🌐 Running on Different Platforms

### **Web Browser**
```bash
# Development mode
flutter run -d chrome

# Build for production
flutter build web

# Serve the built web app
cd build/web
python3 -m http.server 8000
# Open http://localhost:8000
```

### **Android**
```bash
# Debug mode
flutter run

# Release APK
flutter build apk --release

# Install APK
flutter install
```

### **iOS** (macOS only)
```bash
# Debug mode
flutter run

# Release build
flutter build ios --release
```

### **Windows**
```bash
flutter run -d windows
flutter build windows
```

### **macOS**
```bash
flutter run -d macos
flutter build macos
```

### **Linux**
```bash
flutter run -d linux
flutter build linux
```

---

## 🧪 Testing the App

### **Test Credentials**
After signing up, use these credentials to test:

**Sign Up Example:**
- Email: `test@gmail.com`
- Mobile: `1234567890`
- Password: `password123`

**Login:**
- Email/Phone: `test@gmail.com` or `1234567890`
- Password: `password123`

### **Profile Setup:**
- First Name: `John`
- Last Name: `Doe`
- UPI ID: `john@okbank`

---

## 🎯 Feature Testing Checklist

- [ ] Splash screen animation plays
- [ ] Theme toggle works (Light/Dark)
- [ ] Sign up with valid credentials
- [ ] Login with created account
- [ ] Profile setup dialog appears
- [ ] Upload profile picture
- [ ] View all 19 features on home page
- [ ] Click on any feature
- [ ] Search for features
- [ ] View notifications
- [ ] Check recently used section
- [ ] Logout functionality

---

## 🐛 Troubleshooting

### **Issue: Flutter command not found**
```bash
# Check Flutter installation
flutter --version

# If not installed, download from:
# https://flutter.dev/docs/get-started/install
```

### **Issue: Dependencies not resolving**
```bash
# Clean and reinstall
flutter clean
flutter pub get
```

### **Issue: Web not working**
```bash
# Enable web support
flutter config --enable-web

# Check devices
flutter devices
```

### **Issue: Hot reload not working**
```bash
# Press 'r' in terminal for hot reload
# Press 'R' for hot restart
# Press 'q' to quit
```

### **Issue: Build errors**
```bash
# Clean build
flutter clean
flutter pub get
flutter run
```

---

## 📦 Project Structure

```
blinkpay/
├── lib/
│   ├── main.dart              # App entry point
│   ├── splash_screen.dart     # Splash screen
│   ├── logo_page.dart         # Logo page
│   ├── login_page.dart        # Login screen
│   ├── signup_page.dart       # Sign up screen
│   ├── home_page.dart         # Main dashboard
│   ├── feature_page.dart      # Feature details
│   ├── profile_page.dart      # User profile
│   ├── notifications_page.dart # Notifications
│   └── forgot_password_page.dart # Password reset
├── assets/
│   ├── animations/
│   │   ├── bank.json          # Lottie animation
│   │   └── logo.json          # Logo animation
│   └── images/
│       └── blink_logo.png     # App logo
├── android/                   # Android config
├── ios/                       # iOS config
├── web/                       # Web config
├── windows/                   # Windows config
├── macos/                     # macOS config
├── linux/                     # Linux config
├── pubspec.yaml              # Dependencies
└── README.md                 # Documentation
```

---

## 🔧 Development Commands

```bash
# Hot reload (during development)
r

# Hot restart
R

# Quit
q

# Clear screen
c

# Open DevTools
d

# List running devices
flutter devices

# Check for issues
flutter doctor

# Analyze code
flutter analyze

# Format code
flutter format .

# Run tests
flutter test
```

---

## 🎨 Customization Tips

### **Change Theme Colors**
Edit `lib/main.dart`:
```dart
primarySwatch: Colors.blue,  // Change to your color
```

### **Modify Features**
Edit `lib/home_page.dart`:
```dart
final Map<String, IconData> _features = {
  'Your Feature': Icons.your_icon,
  // Add more features
};
```

### **Update Splash Duration**
Edit `lib/splash_screen.dart`:
```dart
Future.delayed(const Duration(seconds: 3), () {
  // Change seconds value
});
```

---

## 📱 Device Testing

### **Test on Physical Device**

**Android:**
1. Enable Developer Options on phone
2. Enable USB Debugging
3. Connect via USB
4. Run `flutter run`

**iOS:**
1. Connect iPhone via USB
2. Trust computer on device
3. Run `flutter run`

### **Test on Emulator**

**Android Emulator:**
```bash
# List emulators
flutter emulators

# Launch emulator
flutter emulators --launch <emulator-id>

# Run app
flutter run
```

**iOS Simulator:**
```bash
# Open simulator
open -a Simulator

# Run app
flutter run
```

---

## 🌐 Web Deployment

### **Deploy to Firebase Hosting**
```bash
# Build
flutter build web

# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize
firebase init hosting

# Deploy
firebase deploy
```

### **Deploy to Vercel**
```bash
# Build
flutter build web

# Install Vercel CLI
npm install -g vercel

# Deploy
vercel --prod
```

### **Deploy to GitHub Pages**
```bash
# Build
flutter build web --base-href "/your-repo/"

# Copy to docs folder
cp -r build/web/* docs/

# Commit and push
git add .
git commit -m "Deploy to GitHub Pages"
git push
```

---

## 📊 Performance Tips

1. **Use Release Mode for Testing**
   ```bash
   flutter run --release
   ```

2. **Profile Performance**
   ```bash
   flutter run --profile
   ```

3. **Analyze Bundle Size**
   ```bash
   flutter build apk --analyze-size
   ```

4. **Check for Issues**
   ```bash
   flutter doctor -v
   ```

---

## 🔐 Security Notes

⚠️ **Important**: This is a demo app. For production:

- Replace SharedPreferences with secure backend API
- Implement proper authentication (OAuth, JWT)
- Use encrypted storage for sensitive data
- Add SSL/TLS for network requests
- Implement proper error handling
- Add rate limiting and security headers
- Use environment variables for API keys

---

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)
- [Material Design Guidelines](https://material.io/design)
- [Flutter Community](https://flutter.dev/community)

---

## 🆘 Getting Help

- **Flutter Issues**: https://github.com/flutter/flutter/issues
- **Stack Overflow**: https://stackoverflow.com/questions/tagged/flutter
- **Discord**: https://discord.gg/flutter
- **Reddit**: https://reddit.com/r/FlutterDev

---

## ✅ Verification Checklist

Before considering the app ready:

- [ ] All dependencies installed
- [ ] App runs without errors
- [ ] Splash screen displays correctly
- [ ] Sign up/Login works
- [ ] Profile setup functional
- [ ] All features accessible
- [ ] Theme switching works
- [ ] Search functionality works
- [ ] Notifications page loads
- [ ] Profile page accessible
- [ ] Logout works correctly
- [ ] Data persists after restart
- [ ] Responsive on different screens
- [ ] No console errors
- [ ] Smooth animations

---

**Happy Coding! 🚀**

For issues or questions, check the troubleshooting section above.
