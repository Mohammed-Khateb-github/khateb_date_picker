import 'package:flutter/material.dart';
import 'package:khateb_date_picker/khateb_date_picker.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'khateb_date_picker example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? _picked;

  Future<void> _showLight(BuildContext ctx) async {
    final date = await KhatebDatePicker.show(
      context: ctx,
      title: 'Date of Birth',
      subtitle: 'Select your birth date',
      buttonText: 'Choose',
      initialDate: DateTime(1995, 6, 15),
      minDate: DateTime(1980),
      maxDate: DateTime(2007),
      // theme defaults to KhatebDatePickerTheme.light()
    );
    if (date != null) setState(() => _picked = date);
  }

  Future<void> _showDark(BuildContext ctx) async {
    final date = await KhatebDatePicker.show(
      context: ctx,
      title: 'Date of Birth',
      subtitle: 'Select your birth date',
      buttonText: 'Confirm',
      initialDate: _picked ?? DateTime(1995, 6, 15),
      minDate: DateTime(1980),
      maxDate: DateTime(2007),
      theme: KhatebDatePickerTheme.dark(),
    );
    if (date != null) setState(() => _picked = date);
  }

  Future<void> _showCustom(BuildContext ctx) async {
    final date = await KhatebDatePicker.show(
      context: ctx,
      title: 'Birthdate',
      subtitle: 'Pick any date',
      buttonText: 'Done',
      initialDate: _picked ?? DateTime(1995, 6, 15),
      minDate: DateTime(1980),
      maxDate: DateTime(2007),
      theme: KhatebDatePickerTheme.light().copyWith(
        buttonColor: Colors.deepPurple,
        buttonBorderRadius: 20,
        selectedItemColor: Colors.deepPurple,
      ),
    );
    if (date != null) setState(() => _picked = date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('khateb_date_picker demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_picked != null) ...[
              Text(
                'Picked: ${_picked!.year}-'
                '${_picked!.month.toString().padLeft(2, '0')}-'
                '${_picked!.day.toString().padLeft(2, '0')}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
            ],

            // ── Light theme ─────────────────────────────────────────────────
            ElevatedButton(
              onPressed: () => _showLight(context),
              child: const Text('Show – Light theme (default)'),
            ),
            const SizedBox(height: 12),

            // ── Dark theme ──────────────────────────────────────────────────
            ElevatedButton(
              onPressed: () => _showDark(context),
              child: const Text('Show – Dark theme'),
            ),
            const SizedBox(height: 12),

            // ── Custom theme ─────────────────────────────────────────────────
            ElevatedButton(
              onPressed: () => _showCustom(context),
              child: const Text('Show – Custom theme (purple)'),
            ),
            const SizedBox(height: 32),

            // ── Inline embedded picker ───────────────────────────────────────
            const Text('Inline (embedded) picker:'),
            const SizedBox(height: 8),
            ModernDatePickerWidget(
              initialDate: _picked ?? DateTime(1995, 6, 15),
              minDate: DateTime(1980),
              maxDate: DateTime(2007),
              theme: KhatebDatePickerTheme.light(),
              onChanged: (date) => setState(() => _picked = date),
            ),
          ],
        ),
      ),
    );
  }
}
