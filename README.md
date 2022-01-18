# chore_manager_mobile

A Companion to the [ChoreManager](https://github.com/JHWelch/ChoreManager) Web App

## Setup
```sh
flutter pub get
```

## Linter
```sh
dart analyze .
```

## Tests
Generate mocks if needed.
```sh
flutter test
```

## Coverage (Mac)
Generate mocks if needed.
```sh
brew install lcov
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```
