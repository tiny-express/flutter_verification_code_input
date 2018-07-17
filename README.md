# flutter_verification_code_input

- A Flutter package that help you create a verification input.

## Installing

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_verification_code_input: ^0.0.1
```

```dart
import'package:flutter_verification_code_input/flutter_verification_code_input.dart';
```

## Usage

```dart
        new VerificationCodeInput(
            keyboardType: TextInputType.number,
            length: 4,
            onCompleted: (String value) {
              //...
              print(value);
            },
        )
```

## Showcase

![Showcase](show_case.gif)