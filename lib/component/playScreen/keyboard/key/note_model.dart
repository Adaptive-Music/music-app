import 'package:music_app/special/enums.dart';

class Note {
  final List<int> keyPitchNotes;
  final Instrument instrument;
  

  const Note({
    required this.keyPitchNotes,
    required this.instrument,
  });

}