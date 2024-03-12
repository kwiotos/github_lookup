# Github Lookup

Flutter application that allows to look for Github public repositories.
It lists repos searched based on entered keyword, presents
basic info about a repo and presents list of open pull requests for a repo.

## Getting Started

To run the application on a device first run the following commands
(you can run it with or without fvm, but when you want to run it without fvm be
sure to have the same flutter version installed as in the fvm_config.json file):

- (fvm) flutter pub get
- (fvm) dart run build_runner build --delete-conflicting-outputs
- (fvm) dart run easy_localization:generate -S "assets/translations" -O "
  lib/translations" -f keys -o translations.gl.dart
- (fvm) flutter run
