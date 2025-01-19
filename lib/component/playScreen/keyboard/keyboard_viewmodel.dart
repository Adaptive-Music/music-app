
import 'dart:ffi';

import 'package:music_app/component/playScreen/keyboard/keyboard_model.dart';

class KeyboardViewModel {
  final Keyboard keyboard;

  KeyboardViewModel(this.keyboard);

  List<int> packNotes(int index, int startNote) {
    List<int> notes = [];
    if (index >= keyboard.scale.intervals.length) {
      return notes;
    }
    
    int rootNote = startNote + keyboard.scale.intervals[index];
    if (keyboard.playingMode.name == 'Single Note') {

      notes = [rootNote];

    } else if (keyboard.playingMode.name == 'Power Chord') {
      int fifthNote = rootNote + 5;
      int lowerRoot = rootNote - 12;
      notes = [
        lowerRoot,
        fifthNote,
        rootNote,
      ];
    } else {
      int thirdPos = (index + 2) % 7;
      int fifthPos = (index + 4) % 7;
      int thirdNote = index > thirdPos
          ? startNote + keyboard.scale.intervals[thirdPos] + 12
          : startNote + keyboard.scale.intervals[thirdPos];
      int fifthNote = index > fifthPos
          ? startNote + keyboard.scale.intervals[fifthPos] + 12
          : startNote + keyboard.scale.intervals[fifthPos];
      notes = [
        rootNote,
        thirdNote,
        fifthNote,
        rootNote + 12,
      ];
    }
    return notes;
    
  }

  List<List<List<int>>> buildOctScales() {
    List<int> startNotes = [keyboard.octave.number + keyboard.keyCentre.key, keyboard.octave.number + keyboard.keyCentre.key + 12];
    
    List<List<List<int>>> octScales = [];
    for (int startNote in startNotes) {
      List<List<int>> octave = [];
      for (int index in Iterable.generate(keyboard.scale.intervals.length)) {
        octave.add(packNotes(index, startNote));
      }
      octScales.add(octave);
    }
    return octScales;
  }

}


