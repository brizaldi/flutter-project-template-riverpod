# flutter_project_template_riverpod

## Installation
- Add [Flutter](https://flutter.dev/docs/get-started/install 'Flutter') to your machine
- Open this project folder with Terminal/CMD
- Ensure there's no cache/build leftover by running `flutter clean` in the Terminal
- Run in the Terminal `flutter packages get`
- Run in the Terminal `flutter packages pub run build_runner build --delete-conflicting-outputs`

## Running the App
- Open Android Emulator
- Run `flutter run --flavor {RELEASE_TYPE}`
- Supported release type: `development`, `staging`, and `production`

## Build an APK
- Run `flutter build apk --flavor {RELEASE_TYPE}`
- The apk will be saved under this location: `[project]/build/app/outputs/flutter-apk/`

For more information, check out the [official documentation](https://flutter.dev/docs 'documentation')

## TODO
- Add configuration for iOS