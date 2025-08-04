# Flutter Login Component

A customizable and reusable Flutter login component that can be easily integrated into any Flutter application.

## Features

- Clean and modern login UI
- Customizable styling
- Email and password validation
- Easy integration
- Responsive design

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_login:
    git:
      url: https://github.com/davideloddeDev/flutter-login.git
```

## Usage

```dart
import 'package:flutter_login/flutter_login.dart';

// Use the LoginWidget in your app
LoginWidget(
  onLogin: (email, password) {
    // Handle login logic
  },
)
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

MIT
