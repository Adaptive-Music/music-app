import 'package:music_app/special/enums.dart';

class Note {
  final List<int> keyPitchNotes;
  final Scale scale;
  final Octave octave;
  final Instrument instrument;
  final PlayingMode playingMode;
  

  const Note({
    required this.keyPitchNotes,
    required this.scale,
    required this.octave,
    required this.instrument,
    required this.playingMode,
  });

}