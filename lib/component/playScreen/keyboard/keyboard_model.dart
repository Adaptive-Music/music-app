import 'package:music_app/special/enums.dart';

// Model class for Keyboard
class Keyboard {
  final KeyCentre keyCentre;
  final Scale scale;
  final Octave octave;
  final Instrument instrument;
  final PlayingMode playingMode;

  const Keyboard({
    required this.keyCentre,
    required this.scale,
    required this.octave,
    required this.instrument,
    required this.playingMode,
  });

}