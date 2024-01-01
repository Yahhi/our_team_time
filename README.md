# our_team_time

An app for monitoring different timezones

## Getting Started

To generate code for MobX state management

`flutter packages pub run build_runner build`

To generate localization keys

`dart run easy_localization:generate --format keys --source-dir "assets/translations" --source-file "ru.json" --output-dir "lib/core/localization" --output-file "locale_keys.g.dart"`

## Adding your code

Please take care about code quality. Before committing anything, check if it gives no warnings by linter
`flutter analyze`

Additionally there are some tests which help code to be reliable, please run tests to check that nothing was broken
`flutter test`