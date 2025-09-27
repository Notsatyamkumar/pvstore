# PVStore Flutter Application

## Overview
PVStore is a Flutter application that demonstrates the integration of AdMob for displaying rewarded ads. This project serves as a template for developers looking to implement ad functionalities in their Flutter applications.

## Project Structure
```
pvstore
├── lib
│   ├── main.dart               # Entry point of the application
│   ├── ads
│   │   ├── ad_helper.dart      # Helper functions for AdMob
│   │   └── rewarded_ad_manager.dart # Manages rewarded ads functionality
├── android                     # Android platform-specific files
├── ios                         # iOS platform-specific files
├── pubspec.yaml                # Project configuration and dependencies
└── README.md                   # Project documentation
```

## Setup Instructions

1. **Clone the Repository**
   Clone this repository to your local machine using:
   ```
   git clone <repository-url>
   ```

2. **Install Dependencies**
   Navigate to the project directory and run:
   ```
   flutter pub get
   ```

3. **Configure AdMob**
   - Create an AdMob account and set up your application.
   - Obtain your AdMob App ID and ad unit IDs for rewarded ads.
   - Update the `ad_helper.dart` file with your AdMob App ID and ad unit IDs.

4. **Run the Application**
   Use the following command to run the application:
   ```
   flutter run
   ```

## Usage Guidelines
- The main application is located in `lib/main.dart`.
- The `ad_helper.dart` file contains functions for initializing and loading AdMob ads.
- The `rewarded_ad_manager.dart` file manages the lifecycle of rewarded ads, including loading and displaying ads, as well as handling user interactions and callbacks.

## Additional Notes
- Ensure that you have the necessary permissions set up in your Android and iOS project files for AdMob to function correctly.
- Test the application on a physical device to see the ads in action, as they may not display on emulators.

## License
This project is licensed under the MIT License. See the LICENSE file for details.