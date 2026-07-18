import 'package:flutter/material.dart';

/// Holds all visual tokens used by [ModernDatePickerWidget] and
/// [KhatebDatePicker].
///
/// Create a fully branded instance manually, or start from the built-in
/// factories [KhatebDatePickerTheme.light] / [KhatebDatePickerTheme.dark]
/// and fine-tune individual properties with [copyWith].
///
/// ### Example – custom button colour
/// ```dart
/// KhatebDatePickerTheme.light(buttonColor: Colors.deepPurple)
/// ```
///
/// ### Example – full override
/// ```dart
/// KhatebDatePickerTheme.dark().copyWith(
///   selectedItemColor: Colors.amber,
///   buttonBorderRadius: 16,
/// )
/// ```
class KhatebDatePickerTheme {
  /// Background colour of the bottom-sheet panel.
  final Color backgroundColor;

  /// Colour of the title text shown at the top of the sheet.
  final Color titleColor;

  /// Colour of the subtitle / hint text shown below the title.
  final Color subtitleColor;

  /// Font size of the title. Defaults to `22`.
  final double titleFontSize;

  /// Font size of the subtitle. Defaults to `14`.
  final double subtitleFontSize;

  /// Font weight of the title. Defaults to [FontWeight.bold].
  final FontWeight titleFontWeight;

  /// Font weight of the subtitle. Defaults to [FontWeight.w400].
  final FontWeight subtitleFontWeight;

  /// Colour of the currently centred (selected) wheel item.
  final Color selectedItemColor;

  /// Colour of the non-selected wheel items.
  final Color unselectedItemColor;

  /// Background colour of the centre-row highlight band drawn behind
  /// the selected item.
  final Color selectionHighlightColor;

  /// Corner radius of the centre-row highlight band. Defaults to `10`.
  final double selectionHighlightRadius;

  /// Background colour of the confirm button.
  final Color buttonColor;

  /// Foreground (text) colour of the confirm button.
  final Color buttonTextColor;

  /// Corner radius of the confirm button. Defaults to `8`.
  final double buttonBorderRadius;

  /// Height of the confirm button in logical pixels. Defaults to `50`.
  final double buttonHeight;

  /// Font size of the confirm button label. Defaults to `16`.
  final double buttonFontSize;

  /// Colour used for the top and bottom gradient fade overlays.
  ///
  /// Should match [backgroundColor] for a seamless look.
  final Color fadeColor;

  /// Creates a fully customised [KhatebDatePickerTheme].
  ///
  /// Prefer the factory constructors [KhatebDatePickerTheme.light] and
  /// [KhatebDatePickerTheme.dark] for common use cases.
  const KhatebDatePickerTheme({
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    this.titleFontSize = 22,
    this.subtitleFontSize = 14,
    this.titleFontWeight = FontWeight.bold,
    this.subtitleFontWeight = FontWeight.w400,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.selectionHighlightColor,
    this.selectionHighlightRadius = 10,
    required this.buttonColor,
    required this.buttonTextColor,
    this.buttonBorderRadius = 8,
    this.buttonHeight = 50,
    this.buttonFontSize = 16,
    required this.fadeColor,
  });

  // ── Factories ────────────────────────────────────────────────────────────────

  /// A clean, bright theme suitable for apps with a white/light UI.
  ///
  /// Pass an optional [buttonColor] to override the default `#2998D6` blue.
  factory KhatebDatePickerTheme.light({Color? buttonColor}) {
    return KhatebDatePickerTheme(
      backgroundColor: const Color(0xFFF4F6F9),
      titleColor: const Color(0xFF1B3B5C),
      subtitleColor: Colors.blueGrey,
      selectedItemColor: const Color(0xFF2D4E73),
      unselectedItemColor: const Color(0xFF757980),
      selectionHighlightColor: const Color(0xFF646464).withValues(alpha: 0.08),
      buttonColor: buttonColor ?? const Color(0xFF2998D6),
      buttonTextColor: Colors.white,
      fadeColor: const Color(0xFFF4F6F9),
    );
  }

  /// A sleek dark theme for apps that use a dark UI palette.
  ///
  /// Pass an optional [buttonColor] to override the default `#2998D6` blue.
  factory KhatebDatePickerTheme.dark({Color? buttonColor}) {
    return KhatebDatePickerTheme(
      backgroundColor: const Color(0xFF1A1A2E),
      titleColor: const Color(0xFFE0E6F0),
      subtitleColor: const Color(0xFF8899AA),
      selectedItemColor: const Color(0xFF7EB8E8),
      unselectedItemColor: const Color(0xFF4A5568),
      selectionHighlightColor: const Color(0xFF7EB8E8).withValues(alpha: 0.12),
      buttonColor: buttonColor ?? const Color(0xFF2998D6),
      buttonTextColor: Colors.white,
      fadeColor: const Color(0xFF1A1A2E),
    );
  }

  /// Returns a copy of this theme with the given fields replaced.
  ///
  /// Only the fields you specify will change; everything else is inherited
  /// from the original theme.
  ///
  /// ```dart
  /// final myTheme = KhatebDatePickerTheme.light().copyWith(
  ///   buttonColor: Colors.green,
  ///   buttonBorderRadius: 20,
  /// );
  /// ```
  KhatebDatePickerTheme copyWith({
    Color? backgroundColor,
    Color? titleColor,
    Color? subtitleColor,
    double? titleFontSize,
    double? subtitleFontSize,
    FontWeight? titleFontWeight,
    FontWeight? subtitleFontWeight,
    Color? selectedItemColor,
    Color? unselectedItemColor,
    Color? selectionHighlightColor,
    double? selectionHighlightRadius,
    Color? buttonColor,
    Color? buttonTextColor,
    double? buttonBorderRadius,
    double? buttonHeight,
    double? buttonFontSize,
    Color? fadeColor,
  }) {
    return KhatebDatePickerTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      subtitleFontSize: subtitleFontSize ?? this.subtitleFontSize,
      titleFontWeight: titleFontWeight ?? this.titleFontWeight,
      subtitleFontWeight: subtitleFontWeight ?? this.subtitleFontWeight,
      selectedItemColor: selectedItemColor ?? this.selectedItemColor,
      unselectedItemColor: unselectedItemColor ?? this.unselectedItemColor,
      selectionHighlightColor:
          selectionHighlightColor ?? this.selectionHighlightColor,
      selectionHighlightRadius:
          selectionHighlightRadius ?? this.selectionHighlightRadius,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
      buttonBorderRadius: buttonBorderRadius ?? this.buttonBorderRadius,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      buttonFontSize: buttonFontSize ?? this.buttonFontSize,
      fadeColor: fadeColor ?? this.fadeColor,
    );
  }
}
