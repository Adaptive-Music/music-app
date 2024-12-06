import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/special/enums.dart';
import 'package:music_app/special/app_settings_service.dart';

// Model class for app settings
class AppSettings {
  final KeyCentre keyCentre;
  final Scale scale;
  final Octave octave;
  final Instrument instrument;
  final PlayingMode playingMode;

  const AppSettings({
    required this.keyCentre,
    required this.scale,
    required this.octave,
    required this.instrument,
    required this.playingMode,
  });

  @override
  String toString() {
    return 'AppSettings{keyCentre: $keyCentre, scale: $scale, octave: $octave, instrument: $instrument, playingMode: $playingMode}';
  }
}

// Default settings
const defaultSettings = AppSettings(
  keyCentre: KeyCentre.cNat,
  scale: Scale.major,
  octave: Octave.four,
  instrument: Instrument.piano,
  playingMode: PlayingMode.singleNote,
);

// StateNotifier class for app settings
class AppSettingsNotifier extends StateNotifier<AppSettings> {
  final AppSettingsService _service = AppSettingsService();

  AppSettingsNotifier() : super(defaultSettings) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    state = await _service.loadSettings();
  }

  void saveSettings(AppSettings settings) {
    _service.saveSettings(settings);
    state = settings;
  }
}

// Provider for AppSettingsNotifier
final appSettingsProvider =
    StateNotifierProvider<AppSettingsNotifier, AppSettings>(
  (ref) => AppSettingsNotifier(),
);
