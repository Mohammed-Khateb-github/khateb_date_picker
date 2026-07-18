import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'khateb_date_picker_theme.dart';

/// A standalone iOS-style drum-roll date picker widget.
///
/// Displays three scrollable columns – **day**, **month**, and **year** –
/// each rendered as a [ListWheelScrollView] with a smooth 3-D drum-roll effect.
///
/// You can embed this widget directly in any layout, or use
/// [KhatebDatePicker.show] for the ready-made bottom-sheet flow.
///
/// ### Basic usage
/// ```dart
/// ModernDatePickerWidget(
///   initialDate: DateTime(1995, 6, 15),
///   minDate: DateTime(1980),
///   maxDate: DateTime(2007),
///   theme: KhatebDatePickerTheme.light(),
///   onChanged: (date) => print(date),
/// )
/// ```
class ModernDatePickerWidget extends StatefulWidget {
  /// The date that is pre-selected when the widget first mounts.
  final DateTime initialDate;

  /// The earliest date the user can scroll to.
  final DateTime minDate;

  /// The latest date the user can scroll to.
  final DateTime maxDate;

  /// Called every time the user scrolls to a new date.
  final ValueChanged<DateTime> onChanged;

  /// Visual configuration. See [KhatebDatePickerTheme] for all options.
  final KhatebDatePickerTheme theme;

  /// Creates a [ModernDatePickerWidget].
  const ModernDatePickerWidget({
    super.key,
    required this.initialDate,
    required this.minDate,
    required this.maxDate,
    required this.onChanged,
    required this.theme,
  });

  @override
  State<ModernDatePickerWidget> createState() => _ModernDatePickerWidgetState();
}

class _ModernDatePickerWidgetState extends State<ModernDatePickerWidget> {
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _yearController;

  late int _selectedDay;
  late int _selectedMonth;
  late int _selectedYear;

  late int _minYear;
  late int _maxYear;
  late int _minMonth;
  late int _maxMonth;
  late int _minDay;
  late int _maxDay;

  bool _isInitializing = true;

  static const double _itemExtent = 42.0;
  static const double _pickerHeight = 260.0;

  // ── Lifecycle ────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();

    _selectedDay = widget.initialDate.day;
    _selectedMonth = widget.initialDate.month;
    _selectedYear = widget.initialDate.year;

    _minYear = widget.minDate.year;
    _maxYear = widget.maxDate.year;
    _minMonth = widget.minDate.month;
    _maxMonth = widget.maxDate.month;
    _minDay = widget.minDate.day;
    _maxDay = widget.maxDate.day;

