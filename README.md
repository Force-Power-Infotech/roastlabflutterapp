# RoastLab: Premium AI Coffee Intelligence

RoastLab is a modern, production-grade mobile-first web application designed for coffee enthusiasts, home brewers, and professional roasters. It leverages Google's Gemini AI to analyze roast colors and grind sizes via the camera, alongside a suite of brewing tools and a community platform.

---

## 🎨 Design Philosophy
RoastLab uses a **Dark Luxury / Coffee-Themed** aesthetic:
- **Primary Palette**: Deep Blacks (`#0C0B0A`), Warm Cremas (`#D4A373`), and Earthy Browns.
- **Glassmorphism**: Backdrop blurs and semi-transparent surfaces for a modern, floating UI feel.
- **Micro-animations**: Powered by `motion/react` for fluid screen transitions and interactive feedback.
- **Typography**: `Outfit` for technical display headers and `Inter` for highly legible UI elements.

---

## 🚀 Core Features

### 1. AI Scan Engine
- **Roast Meter**: Captures whole bean images and estimates **Agtron Roast Scores**, roast levels (Light to Dark), and consistency percentages.
- **Grind Detection**: Analyzes coffee grounds to determine average size (Fine to Coarse) and detects particle distribution uniformity.
- **Save to History**: Users can instantly persist scan results to the cloud for longitudinal tracking.

### 2. AI Coffee Coach
- A real-time chat interface powered by **Gemini pro/flash** models.
- Acts as a digital barista to help troubleshoot brewing issues, explain chemical extractions, or recommend dial-in settings.

### 3. Brew Assistant
- Interactive calculator for **V60, Aeropress, French Press, Chemex, and Espresso**.
- Dynamically adjusts water/coffee ratios based on desired weight.
- Provides specific temperature and grind size recommendations for each method.

### 4. Expert Academy
- Categorized learning center for Brewing, Roasting, Latte Art, and Coffee Theory.
- Video-first interface designed for mobile scannability.

### 5. Community Feed
- Instagram-inspired social platform for sharing brews and roasts.
- Supports Likes, Comments, and location-based tagging.

---

## 🏗️ Project Architecture

### Folder Structure
```text
/
├── src/
│   ├── components/       # Reusable UI widgets and layout shells
│   │   └── Scanner/      # Camera handling and canvas logic
│   ├── context/          # Global State (Auth, Theme)
│   ├── lib/              # Third-party SDK initializations (Firebase)
│   ├── services/         # API wrappers (Gemini AI Service)
│   ├── screens/          # Main logical pages
│   │   ├── Main/         # core Bottom-Nav screens (Home, Feed, Learn, Profile)
│   │   └── Features/     # Distinct tools (AI Coach, Brew Calc)
│   ├── types/            # TypeScript interfaces
│   ├── App.tsx           # Main router & layout navigation
│   └── index.css         # Global styles & Tailwind config
├── server.ts             # Express.js production server
├── firebase-blueprint.json # Data schema documentation
└── firestore.rules       # Security logic for database
```

### Tech Stack
- **Frontend**: React 19, Vite, Tailwind CSS 4.
- **Backend**: Node.js, Express.
- **Database/Auth**: Firebase Firestore & Firebase Authentication.
- **AI**: Gemini AI via `@google/genai` SDK.
- **Animation**: `motion/react`.
- **Icons**: `lucide-react`.

---

## 🔐 Database Schema (Firestore)

- **`users`**: Profiles, subscription status (Pro/Free), and XP.
- **`scans`**: Historical data of roast and grind analysis.
- **`posts`**: Community content.
- **`recipes`**: Saved brewing parameters.
- **`comments/likes`**: Engagement relationships.

---

## 🛠️ Getting Started

### Local Development
1. **Configure Environment**:
   Ensure `GEMINI_API_KEY` is set in your environment variables.
2. **Install Dependencies**:
   ```bash
   npm install
   ```
3. **Run Dev Server**:
   ```bash
   npm run dev
   ```

### Production Build
1. **Build Assets**:
   ```bash
   npm run build
   ```
2. **Start Server**:
   ```bash
   npm start
   ```

---

## 🛠️ Security
All data is protected via **Attribute-Based Access Control (ABAC)** in Firestore Security Rules.
- Users can only read/write their own private scans.
- Public feed data is read-only for guest users.
- Identity integrity is verified via `request.auth.uid`.

---

Developed for **RoastLab Inc.** - "Coffee Intelligence for Everyone."
