import 'package:flutter/material.dart';

/// Holds all visual tokens for the date picker.
///
/// Create your own instance to fully brand the widget, or start from
/// [KhatebDatePickerTheme.light] / [KhatebDatePickerTheme.dark].
class KhatebDatePickerTheme {
  // ── Background ──────────────────────────────────────────────────────────────
  final Color backgroundColor;

  // ── Typography ───────────────────────────────────────────────────────────────
  final Color titleColor;
  final Color subtitleColor;

  final double titleFontSize;
  final double subtitleFontSize;
  final FontWeight titleFontWeight;
  final FontWeight subtitleFontWeight;

  // ── Wheel ────────────────────────────────────────────────────────────────────
  /// Color for the currently selected wheel item.
  final Color selectedItemColor;

  /// Color for un-selected wheel items.
  final Color unselectedItemColor;

  /// Background color of the center-row highlight band.
  final Color selectionHighlightColor;

  /// Border radius of the center-row highlight band.
  final double selectionHighlightRadius;

  // ── Button ───────────────────────────────────────────────────────────────────
  final Color buttonColor;
  final Color buttonTextColor;
  final double buttonBorderRadius;
  final double buttonHeight;
  final double buttonFontSize;

  // ── Gradient fade overlays ────────────────────────────────────────────────────
  /// The colour used for the top/bottom fade overlays.
  /// Should match [backgroundColor] for a seamless look.
  final Color fadeColor;

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

  /// Default light theme.
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

  /// Dark theme variant.
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

  /// Copy with overrides.
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
