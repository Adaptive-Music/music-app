import 'package:flutter_test/flutter_test.dart';
import 'package:music_app/component/playScreen/keyboard/keyboard_model.dart';
import 'package:music_app/component/playScreen/keyboard/keyboard_viewmodel.dart';
import 'package:music_app/special/enums.dart';

void main() {
  group('Keyboard Model', () {
    test('Keyboard Instantiation with valid parameters', () {
      const keyboardModel = Keyboard(
        keyCentre: KeyCentre.cNat, 
        scale: Scale.major, 
        octave: Octave.zero, 
        instrument: Instrument.piano, 
        playingMode: PlayingMode.singleNote
      );

      expect(keyboardModel.keyCentre, KeyCentre.cNat);
      expect(keyboardModel.scale, Scale.major); 
      expect(keyboardModel.octave, Octave.zero); 
      expect(keyboardModel.instrument, Instrument.piano);
      expect(keyboardModel.playingMode, PlayingMode.singleNote); 
    });

  });

  group('Keyboard ViewModel', () {
    group('PackNotes Function', () {
      test('Single Notes', () {
        final keyboardViewModel = KeyboardViewModel(
          const Keyboard(
            keyCentre: KeyCentre.cNat, 
            scale: Scale.major, 
            octave: Octave.zero, 
            instrument: Instrument.piano, 
            playingMode: PlayingMode.singleNote
          )
        );

        final notes = keyboardViewModel.packNotes(0, 60);

        expect(notes.length, 1);
        expect(notes, [60]);
      });

      test('Triad Chord Notes', () {
        final keyboardViewModel = KeyboardViewModel(
          const Keyboard(
            keyCentre: KeyCentre.cNat, 
            scale: Scale.major, 
            octave: Octave.zero, 
            instrument: Instrument.piano, 
            playingMode: PlayingMode.triadChord
          )
        );

        final notes = keyboardViewModel.packNotes(0, 60);

        expect(notes.length, 4);
        expect(notes, [60, 64, 67, 72]);
      });

      test('Power Chord Notes', () {
        final keyboardViewModel = KeyboardViewModel(
          const Keyboard(
            keyCentre: KeyCentre.cNat, 
            scale: Scale.major, 
            octave: Octave.zero, 
            instrument: Instrument.piano, 
            playingMode: PlayingMode.powerChord
          )
        );

        final notes = keyboardViewModel.packNotes(0, 60);

        expect(notes.length, 3);
        expect(notes, [48, 65, 60]);
      });
    });
    
    group('Build Octaves Function', () {
      test('Single Notes', () {
        final keyboardViewModel = KeyboardViewModel(
          const Keyboard(
            keyCentre: KeyCentre.cNat, 
            scale: Scale.major, 
            octave: Octave.zero, 
            instrument: Instrument.piano, 
            playingMode: PlayingMode.singleNote
          )
        );

        List<List<List<int>>> octScalesSingle = keyboardViewModel.buildOctScales();

        List<List<List<int>>> singleExpected = [
              [[12], [14], [16], [17], [19], [21], [23]],
              [[24], [26], [28], [29], [31], [33], [35]]
            ];
        expect(octScalesSingle, singleExpected);
      });

      test('Triad Chord Notes', () {
        final keyboardViewModel = KeyboardViewModel(
          const Keyboard(
            keyCentre: KeyCentre.cNat, 
            scale: Scale.major, 
            octave: Octave.zero, 
            instrument: Instrument.piano, 
            playingMode: PlayingMode.triadChord
          )
        );

        List<List<List<int>>> octScalesTriad = keyboardViewModel.buildOctScales();

        List<List<List<int>>> triadExpected = [
              [
                [12, 16, 19, 24],
                [14, 17, 21, 26],
                [16, 19, 23, 28],
                [17, 21, 24, 29],
                [19, 23, 26, 31],
                [21, 24, 28, 33],
                [23, 26, 29, 35]
              ],
              [
                [24, 28, 31, 36],
                [26, 29, 33, 38],
                [28, 31, 35, 40],
                [29, 33, 36, 41],
                [31, 35, 38, 43],
                [33, 36, 40, 45],
                [35, 38, 41, 47]
              ]
            ];
        expect(octScalesTriad, triadExpected);

      });

      test('Power Chord Notes', () {
        final keyboardViewModel = KeyboardViewModel(
          const Keyboard(
            keyCentre: KeyCentre.cNat, 
            scale: Scale.major, 
            octave: Octave.zero, 
            instrument: Instrument.piano, 
            playingMode: PlayingMode.powerChord
          )
        );

        List<List<List<int>>> octScalesPower = keyboardViewModel.buildOctScales();

        List<List<List<int>>> powerExpected = [
              [
                [0, 17, 12],
                [2, 19, 14],
                [4, 21, 16],
                [5, 22, 17],
                [7, 24, 19],
                [9, 26, 21],
                [11, 28, 23]
              ],
              [
                [12, 29, 24],
                [14, 31, 26],
                [16, 33, 28],
                [17, 34, 29],
                [19, 36, 31],
                [21, 38, 33],
                [23, 40, 35]
              ]
            ];
        expect(octScalesPower, powerExpected);


      });
    });

  });

}