<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# FourCups Loaders

## Demo Preview

<gifs>

## Live Preview

<link>

# Getting started
## Installing
Add this to your pubspec.yaml file:
```dart
dependencies:
  fc_loaders: ^0.0.1
```

## Import
Add this to the top of your file:
```dart
import 'package:fc_loaders/fc_loaders.dart';
```

## Usage
- Call the loaders as you would call any other widget.
```dart
child: 
    FCBallBounce()
```
<gif>

- You can also customize it to suit your needs.
```dart
child: 
    FCBallBounce(
        loaderBallColor: Colors.amber, 
        duration: Duration(milliseconds: 100)
    )
```
<gif>

## Available Loaders
<gif>

## Upcoming Loaders
<gif>

## Bugs, Contributions and requests
Contributions, Suggestions, Bug Fixes and Pull Requests are always welcome!

Got an idea for a Loader Animation? Feel free to let us know!

See `contribute.md` for ways to get started.

Please adhere to this project's `code of conduct`.

## License
MIT License