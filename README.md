# 📱 Flutter Project Name

Aegis is a Flutter application designed to empower gay and marginalized communities by providing a platform to discover safe and supportive locations. Whether you're looking for LGBTQ+ friendly businesses, community centers, or other welcoming spaces, Aegis helps you find places where you can feel at home.

## 🚀 Features

- **Cross-platform support**: Runs on Android, iOS, Web, Windows, macOS, and Linux.
- **Modern UI**: Built using Flutter’s powerful widget system.
- **AI-Powered tagging system**: A built in AI that automatically update the tag of location periodically.
- **Tag-filtering**: Easily find the supportive location that you're looking for.
- **Auras point**: A system to determine whether someone is reliable enough.

## 🛠️ Installation

To get started with this project, follow these steps:

1. Clone this repository:
   ```sh
   git clone https://github.com/Hankaji/GDGDoc-Aegis-Frontend.git
   ```
2. Navigate to the project folder:
   ```sh
   cd GDGDoc-Aegis-Frontend
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the project:
   ```sh
   flutter run
   ```

## 🏗️ Project Structure

```sh
/lib
   ├── main.dart            # Entry point of the app
   ├── screens/             # UI screens
   ├── widgets/             # Custom reusable widgets
   ├── domain/endpoints     # Utils for calling http reequest to the backend
   ├── domain/models        # Data schema
   ├── utils/               # Helper functions
```

## 🔧 Usage

User will be greeted with a splashscreen and a login screen. Use any form of email and password you like as long as it follow the email format and has at least 6 characters in password.

In the map viewing screen, users can:
 - Type anything in search bar to filter for location (filter by tag name e.g LGBTQ+ friendly,...)
 - View through location list from the drawer sheet (Swipe from the bottom of the screen)
 - View detail information about a location by clicking on desired location
 - Post a comment with a rating:
   - This will trigger the AI in the backend to start analyzing the comment data and auto tag the location based on reviews, this will take somee time
   - Goes back for a refetch of data to view the new tag on the reviewd location
