# restaurant_app 🍽️

This project is a submission for **Dicoding's Belajar Fundamental Aplikasi Flutter (BFAF)** course. It is a comprehensive restaurant app that allows users to explore restaurants, view details, and interact with various features like adding reviews, saving favorites, and more!

## Features 📱

- **Restaurant List:** Fetch and display a list of restaurants using the [Restaurant API](https://restaurant-api.dicoding.dev/) with the `http` package.
- **Restaurant Details:** View detailed information about a restaurant, including its menu, ratings, and customer reviews.
- **Restaurant Search:** Search for restaurants by name using real-time filtering.
- **User Reviews:** Allow users to submit reviews and ratings for their favorite restaurants.
- **Favorites:** Save and manage favorite restaurants locally using the `sqflite` database (SQLite).
- **Daily Reminder:** Get daily notifications with restaurant recommendations using `shared_preferences`, `flutter_local_notifications`, and `android_alarm_manager_plus`.
- **State Management & Permissions:** Seamlessly manage app state with the **Provider** package, and handle notification permissions with **permission_handler**.

## Tech Stack 🛠️

- **Flutter & Dart** - Core framework for building the mobile app.
- **HTTP** - For API communication.
- **Provider** - For state management across the app.
- **sqflite (SQLite)** - Local database for storing favorite restaurants.
- **Shared Preferences** - For persisting user preferences like reminders.
- **Flutter Local Notifications** - For scheduling daily notifications.
- **Android Alarm Manager Plus** - To trigger notifications at a set time.
- **Permission Handler** - For requesting notification permissions.

## Preview 📸

| Restaurant App Preview 1 | Restaurant App Preview 2 |
|-----------------|--------------------|
| ![Preview 1](https://github.com/user-attachments/assets/24002960-a5ea-43a0-87e4-417580153058) | ![Preview 2](https://github.com/user-attachments/assets/6429a072-2bad-4780-9e56-5e26aa007296) |

## Installation & Setup ⚙️

1. Clone the repository:
   ```bash
   git clone https://github.com/KristianEka/flutter_restaurant_app.git
   ```
2. Install the required dependencies:
   ```bash
   flutter pub get
   ```
3. Build and run the app on your preferred device or emulator:
   ```bash
   flutter run
   ```
