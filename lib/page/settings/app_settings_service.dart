import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_app/special/enums.dart';
import 'package:music_app/page/settings/app_settings_model.dart';

// Service class to handle saving and loading app settings
class AppSettingsService {
  SharedPreferences? _prefs;

  Future<void> _initializePrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<AppSettings> loadSettings() async {
    await _initializePrefs();
    final keyCenter = KeyCentre.values.firstWhere(
      (e) => e.name == _prefs?.getString('keyCentre'),
      orElse: () => defaultSettings.keyCentre,
    );
    final octave = Octave.values.firstWhere(
      (e) => e.name == _prefs?.getString('octave'),
      orElse: () => defaultSettings.octave,
    );
    final instrument = Instrument.values.firstWhere(
      (e) => e.name == _prefs?.getString('instrument'),
      orElse: () => defaultSettings.instrument,
    );
    final playingMode = PlayingMode.values.firstWhere(
      (e) => e.name == _prefs?.getString('playingMode'),
      orElse: () => defaultSettings.playingMode,
    );
    final scale = Scale.values.firstWhere(
      (e) => e.name == _prefs?.getString('scale'),
      orElse: () => defaultSettings.scale,
    );
    AppSettings settings = AppSettings(
      keyCentre: keyCenter,
      scale: scale,
      octave: octave,
      instrument: instrument,
      playingMode: playingMode,
    );
    print('Loaded settings: $settings');
    return settings;
  }

  Future<void> saveSettings(AppSettings settings) async {
    await _initializePrefs();
    await _prefs?.setString('keyCentre', settings.keyCentre.name);
    await _prefs?.setString('octave', settings.octave.name);
    await _prefs?.setString('instrument', settings.instrument.name);
    await _prefs?.setString('playingMode', settings.playingMode.name);
    await _prefs?.setString('scale', settings.scale.name);
    print('Saved settings: $settings');
  }
}

const defaultSettings = AppSettings(
  keyCentre: KeyCentre.cNat,
  scale: Scale.major,
  octave: Octave.four,
  instrument: Instrument.piano,
  playingMode: PlayingMode.singleNote,
);
