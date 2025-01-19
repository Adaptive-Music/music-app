import 'package:music_app/special/enums.dart';

// Model class for app settings
class AppSettings {
  KeyCentre keyCentre;
  Scale scale;
  Octave octave;
  Instrument instrument;
  PlayingMode playingMode;

   AppSettings({
    required this.keyCentre,
    required this.scale,
    required this.octave,
    required this.instrument,
    required this.playingMode,
  });
}