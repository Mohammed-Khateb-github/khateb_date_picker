import 'package:flutter_test/flutter_test.dart';
import 'package:khateb_date_picker/khateb_date_picker.dart';

void main() {
  group('KhatebDatePickerTheme', () {
    test('light factory creates correct defaults', () {
      final theme = KhatebDatePickerTheme.light();
      expect(theme.buttonColor, const Color(0xFF2998D6));
      expect(theme.titleFontSize, 22);
    });

    test('dark factory creates correct defaults', () {
      final theme = KhatebDatePickerTheme.dark();
      expect(theme.backgroundColor, const Color(0xFF1A1A2E));
    });

    test('copyWith overrides only specified fields', () {
      final base = KhatebDatePickerTheme.light();
      final modified = base.copyWith(buttonFontSize: 20);
      expect(modified.buttonFontSize, 20);
      expect(modified.titleFontSize, base.titleFontSize);
    });
  });
}
