import 'package:flutter_test/flutter_test.dart';
import 'package:music_app/component/playScreen/keyboard/note/note_model.dart';
import 'package:music_app/component/playScreen/keyboard/note/note_viewmodel.dart';
import 'package:music_app/special/enums.dart';

void main() {
  group('Note Model', () {
    test('Note Instantiation with valid parameters', () {
        const noteModel = Note(
          keyPitchNotes: [45],
          instrument: Instrument.piano,
        );

        expect(noteModel.keyPitchNotes, [45]);
        expect(noteModel.instrument, Instrument.piano);  
    });

  });

  group('Note ViewModel', () {
    final noteViewModel = NoteViewModel(
      const Note(
        keyPitchNotes: [45],
        instrument: Instrument.piano,
      )
    ); 
    test('Play Note', () async {
      expect(noteViewModel.playing, false);
      noteViewModel.playNote();
      await Future.delayed(const Duration(seconds: 3));
      expect(noteViewModel.playing, true);
    });

    test('Stop Note', () async {
      noteViewModel.playNote();
      await Future.delayed(const Duration(seconds: 2));
      expect(noteViewModel.playing, true);
      await Future.delayed(const Duration(seconds: 3));
      noteViewModel.stopNote();
      expect(noteViewModel.playing, false);
    });

    test('Check Bounds', () {
      
    });

  });

}