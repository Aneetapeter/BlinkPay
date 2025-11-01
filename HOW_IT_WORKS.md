# 🎯 BlinkPay - How It Works

## Overview
BlinkPay is a Flutter-based payment application that provides a comprehensive digital payment solution.

## App Flow Summary

### 1. **Entry Point** → Splash Screen (3 seconds)
- Animated bank Lottie animation
- "WELCOME TO BLINK PAY" text with animations
- Auto-navigates to Logo Page

### 2. **Logo Page** → Authentication Choice
- User chooses to Login or Sign Up

### 3. **Sign Up** → Create Account
- Email (must end with @gmail.com)
- Mobile (10 digits)
- Password (8-12 characters)
- Stores credentials in SharedPreferences

### 4. **Login** → Authenticate
- Email or Phone + Password
- Validates against stored credentials

### 5. **Profile Setup** → User Information
- First Name, Last Name
- UPI ID
- Profile Picture (optional)

### 6. **Home Page** → Main Dashboard
- 19+ payment features in grid layout
- Recently used features (up to 6)
- Rotating advertisements
- Search, notifications, profile access

### 7. **Features** → Individual Services
- Each feature has dedicated page
- Tracks usage in "Recently Used"

## Key Technologies
- **Flutter**: Cross-platform framework
- **Lottie**: Animations
- **SharedPreferences**: Local storage
- **Material Design**: UI components

## Data Storage
All user data stored locally using SharedPreferences:
- Credentials (email, phone, password)
- Profile info (name, UPI ID)
- Profile image path

## Theme Support
- Light Mode: White background, blue accents
- Dark Mode: Black background, indigo accents
- Toggle available on most screens

## Features List (19 total)
1. Scan QR Code
2. Pay Anyone
3. Bank Transfer
4. Mobile Recharge
5. DTH/TV Recharge
6. Electricity Bill
7. Postpaid Bill
8. Loan EMI
9. Broadband Bill
10. Credit Card Bill
11. Google Play
12. Rewards
13. Offers
14. Referrals
15. Gift Cards
16. Subscriptions
17. CIBIL Score Check
18. Transaction History
19. Bank Balance Check

## Running the App

```bash
# Install dependencies
flutter pub get

# Run on web
flutter run -d chrome

# Run on mobile
flutter run
```

## Note
This is a demo application. For production use, integrate with:
- Backend API for authentication
- Real payment gateways
- Secure data storage
- Proper error handling
