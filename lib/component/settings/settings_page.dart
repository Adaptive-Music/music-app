import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/component/settings/app_settings_model.dart';
import 'package:music_app/component/settings/app_settings_notifier.dart';
import 'package:music_app/component/settings/app_settings_service.dart';
import 'package:music_app/special/enums.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}


class _SettingsPageState extends ConsumerState<SettingsPage> {
  late Instrument selectedInstrument;
  late KeyCentre selectedKeyCentre;
  late Octave selectedOctave;
  late Scale selectedScale;
  late PlayingMode selectedPlayingMode;

  @override
  void initState() {
    super.initState();  
    final appSettings = ref.read(appSettingsProvider);
    selectedInstrument = appSettings.instrument;
    selectedKeyCentre = appSettings.keyCentre;
    selectedOctave = appSettings.octave;
    selectedScale = appSettings.scale;
    selectedPlayingMode = appSettings.playingMode;
  }

  @override
  Widget build(BuildContext context) {

    List<Instrument> dropdownInstruments = Instrument.values;
    List<KeyCentre> dropdownKeys = KeyCentre.values;
    List<Octave> dropdownOctaves = Octave.values;
    List<Scale> dropdownScales = Scale.values;
    List<PlayingMode> dropdownPlayingModes = updateModeDrop(selectedScale);

    selectedPlayingMode = updateModeSelect(selectedScale, selectedPlayingMode);

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
                      items: dropdownInstruments
                          .map((instrument) => DropdownMenuItem(
                                value: instrument,
                                child: Text(instrument.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedInstrument = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<KeyCentre>(
                      decoration: InputDecoration(labelText: 'Key Centre'),
                      value: selectedKeyCentre,
                      items: dropdownKeys
                          .map((keyCentre) => DropdownMenuItem(
                                value: keyCentre,
                                child: Text(keyCentre.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedKeyCentre = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<Scale>(
                      decoration: InputDecoration(labelText: 'Scale'),
                      value: selectedScale,
                      items: dropdownScales
                          .map((scale) => DropdownMenuItem(
                                value: scale,
                                child: Text(scale.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedScale = newValue!;
                          selectedPlayingMode = updateModeSelect(selectedScale, selectedPlayingMode);
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<Octave>(
                      decoration: InputDecoration(labelText: 'Octave'),
                      value: selectedOctave,
                      items: dropdownOctaves
                          .map((octave) => DropdownMenuItem(
                                value: octave,
                                child: Text(octave.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState((){
                          setState((){
                            selectedOctave = newValue!;
                          });
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<PlayingMode>(
                      decoration: InputDecoration(labelText: 'Keyboard Mode'),
                      value: selectedPlayingMode,
                      items: dropdownPlayingModes
                          .map((playingMode) => DropdownMenuItem(
                                value: playingMode,
                                child: Text(playingMode.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState((){
                          selectedPlayingMode = newValue!;
                        });
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
