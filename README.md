 
# khateb_date_picker

[![pub package](https://img.shields.io/pub/v/khateb_date_picker.svg)](https://pub.dev/packages/khateb_date_picker)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A beautiful, customisable **iOS-style drum-roll date picker** for Flutter.  
Zero external dependencies – pure Flutter.

---

## ✨ Features

- 🎡 Smooth drum-roll (ListWheelScrollView) for day / month / year
- 🎨 Built-in **light** and **dark** themes with full `copyWith` support
- 🖌️ Custom button colour, border-radius, fonts, highlight colours …
- 📅 Configurable `minDate` / `maxDate`
- 🔮 `Future<DateTime?>` API – one line to show the picker
- 📳 Haptic feedback on selection
- 🚫 No GetX, no extra dependencies

---

## 🚀 Quick start

```dart
import 'package:khateb_date_picker/khateb_date_picker.dart';

// Inside an async method / onPressed:
final DateTime? picked = await KhatebDatePicker.show(
  context: context,
  title: 'Date of Birth',
  subtitle: 'Select your birth date',
  buttonText: 'Choose',
  initialDate: DateTime(1995, 6, 15),
  minDate: DateTime(1980),
  maxDate: DateTime(2007),
);

if (picked != null) {
  print(picked); // 1995-06-15 00:00:00.000
}
```

---

## 🎨 Theming

### Light (default)

```dart
KhatebDatePicker.show(
  context: context,
  title: 'Birthdate',
  subtitle: 'Pick a date',
  buttonText: 'Confirm',
  // theme defaults to KhatebDatePickerTheme.light()
);
```

### Dark

```dart
KhatebDatePicker.show(
  context: context,
  title: 'Birthdate',
  subtitle: 'Pick a date',
  buttonText: 'Confirm',
  theme: KhatebDatePickerTheme.dark(),
);
```

### Custom colours

```dart
KhatebDatePicker.show(
  context: context,
  title: 'Birthdate',
  subtitle: 'Pick a date',
  buttonText: 'Confirm',
  theme: KhatebDatePickerTheme.light(
    buttonColor: Colors.deepPurple,
  ),
);
```

### Full customisation via `copyWith`

```dart
final myTheme = KhatebDatePickerTheme.dark().copyWith(
  backgroundColor: const Color(0xFF0D1117),
  selectedItemColor: Colors.amber,
  buttonColor: Colors.amber,
  buttonBorderRadius: 16,
  titleFontSize: 24,
);

KhatebDatePicker.show(
  context: context,
  title: 'Birthdate',
  subtitle: 'Pick a date',
  buttonText: 'Confirm',
  theme: myTheme,
);
```

---

## 🧩 Embed the widget directly

You can also drop the picker inline inside any widget tree without the bottom-sheet wrapper:

```dart
import 'package:khateb_date_picker/khateb_date_picker.dart';

ModernDatePickerWidget(
  initialDate: DateTime(1995),
  minDate: DateTime(1980),
  maxDate: DateTime(2007),
  theme: KhatebDatePickerTheme.light(),
  onChanged: (date) => print(date),
)
```

---

## 📦 KhatebDatePickerTheme reference

| Property | Type | Default (light) |
|----------|------|-----------------|
| `backgroundColor` | `Color` | `0xFFF4F6F9` |
| `titleColor` | `Color` | `0xFF1B3B5C` |
| `subtitleColor` | `Color` | `Colors.blueGrey` |
| `titleFontSize` | `double` | `22` |
| `subtitleFontSize` | `double` | `14` |
| `selectedItemColor` | `Color` | `0xFF2D4E73` |
| `unselectedItemColor` | `Color` | `0xFF757980` |
| `selectionHighlightColor` | `Color` | grey 8% |
| `selectionHighlightRadius` | `double` | `10` |
| `buttonColor` | `Color` | `0xFF2998D6` |
| `buttonTextColor` | `Color` | `white` |
| `buttonBorderRadius` | `double` | `8` |
| `buttonHeight` | `double` | `50` |
| `buttonFontSize` | `double` | `16` |
| `fadeColor` | `Color` | matches background |

---

## License

MIT © Mohammed Khateb
