# flutter_verification_code_input

- A Flutter package that help you create a verification input.

## Installing

```yaml
  flutter_verification_code_input:
    git:
      url: git://github.com/tiny-express/flutter_verification_code_input.git
    version: ^0.1.2
```

```dart
import'package:flutter_verification_code_input/flutter_verification_code_input.dart';
```

## Usage

```dart
  VerificationCodeInput(
      keyboardType: TextInputType.number,
      length: 4,
      onCompleted: (String value) {
        //...
        print(value);
      },
  )
```

## Showcase


![Showcase|100x100, 10%](show_case.gif)


