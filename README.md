# FoodRating 🍔⭐

An iOS application built in **Swift** that provides restaurant tracking, discovery, and food hygiene rating visualization features. The app integrates native mapping views alongside dynamic grading assets to evaluate local dining establishments.

## 🚀 Features

* **Interactive Map Pinning:** Custom map canvas annotation modules (`MapView.swift`, `CustomPin.swift`) designed to plot restaurant addresses geographically.
* **Hygiene Data Integration:** Fully configured to load official food hygiene rating datasets ranging from Exempt to Tier 5 scores (`fhrs_5_en-gb.imageset`, etc.).
* **Dynamic UI Gradients:** Implements a beautiful programmatic layout styling core via tailored color shifts (`ColourGradient.swift`).
* **Comprehensive Test Suites:** Ships with native functional verification configurations including Unit Tests and UI Automation testing targets.

## 📂 Project Directory Structure

```text
📁 FoodRating-master/
├── 📁 FoodRating.xcodeproj         # Core Xcode project building configurations
├── 📁 FoodRating/                  # Primary Application target sources
│   ├── 📄 AppDelegate.swift        # App lifecyle hooks
│   ├── 📄 ViewController.swift     # Core dashboard view controller 
│   ├── 📄 MapView.swift            # Map rendering controller segment
│   ├── 📄 Restaurants.swift        # Data models for dining entities
│   ├── 📁 Base.lproj/              # Main.storyboard and launch screen view trees
│   └── 📁 Assets.xcassets/         # App icons, rating images, and digital badges
├── 📁 FoodRatingTests/             # Unit testing code coverage suites
└── 📁 FoodRatingUITests/           # UI Automation workflow validation suites
```

## 🛠️ Tech Stack & Requirements

* **Language:** Swift (Swift 5+)
* **Platform:** iOS 13.0+
* **IDE Requirement:** Xcode 11.0 or newer
* **Framework Dependencies:** `UIKit`, `MapKit`

## ⚙️ Build & Setup Instructions

To get the project up and running locally inside your development environment, follow these steps:

### 1. Clone the Workspace
Clone the repository using git commands locally on a macOS device:
```bash
git clone https://github.com
cd FoodRating
```

### 2. Open the Xcode Project
Launch the native build workspace directly into Xcode:
```bash
open FoodRating-master/FoodRating.xcodeproj
```

### 3. Target Configuration
* Select your preferred emulator scheme (e.g., *iPhone 15 Pro*) or plug in a provisioned physical iOS debugging device.
* Navigate to the **Signing & Capabilities** tab of the root application configuration profile to select your active Apple Developer team.

### 4. Build and Run
* Press `⌘ + R` or click the **Play** button in the top left tool section of your Xcode client to compile dependencies and launch the app shell simulator.

## 🧪 Running Tests

Ensure all core logic and interface modules perform as expected under functional suites:
* **Run Unit Tests:** Press `⌘ + U` or toggle the **Test Navigator panel** to initiate `FoodRatingTests` pipelines.

## 📄 License

This repository is open-source software and available under the [MIT License](LICENSE).
