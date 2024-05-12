# Skin Diseases Detection System

- Skin Disease Detection system using Tenser-flow lite, Flutter and Firebase.

## Getting Started / How to install the solution.
### Running a Flutter project involves a few steps
1. **Install Flutter**: If you haven't already, you need to install Flutter. You can follow the instructions on the [official Flutter website](https://docs.flutter.dev/get-started/install).
   
2. **Set up an IDE or Editor**: Flutter works with various IDEs and editors like Android Studio, Visual Studio Code, and IntelliJ IDEA. Choose your preferred one and set it up according to the Flutter documentation.
   [VSCode installation](https://docs.flutter.dev/get-started/install/macos/desktop?tab=vscode#use-vs-code-to-install-flutter)
   
3. **Clone or Create a Flutter Project**: You can clone an existing Flutter project from a repository (e.g., GitHub) or create a new one using the Flutter CLI:
    - Or import the extracted zip file.    

4. **Navigate to the Project Directory**: Open a terminal or command prompt, navigate to the directory of your Flutter project.

5. **Connect a Device**: You can run your Flutter app on either a physical device (e.g., Android or iOS) or an emulator/simulator.

   * Physical Device: Connect your device via USB debugging and make sure it's enabled for development. If you're using an iPhone, you might need to set up a development certificate.

   * Emulator/Simulator: If you're using an emulator or simulator, make sure it's set up and running. You can start one from Android Studio, Visual Studio Code, or using the command line.

6. **Run the App**: Once your device or emulator is connected, you can run your Flutter app by executing the following command in the terminal:<br>
   ```flutter run``` (before running the ```flutter run``` command ```flutter pub get```)
  This command will compile your Flutter app and deploy it to the connected device or emulator.
   
7. **View the App:** After running the app, it will be displayed on your device or emulator. You can interact with it just like any other app.

8. **Debugging:** If you encounter any issues or errors, Flutter provides various debugging tools. You can use print statements, debug breakpoints, or Flutter DevTools to diagnose and fix problems.
<br><hr>
### Adding firebase to Flutter project involves a few steps
1. Set up Firebase Project:
    - Go to the Firebase Console (https://console.firebase.google.com/).
    - Create a new project or select an existing project. [Using flutterfire cli](https://firebase.flutter.dev/docs/cli/)
    - Follow the instructions to add Firebase to your app. You will need to provide your Android package name and/or iOS bundle identifier during this process.

2. Add FlutterFire to Your Flutter Project:
    - Open your Flutter project in your preferred editor.
    - Add the FlutterFire dependencies to your pubspec.yaml file.
    - Run ```flutter pub get``` in your terminal to fetch the dependencies.

3. Set up Firebase Configuration Files:
   * For Android:
       - Download the google-services.json file from the Firebase Console.
       - Place the google-services.json file in the android/app directory of your Flutter project.
