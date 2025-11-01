# 📊 BlinkPay - Visual App Flow Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           BLINKPAY APP FLOW                                  │
└─────────────────────────────────────────────────────────────────────────────┘

                              ┌──────────────┐
                              │   APP START  │
                              └──────┬───────┘
                                     │
                                     ▼
                        ┌────────────────────────┐
                        │   SPLASH SCREEN        │
                        │  ─────────────────     │
                        │  • Lottie Animation    │
                        │  • "WELCOME TO         │
                        │     BLINK PAY"         │
                        │  • Theme Toggle 🌓     │
                        │  • 3 second timer      │
                        └────────┬───────────────┘
                                 │ (Auto-navigate after 3s)
                                 ▼
                        ┌────────────────────────┐
                        │    LOGO PAGE           │
                        │  ─────────────────     │
                        │  • BlinkPay Logo       │
                        │  • Get Started Button  │
                        └────────┬───────────────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
                    ▼                         ▼
        ┌───────────────────┐     ┌───────────────────┐
        │   SIGN UP PAGE    │     │   LOGIN PAGE      │
        │  ───────────────  │     │  ───────────────  │
        │  📧 Email         │◄────┤  👤 Email/Phone   │
        │  📱 Mobile        │     │  🔒 Password      │
        │  🔒 Password      │     │                   │
        │  🔒 Confirm Pass  │     │  • Forgot Pass?   │
        │                   │     │  • Sign up link   │
        │  [Sign Up Button] │────►│  [Login Button]   │
        └─────────┬─────────┘     └─────────┬─────────┘
                  │                         │
                  │ (After signup)          │ (After login)
                  └────────────┬────────────┘
                               │
                               ▼
                  ┌────────────────────────┐
                  │  PROFILE SETUP DIALOG  │
                  │  ──────────────────    │
                  │  📷 Upload Photo       │
                  │  👤 First Name         │
                  │  👤 Last Name          │
                  │  💳 UPI ID             │
                  │  [Save Button]         │
                  └────────┬───────────────┘
                           │
                           ▼
        ┌──────────────────────────────────────────────────┐
        │              HOME PAGE (Dashboard)                │
        │  ──────────────────────────────────────────────  │
        │                                                   │
        │  ┌─────────────────────────────────────────────┐ │
        │  │ 👤 Hey [Name]  | 🔔 | 🔍 | ⚙️              │ │
        │  │ UPI: your-upi@okbank                        │ │
        │  └─────────────────────────────────────────────┘ │
        │                                                   │
        │  ┌─────────────────────────────────────────────┐ │
        │  │  🎯 Rotating Ads (3s interval)              │ │
        │  │  "Instant loans up to ₹8 Lakhs"             │ │
        │  └─────────────────────────────────────────────┘ │
        │                                                   │
        │  ┌─────────────────────────────────────────────┐ │
        │  │  📌 Recently Used (up to 6 items)           │ │
        │  │  [Feature 1] [Feature 2] [Feature 3]        │ │
        │  └─────────────────────────────────────────────┘ │
        │                                                   │
        │  ┌─────────────────────────────────────────────┐ │
        │  │  🎯 All Features (3-column grid)            │ │
        │  │                                              │ │
        │  │  📱 Scan QR    👤 Pay      🏦 Bank          │ │
        │  │  ⚡ Recharge   📺 DTH      💡 Electric       │ │
        │  │  📞 Postpaid   💰 Loan     🌐 Broadband     │ │
        │  │  💳 Credit     ▶️ Play     🎁 Rewards       │ │
        │  │  🏷️ Offers     👥 Refer    🎁 Gift Cards    │ │
        │  │  📋 Subscribe  📊 CIBIL    📜 History       │ │
        │  │  💼 Balance                                  │ │
        │  └─────────────────────────────────────────────┘ │
        └───────┬──────────────┬──────────────┬────────────┘
                │              │              │
        ┌───────▼──────┐  ┌───▼────┐  ┌──────▼──────┐
        │ FEATURE PAGE │  │ SEARCH │  │ PROFILE     │
        │ ──────────── │  │ ────── │  │ ─────────── │
        │ • Icon       │  │ • Find │  │ • Edit Info │
        │ • Title      │  │   any  │  │ • Settings  │
        │ • Desc       │  │   feat │  │ • Logout    │
        │ • Action     │  └────────┘  └─────────────┘
        └──────────────┘
                │
                ▼
        ┌──────────────┐
        │ NOTIFICATION │
        │ ──────────── │
        │ • Alerts     │
        │ • Promos     │
        │ • Updates    │
        └──────────────┘


═══════════════════════════════════════════════════════════════════════════════
                            FEATURE INTERACTIONS
═══════════════════════════════════════════════════════════════════════════════

HOME PAGE ACTIONS:
├── Tap Profile Avatar ──────► Upload/Change Profile Picture
├── Tap Notifications ────────► View Notifications Page
├── Tap Search ───────────────► Search Features Dialog
├── Tap Settings ─────────────► Profile Page
├── Tap Any Feature ──────────► Feature Page (adds to Recently Used)
└── Tap Recently Used ────────► Feature Page (quick access)


