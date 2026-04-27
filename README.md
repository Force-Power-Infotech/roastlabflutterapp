# RoastLab

RoastLab is a full-stack coffee companion platform with three workspaces:

- Flutter mobile app at the repo root for Android and iOS
- `backend/` Node.js + Express API with MongoDB models and Firebase-ready auth middleware
- `admin/` React admin panel for moderation, premium users, video management, and analytics

## Mobile app highlights

- Splash, onboarding, login, signup, OTP, forgot password
- Bottom-tab shell: Home, Scan, Feed, Learn, Profile
- Camera-based roast and grind analysis using on-device image heuristics
- Brew calculator with Espresso, French Press, Pour Over, Aeropress, and Cold Brew
- Recipe saving, roast journal, notifications, premium plans, profile, and settings
- Embedded YouTube learning screen
- AI Coffee Coach with contextual troubleshooting prompts

## Backend highlights

- Express app with modular routes and controllers
- MongoDB collections for `Users`, `Scans`, `RoastHistory`, `GrindHistory`, `Posts`, `Comments`, `Likes`, `Recipes`, `Subscriptions`, `Videos`, and `Notifications`
- Firebase Admin verification hook with a local dev fallback when bearer tokens are not supplied
- Admin analytics endpoints for users, premium counts, moderation load, and content inventory

## Admin panel highlights

- Analytics dashboard with charting
- User table for subscription and role review
- Video management screen for Learn content publishing

## Project structure

```text
roastlab/
|-- lib/                  Flutter app source
|-- assets/icons/         Launcher and splash art
|-- assets/images/        Reserved for future content assets
|-- backend/              Express API and Mongo models
|-- admin/                React admin panel
|-- android/ ios/ ...     Flutter platform folders
```

## Setup

### 1. Flutter mobile app

Install Flutter locally, then from the repo root:

```bash
flutter pub get
flutter run
```

Optional native asset generation:

```bash
flutter pub run flutter_launcher_icons
flutter pub run flutter_native_splash:create
```

### 2. Backend

```bash
cd backend
npm install
cp .env.example .env
npm run dev
```

Required environment values:

- `MONGODB_URI`
- `FIREBASE_PROJECT_ID`
- `FIREBASE_CLIENT_EMAIL`
- `FIREBASE_PRIVATE_KEY`

### 3. Admin panel

```bash
cd admin
npm install
npm run dev
```

Optional admin environment values:

- `VITE_API_BASE_URL`
- `VITE_ADMIN_TOKEN`

## Notes

- The mobile app defaults to working local state so the UI and flows remain usable before external services are wired.
- The scan engine is intentionally abstracted behind providers, which makes it straightforward to replace the current heuristic analyzer with a server model or TensorFlow Lite module later.
- Firebase mobile client setup files such as `google-services.json` and `GoogleService-Info.plist` are still environment-specific and should be added per deployment target.
