# PV Store 🛍️

A mobile application built with Flutter that wraps the [PV Store Web Platform](https://pvstore.padhaivadhai.com) into a seamless native experience. It integrates monetization, user authentication, and push notifications to deliver a full-featured e-commerce and rewarding experience.

## ✨ Features

- **Web-to-App Integration:** Provides a smooth native wrapper around the PV Store web interface using an in-app browser.
- **Rewarded Ads (Unity Ads):** Users can earn "PV Coins" by watching rewarded video ads. The balance is directly synced with the user's wallet via the backend API.
- **Push Notifications (Firebase):** Integrates Firebase Cloud Messaging (FCM) for real-time announcements, updates, and user re-engagement.
- **Secure Authentication:** Built-in login screen with API-based authentication and secure persistent storage (via `shared_preferences`) for access tokens.
- **Animated Splash Screen:** Beautiful entry point featuring fade and scale animations.

## 🛠️ Tech Stack & Dependencies

- **Framework:** [Flutter](https://flutter.dev/) (Dart)
- **Web View:** `flutter_inappwebview` & `webview_flutter`
- **Monetization:** Unity Ads (`unity_ads_plugin`)
- **Notifications:** Firebase Messaging (`firebase_messaging`, `firebase_core`)
- **State & Storage:** `shared_preferences`
- **Networking:** `http` package for API requests
- **UI/UX:** `quickalert` for interactive dialogs

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.7.0 or higher)
- Dart SDK
- Unity Ads Game ID
- Firebase Project setup (for push notifications)


   ```

## 🎮 How to Earn Points

1. Login using your PV Store credentials.
2. Once on the Home screen, tap the **Earn Points** button in the top right.
3. Watch the rewarded video ad provided by Unity Ads.
4. Upon completion, 1 PV coin will be credited to your wallet via the backend API.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/Notsatyamkumar/pvstore/issues).

---

Built with ❤️ using Flutter.
