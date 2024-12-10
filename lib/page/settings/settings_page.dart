import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/page/settings/app_settings_model.dart';
import 'package:music_app/page/settings/app_settings_notifier.dart';
import 'package:music_app/special/enums.dart';

class SettingsPage extends ConsumerWidget {
  late Instrument selectedInstrument;
  late KeyCentre selectedKeyCentre;
  late Octave selectedOctave;
  late Scale selectedScale;
  late PlayingMode selectedPlayingMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    selectedInstrument = appSettings.instrument;
    selectedKeyCentre = appSettings.keyCentre;
    selectedOctave = appSettings.octave;
    selectedScale = appSettings.scale;
    selectedPlayingMode = appSettings.playingMode;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<Instrument>(
                      decoration: InputDecoration(labelText: 'Instrument'),
                      value: selectedInstrument,
                      items: Instrument.values
                          .map((instrument) => DropdownMenuItem(
                                value: instrument,
                                child: Text(instrument.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        selectedInstrument = newValue!;
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<KeyCentre>(
                      decoration: InputDecoration(labelText: 'Key Centre'),
                      value: selectedKeyCentre,
                      items: KeyCentre.values
                          .map((keyCentre) => DropdownMenuItem(
                                value: keyCentre,
                                child: Text(keyCentre.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        selectedKeyCentre = newValue!;
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<Scale>(
                      decoration: InputDecoration(labelText: 'Scale'),
                      value: selectedScale,
                      items: Scale.values
                          .map((scale) => DropdownMenuItem(
                                value: scale,
                                child: Text(scale.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        selectedScale = newValue!;
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<Octave>(
                      decoration: InputDecoration(labelText: 'Octave'),
                      value: selectedOctave,
                      items: Octave.values
                          .map((octave) => DropdownMenuItem(
                                value: octave,
                                child: Text(octave.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        selectedOctave = newValue!;
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<PlayingMode>(
                      decoration: InputDecoration(labelText: 'Keyboard Mode'),
                      value: selectedPlayingMode,
                      items: PlayingMode.values
                          .map((playingMode) => DropdownMenuItem(
                                value: playingMode,
                                child: Text(playingMode.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        selectedPlayingMode = newValue!;
                      },
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                ref.read(appSettingsProvider.notifier).saveSettings(
                      AppSettings(
                        keyCentre: selectedKeyCentre,
                        scale: selectedScale,
                        octave: selectedOctave,
                        instrument: selectedInstrument,
                        playingMode: selectedPlayingMode,
                      ),
                    );
                Navigator.pop(context);
              },
              child: Text('Save Settings'),
            ),
          ),
        ],
      ),
    );
  }
}
