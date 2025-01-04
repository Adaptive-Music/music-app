import 'package:flutter/services.dart' show HapticFeedback, Offset, Rect;
import 'package:music_app/component/playScreen/keyboard/note/note_model.dart';

class NoteViewModel {
  final Note note;

  NoteViewModel(this.note);

  bool playing = false;
  late Rect bounds;

  void playNote() {
    HapticFeedback.mediumImpact();  // Add haptic feedback
    for (var i = 0; i < note.keyPitchNotes.length; i++) {
      print('play midi notes');
    }
      playing = true;
  }

  void stopNote() {
    for (var i = 0; i < note.keyPitchNotes.length; i++) {
      print('stop midi note');
    }
      playing = false;
  }

  void checkTouches(Map<int, Offset> touchPositions) {
    bool isTouched = touchPositions.values.any((position) {
      return bounds.contains(position);
    });
    if (isTouched && !playing) {
      playNote();
    } else if (!isTouched && playing) {
      stopNote();
    }
  }
}