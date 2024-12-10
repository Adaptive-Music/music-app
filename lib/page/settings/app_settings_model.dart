import 'package:music_app/special/enums.dart';

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




