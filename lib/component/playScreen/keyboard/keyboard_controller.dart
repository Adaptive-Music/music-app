
import 'package:music_app/component/playScreen/keyboard/keyboard_model.dart';

class KeyboardController {
  final Keyboard keyboard;

  KeyboardController(this.keyboard);

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
    print("Key - Scale: ${keyboard.scale.name}");
    print("Key - Playing Mode: ${keyboard.playingMode.name}");
    print("Key settings loaded");
    return notes;
    
  }

}


