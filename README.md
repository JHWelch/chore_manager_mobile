# chore_manager_mobile

A Companion to the [ChoreManager](https://github.com/JHWelch/ChoreManager) Web App

## Setup
```sh
flutter pub get
```

## Linter
```sh
flutter analyze
```

## Tests
```sh
flutter test
```

## Coverage (Mac)
```sh
brew install lcov
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```
