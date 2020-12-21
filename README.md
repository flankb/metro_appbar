# metro_appbar

Custom app bar with simple and readable design


![](.assets/screencast.gif)
![](.assets/screenshot.png)

## Include in your project
```
dependencies:
  metro_appbar: ^0.0.1
```
run packages get and import it
```
import 'package:metro_appbar/metro_appbar.dart';
```

## Usage

Add MetroAppBar to your widget tree:
```dart
MetroAppBar(primaryCommands: [
  PrimaryCommand(
      onPressed: () {
        // Add some logic here and to other commands
      },
      icon: Icons.account_balance_rounded,
      text: 'Eiusmod'),
  PrimaryCommand(
      onPressed: () {}, icon: Icons.ac_unit, text: 'Reprehenderit qui'),
  PrimaryCommand(
      icon: Icons.accessible_outlined, onPressed: () {}, text: 'Ipsum')
], secondaryCommands: [
  SecondaryCommand(onPressed: () {}, text: 'Commodo'),
  SecondaryCommand(onPressed: () {}, text: 'Officia'),
]);
```

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).