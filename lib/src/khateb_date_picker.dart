import 'package:flutter/material.dart';

import 'khateb_date_picker_theme.dart';
import 'modern_date_picker_widget.dart';

/// The main public API for the package.
///
/// ```dart
/// final date = await KhatebDatePicker.show(
///   context: context,
///   title: 'Date of Birth',
///   subtitle: 'Select your birth date',
///   buttonText: 'Choose',
/// );
/// if (date != null) print(date);
/// ```
class KhatebDatePicker {
  KhatebDatePicker._();

  /// Shows a bottom-sheet date picker and returns the chosen [DateTime],
  /// or `null` if the user dismisses without confirming.
  ///
  /// ### Parameters
  /// | Name | Required | Description |
  /// |------|----------|-------------|
  /// | `context` | ✅ | Build context |
  /// | `title` | ✅ | Heading shown at the top |
  /// | `subtitle` | ✅ | Sub-heading below the title |
  /// | `buttonText` | ✅ | Label on the confirm button |
  /// | `initialDate` | | Pre-selected date (defaults to today) |
  /// | `minDate` | | Earliest selectable date |
  /// | `maxDate` | | Latest selectable date |
  /// | `theme` | | Visual theme (defaults to [KhatebDatePickerTheme.light]) |
  static Future<DateTime?> show({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String buttonText,
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
    KhatebDatePickerTheme? theme,
  }) {
    final resolvedTheme = theme ?? KhatebDatePickerTheme.light();
    final resolvedInitial = initialDate ?? DateTime(1991, 10, 12);
    final resolvedMin = minDate ?? DateTime(1900);
    final resolvedMax = maxDate ?? DateTime.now();

    return showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _KhatebDatePickerSheet(
        title: title,
        subtitle: subtitle,
        buttonText: buttonText,
        initialDate: resolvedInitial,
        minDate: resolvedMin,
        maxDate: resolvedMax,
        theme: resolvedTheme,
      ),
    );
  }
}

// ── Private sheet widget ──────────────────────────────────────────────────────

class _KhatebDatePickerSheet extends StatefulWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final DateTime initialDate;
  final DateTime minDate;
  final DateTime maxDate;
  final KhatebDatePickerTheme theme;

  const _KhatebDatePickerSheet({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.initialDate,
    required this.minDate,
    required this.maxDate,
    required this.theme,
  });

  @override
  State<_KhatebDatePickerSheet> createState() => _KhatebDatePickerSheetState();
}

class _KhatebDatePickerSheetState extends State<_KhatebDatePickerSheet> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.theme;

    return Container(
      decoration: BoxDecoration(
        color: t.backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Drag handle ──────────────────────────────────────────────────
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: t.unselectedItemColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 28),

            // ── Title ────────────────────────────────────────────────────────
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: t.titleFontSize,
                fontWeight: t.titleFontWeight,
                color: t.titleColor,
              ),
            ),
            const SizedBox(height: 8),

            // ── Subtitle ─────────────────────────────────────────────────────
            Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: t.subtitleFontSize,
                fontWeight: t.subtitleFontWeight,
                color: t.subtitleColor,
              ),
            ),
            const SizedBox(height: 24),

            // ── Picker ───────────────────────────────────────────────────────
            ModernDatePickerWidget(
              initialDate: _selectedDate,
              minDate: widget.minDate,
              maxDate: widget.maxDate,
              theme: t,
              onChanged: (date) => setState(() => _selectedDate = date),
            ),
            const SizedBox(height: 24),

            // ── Confirm button ───────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: t.buttonHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: t.buttonColor,
                  foregroundColor: t.buttonTextColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(t.buttonBorderRadius),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(_selectedDate),
                child: Text(
                  widget.buttonText,
                  style: TextStyle(
                    fontSize: t.buttonFontSize,
                    fontWeight: FontWeight.w600,
                    color: t.buttonTextColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