AUTHENTICATION FLOW:
├── New User: Sign Up → Login → Profile Setup → Home
├── Existing User: Login → Home
└── Forgot Password: Reset → Login → Home


THEME SWITCHING:
├── Available on: Splash, Logo, Login, Sign Up, Home
├── Toggle: 🌓 Button (top-right)
└── Modes: ☀️ Light Mode ↔️ 🌙 Dark Mode


DATA PERSISTENCE:
├── SharedPreferences stores:
│   ├── user_email
│   ├── user_mobile
│   ├── user_password
│   ├── first_name
│   ├── last_name
│   ├── upi_id
│   └── profile_image (path)
└── Persists across app restarts


═══════════════════════════════════════════════════════════════════════════════
                         SCREEN-BY-SCREEN BREAKDOWN
═══════════════════════════════════════════════════════════════════════════════

1. SPLASH SCREEN (3 seconds)
   ┌─────────────────────────────────────┐
   │  🌓                                  │
   │                                      │
   │  ┌──────────┐    WELCOME TO         │
   │  │          │    BLINK PAY           │
   │  │  BANK    │                        │
   │  │  LOTTIE  │                        │
   │  │  ANIM    │                        │
   │  └──────────┘                        │
   └─────────────────────────────────────┘

2. LOGIN PAGE
   ┌─────────────────────────────────────┐
   │                              🌓      │
   │        ┌─────────────────┐          │
   │        │     Login       │          │
   │        │                 │          │
   │        │ 👤 Email/Phone  │          │
   │        │ 🔒 Password 👁  │          │
   │        │                 │          │
   │        │ Forgot Pass?    │          │
   │        │                 │          │
   │        │  [Login Button] │          │
   │        │                 │          │
   │        │ Don't have acc? │          │
   │        │    Sign up      │          │
   │        └─────────────────┘          │
   └─────────────────────────────────────┘

3. HOME PAGE
   ┌─────────────────────────────────────┐
   │ 👤 Hey User | 🔔 🔍 ⚙️             │
   │ your-upi@okbank                     │
   ├─────────────────────────────────────┤
   │ 🎯 Instant loans up to ₹8 Lakhs    │
   ├─────────────────────────────────────┤
   │ Recently Used                       │
   │ [Scan] [Pay] [Recharge]            │
   ├─────────────────────────────────────┤
   │ [📱 QR] [👤 Pay] [🏦 Bank]         │
   │ [⚡ Rech] [📺 DTH] [💡 Elec]       │
   │ [📞 Post] [💰 Loan] [🌐 Net]       │
   │ [💳 Card] [▶️ Play] [🎁 Reward]    │
   │ [🏷️ Offer] [👥 Refer] [🎁 Gift]   │
   │ [📋 Sub] [📊 CIBIL] [📜 History]   │
   │ [💼 Balance]                        │
   └─────────────────────────────────────┘


═══════════════════════════════════════════════════════════════════════════════
                            NAVIGATION SUMMARY
═══════════════════════════════════════════════════════════════════════════════

Splash (3s) → Logo → Login/SignUp → Home → Features
                      ↓                ↓
                  Forgot Pass      Profile/Settings
                                       ↓
                                   Notifications


═══════════════════════════════════════════════════════════════════════════════
                              KEY FEATURES
═══════════════════════════════════════════════════════════════════════════════

✅ 19+ Payment & Utility Features
✅ Light/Dark Theme Support
✅ Profile Management with Photo Upload
✅ Search Functionality
✅ Recently Used Tracking (up to 6)
✅ Rotating Advertisements
✅ Form Validation
✅ Password Visibility Toggle
✅ Persistent Data Storage
✅ Smooth Animations
✅ Responsive Design
✅ Material Design UI

```

---

## 🎯 User Interaction Patterns

### **First-Time User Journey**
```
Open App → Watch Splash → View Logo → Sign Up → Login → Setup Profile → Explore Home
```

### **Returning User Journey**
```
Open App → Watch Splash → View Logo → Login → Home Dashboard
```

### **Making a Payment**
```
Home → Select Feature (e.g., "Mobile Recharge") → Feature Page → Complete Action
```

### **Profile Management**
```
Home → Settings Icon → Profile Page → Edit/Logout
```

### **Search Feature**
```
Home → Search Icon → Type Feature Name → Select → Feature Page
```

---

## 📱 Responsive Design

The app adapts to different screen sizes:
- **Mobile**: Optimized for portrait mode
- **Tablet**: Larger cards and spacing
- **Web**: Full-width responsive layout
- **Desktop**: Centered content with max-width

---

## 🎨 Theme Comparison

| Element | Light Mode | Dark Mode |
|---------|-----------|-----------|
| Background | White | #121212 |
| Cards | White + Shadow | #1E1E1E |
| Primary Color | Blue Accent | Indigo |
| Text | Black87 | White70 |
| Input Fields | White | #1E1E1E |

---

**End of Flow Diagram**
