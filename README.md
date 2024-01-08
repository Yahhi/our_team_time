# our_team_time

An app for monitoring different timezones

## Getting Started

There are 3 actions required to build the project:
-generate MobX code
-generate localizations keys
-add your Firebase project settings

### MobX code generation
To generate code for MobX state management run in command line

`dart run build_runner build`

### Localization keys code generation
To generate localization keys run in command line

`dart run easy_localization:generate --format keys --source-dir "assets/translations" --source-file "ru.json" --output-dir "lib/core/localization" --output-file "locale_keys.g.dart"`

### Adding your own Firebase project
To generate file with Firebase settings go to https://firebase.google.com/docs/flutter/setup?hl=en&platform=ios and follow the instructions
In short you need to install flutterfire_cli and create your own project configuration file with command line:

`flutterfire configure`

## Adding your code

Please take care about code quality. Before committing anything, check if it gives no warnings by linter
`flutter analyze`

Additionally there are some tests which help code to be reliable, please run tests to check that nothing was broken
`flutter test`

These rules are included in git hooks, so just make sure to do commits with command line or enabling them in your IDE.