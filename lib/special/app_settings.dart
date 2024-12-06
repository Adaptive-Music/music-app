import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/special/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_app/special/app_settings_service.dart';

// Model class for app settings
class AppSettings {
  final KeyCenter keyCenter;
  final Octave octave;
  final Instrument instrument;
  final PlayingMode playingMode;

  const AppSettings({
    required this.keyCenter,
    required this.octave,
    required this.instrument,
    required this.playingMode,
  });
}

// Default settings
const defaultSettings = AppSettings(
  keyCenter: KeyCenter.cNat,
  octave: Octave.four,
  instrument: Instrument.piano,
  playingMode: PlayingMode.singleNote,
);

// StateNotifier class for app settings
class AppSettingsNotifier extends StateNotifier<AppSettings> {
  AppSettingsNotifier() : super(defaultSettings) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final service = AppSettingsService();
    state = await service.loadSettings();
  }

  void saveSettings(AppSettings settings) {
    final service = AppSettingsService();
    service.saveSettings(settings);
    state = settings;
  }
}