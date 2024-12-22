import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/component/settings/app_settings_model.dart';
import 'package:music_app/component/settings/app_settings_service.dart';


// Notifier class for app settings
class AppSettingsNotifier extends Notifier<AppSettings> {
  final AppSettingsService _service = AppSettingsService();

  @override
  AppSettings build() {
    // Initialize the settings with default values
    _loadFromPrefs();
    return defaultSettings;
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
final appSettingsProvider = NotifierProvider<AppSettingsNotifier, AppSettings>(
  AppSettingsNotifier.new,
);





