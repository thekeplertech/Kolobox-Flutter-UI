# kolobox new app

A new Flutter project. Project built in flutter version 3.3.9.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on
mobile development, and a full API reference.

Create android build using below command
For dev environment,
flutter build apk --release --flavor dev -t lib/config/main_dev.dart

For prod environment,
flutter build apk --release --flavor prod -t lib/config/main_prod.dart

Create iOS build using below command
For dev environment,
flutter build ios --release --flavor dev -t lib/config/main_dev.dart

For prod environment,
flutter build ios --release --flavor prod -t lib/config/main_prod.dart

Generate api generator file through below command
flutter pub run build_runner build --delete-conflicting-outputs