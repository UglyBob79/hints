# hints

A simple widget for showing dismissible help texts to the user. If the widget is dismissed, it will remember by saving the state in persistent storage and will never be shown again.

## Usage

### Import the package

To use this package, [add hints as a dependency](https://pub.dev/packages/hints#-installing-tab-) in your pubspec.yaml

### Use the package

    import 'package:hints/hints.dart';

The main widget to use is HintCard.

The widget need a unique Key to keep track of if the widget is hidden or not.

It also needs a hint text and can be provided an icon.

Note: The widget will assert if no key is provided. Don't provide a generated key as it will not match next run.

## Getting started

Please look at the [example code](example/lib/main.dart) for getting started.

![Screenshot](/screenshot.png?raw=true "Hints in action")
