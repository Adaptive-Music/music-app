import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/page/settings/app_settings_model.dart';
import 'package:music_app/page/settings/app_settings_service.dart';


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