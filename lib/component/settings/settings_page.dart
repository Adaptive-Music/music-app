import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/component/settings/app_settings_model.dart';
import 'package:music_app/component/settings/app_settings_notifier.dart';
import 'package:music_app/component/settings/app_settings_utils.dart';
import 'package:music_app/special/enums.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}


class _SettingsPageState extends ConsumerState<SettingsPage> {

  late AppSettings selectedSettings;

  @override
  void initState() {
    super.initState();  
    final appSettings = ref.read(appSettingsProvider);

    selectedSettings = AppSettings(
                        keyCentre: appSettings.keyCentre,
                        scale: appSettings.scale,
                        octave: appSettings.octave,
                        instrument: appSettings.instrument,
                        playingMode: appSettings.playingMode,
                      );
  }

  @override
  Widget build(BuildContext context) {

    List<Instrument> dropdownInstruments = Instrument.values;
    List<KeyCentre> dropdownKeys = KeyCentre.values;
    List<Octave> dropdownOctaves = Octave.values;
    List<Scale> dropdownScales = Scale.values;
    List<PlayingMode> dropdownPlayingModes = updateModeDrop(selectedSettings.scale);

    selectedSettings.playingMode = updateModeSelect(selectedSettings.scale, selectedSettings.playingMode);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
                      decoration: const InputDecoration(labelText: 'Instrument'),
                      value: selectedSettings.instrument,
                      items: dropdownInstruments
                          .map((instrument) => DropdownMenuItem(
                                value: instrument,
                                child: Text(instrument.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedSettings.instrument = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<KeyCentre>(
                      decoration: const InputDecoration(labelText: 'Key Centre'),
                      value: selectedSettings.keyCentre,
                      items: dropdownKeys
                          .map((keyCentre) => DropdownMenuItem(
                                value: keyCentre,
                                child: Text(keyCentre.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedSettings.keyCentre = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Scale>(
                      decoration: const InputDecoration(labelText: 'Scale'),
                      value: selectedSettings.scale,
                      items: dropdownScales
                          .map((scale) => DropdownMenuItem(
                                value: scale,
                                child: Text(scale.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedSettings.scale = newValue!;
                          selectedSettings.playingMode = updateModeSelect(selectedSettings.scale, selectedSettings.playingMode);
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Octave>(
                      decoration: const InputDecoration(labelText: 'Octave'),
                      value: selectedSettings.octave,
                      items: dropdownOctaves
                          .map((octave) => DropdownMenuItem(
                                value: octave,
                                child: Text(octave.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState((){
                          setState((){
                            selectedSettings.octave = newValue!;
                          });
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<PlayingMode>(
                      decoration: const InputDecoration(labelText: 'Keyboard Mode'),
                      value: selectedSettings.playingMode,
                      items: dropdownPlayingModes
                          .map((playingMode) => DropdownMenuItem(
                                value: playingMode,
                                child: Text(playingMode.name),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState((){
                          selectedSettings.playingMode = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 32),
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
                        keyCentre: selectedSettings.keyCentre,
                        scale: selectedSettings.scale,
                        octave: selectedSettings.octave,
                        instrument: selectedSettings.instrument,
                        playingMode: selectedSettings.playingMode,
                      ),
                    );
                Navigator.pop(context);
              },
              child: const Text('Save Settings'),
            ),
          ),
        ],
      ),
    );
  }
}