    _dayController = FixedExtentScrollController(
      initialItem: _selectedDay - _dayLowerBound(_selectedYear, _selectedMonth),
    );
    _monthController = FixedExtentScrollController(
      initialItem: _selectedMonth - 1,
    );
    _yearController = FixedExtentScrollController(
      initialItem: _selectedYear - _minYear,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isInitializing = false;
    });
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  // ── Date helpers ─────────────────────────────────────────────────────────────

  int _getDaysInMonth(int year, int month) {
    if (month == 2) return _isLeapYear(year) ? 29 : 28;
    const days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return days[month - 1];
  }

  bool _isLeapYear(int year) =>
      (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

  int _dayLowerBound(int year, int month) {
    if (year == _minYear && month == _minMonth) return _minDay;
    return 1;
  }

  int _dayUpperBound(int year, int month) {
    int upper = _getDaysInMonth(year, month);
    if (year == _maxYear && month == _maxMonth) upper = min(upper, _maxDay);
    return upper;
  }

  int _dayCount(int year, int month) =>
      _dayUpperBound(year, month) - _dayLowerBound(year, month) + 1;

  int _clampDay(int year, int month, int day) {
    return day.clamp(_dayLowerBound(year, month), _dayUpperBound(year, month));
  }

  // ── Callbacks ────────────────────────────────────────────────────────────────

  void _feedback() => HapticFeedback.selectionClick();

  void _notify() =>
      widget.onChanged(DateTime(_selectedYear, _selectedMonth, _selectedDay));

  void _updateDay(int index) {
    final lower = _dayLowerBound(_selectedYear, _selectedMonth);
    setState(() => _selectedDay = lower + index);
    if (!_isInitializing) {
      _feedback();
      _notify();
    }
  }

  void _updateMonth(int index) {
    setState(() {
      _selectedMonth = index + 1;
      final clamped = _clampDay(_selectedYear, _selectedMonth, _selectedDay);
      if (clamped != _selectedDay) {
        _selectedDay = clamped;
        _dayController.jumpToItem(
            _selectedDay - _dayLowerBound(_selectedYear, _selectedMonth));
      }
    });
    if (!_isInitializing) {
      _feedback();
      _notify();
    }
  }

  void _updateYear(int index) {
    setState(() {
      _selectedYear = index + _minYear;
      final clamped = _clampDay(_selectedYear, _selectedMonth, _selectedDay);
      if (clamped != _selectedDay) {
        _selectedDay = clamped;
        _dayController.jumpToItem(
            _selectedDay - _dayLowerBound(_selectedYear, _selectedMonth));
      }
    });
    if (!_isInitializing) {
      _feedback();
      _notify();
    }
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final t = widget.theme;
    final dayLower = _dayLowerBound(_selectedYear, _selectedMonth);
    final dayCount = _dayCount(_selectedYear, _selectedMonth);

    return SizedBox(
      height: _pickerHeight,
      child: Stack(
        children: [
          // ── Wheels ──────────────────────────────────────────────────────────
          Row(
            children: [
              // Day
              Expanded(
                child: _buildWheel(
                  controller: _dayController,
                  itemCount: dayCount,
                  builder: (_, i) => _buildItem(
                    text: (dayLower + i).toString().padLeft(2, '0'),
                    isSelected: (dayLower + i) == _selectedDay,
                    theme: t,
                  ),
                  onChanged: _updateDay,
                  itemCount2: dayCount,
                ),
              ),
              // Month
              Expanded(
                child: _buildWheel(
                  controller: _monthController,
                  itemCount: 12,
                  builder: (_, i) => _buildItem(
                    text: (i + 1).toString().padLeft(2, '0'),
                    isSelected: (i + 1) == _selectedMonth,
                    theme: t,
                  ),
                  onChanged: _updateMonth,
                  itemCount2: 12,
                ),
              ),
              // Year
              Expanded(
                child: _buildWheel(
                  controller: _yearController,
                  itemCount: _maxYear - _minYear + 1,
                  builder: (_, i) => _buildItem(
                    text: '${i + _minYear}',
                    isSelected: (i + _minYear) == _selectedYear,
                    theme: t,
                  ),
                  onChanged: _updateYear,
                  itemCount2: _maxYear - _minYear + 1,
                ),
              ),
            ],
          ),

          // ── Selection highlight band ─────────────────────────────────────────
          Positioned.fill(
            child: IgnorePointer(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: _itemExtent,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: t.selectionHighlightColor,
                    borderRadius:
                        BorderRadius.circular(t.selectionHighlightRadius),
                  ),
                ),
              ),
            ),
          ),

          // ── Top fade ────────────────────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 60,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [t.fadeColor, t.fadeColor.withValues(alpha: 0)],
                  ),
                ),
              ),
            ),
          ),

          // ── Bottom fade ──────────────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 60,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [t.fadeColor, t.fadeColor.withValues(alpha: 0)],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWheel({
    required FixedExtentScrollController controller,
    required int itemCount,
    required int itemCount2,
    required Widget Function(BuildContext, int) builder,
    required ValueChanged<int> onChanged,
  }) {
    return SizedBox(
      height: _pickerHeight,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: _itemExtent,
        diameterRatio: 1.4,
        perspective: 0.003,
        physics: const FixedExtentScrollPhysics(),
        overAndUnderCenterOpacity: 0.55,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: itemCount2,
          builder: builder,
        ),
        onSelectedItemChanged: (i) {
          if (i >= 0 && i < itemCount) onChanged(i);
        },
      ),
    );
  }

  Widget _buildItem({
    required String text,
    required bool isSelected,
    required KhatebDatePickerTheme theme,
  }) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      style: TextStyle(
        color: isSelected ? theme.selectedItemColor : theme.unselectedItemColor,
        fontSize: isSelected ? 20.0 : 18.0,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
      ),
      child: Container(
        height: _itemExtent,
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }
}
