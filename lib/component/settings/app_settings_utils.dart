import 'package:music_app/special/enums.dart';

List<PlayingMode> updateModeDrop(Scale selectedScale) {
  if (selectedScale.name == Scale.pentatonicMajor.name || selectedScale.name == Scale.pentatonicMinor.name) {
    return PlayingMode.values.where((mode) => mode.name != 'Triad Chord').toList();
  }
  return PlayingMode.values;
}

PlayingMode updateModeSelect(Scale selectedScale, PlayingMode selectedPlayingMode) {
  if (selectedScale.name == Scale.pentatonicMajor.name || selectedScale.name == Scale.pentatonicMinor.name) {
    return (selectedPlayingMode.name == PlayingMode.triadChord.name) ? PlayingMode.singleNote : selectedPlayingMode;
  }
  return selectedPlayingMode;
}