import 'package:flutter_test/flutter_test.dart';
import 'package:music_app/component/settings/app_settings_model.dart';
import 'package:music_app/component/settings/app_settings_service.dart';
import 'package:music_app/special/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AppSettings Model', () {
    test('AppSettings Instantiation with valid parameters', () {
      final appSettings = AppSettings(
        keyCentre: KeyCentre.cNat,
        scale: Scale.major,
        octave: Octave.four,
        instrument: Instrument.piano,
        playingMode: PlayingMode.singleNote,
      );

      expect(appSettings.keyCentre, KeyCentre.cNat);
      expect(appSettings.scale, Scale.major);
      expect(appSettings.octave, Octave.four);
      expect(appSettings.instrument, Instrument.piano);
      expect(appSettings.playingMode, PlayingMode.singleNote);
    });

    test('Setting keyCentre property', () {
      final appSettings = AppSettings(
        keyCentre: KeyCentre.cNat,
        scale: Scale.major,
        octave: Octave.four,
        instrument: Instrument.piano,
        playingMode: PlayingMode.singleNote,
      );

      appSettings.keyCentre = KeyCentre.gNat;

      expect(appSettings.keyCentre, KeyCentre.gNat);
      expect(appSettings.scale, Scale.major);
      expect(appSettings.octave, Octave.four);
      expect(appSettings.instrument, Instrument.piano);
      expect(appSettings.playingMode, PlayingMode.singleNote);
    });

    test('Setting scale property', () {
      final appSettings = AppSettings(
        keyCentre: KeyCentre.cNat,
        scale: Scale.major,
        octave: Octave.four,
        instrument: Instrument.piano,
        playingMode: PlayingMode.singleNote,
      );

      appSettings.scale = Scale.minor;

      expect(appSettings.keyCentre, KeyCentre.cNat);
      expect(appSettings.scale, Scale.minor);
      expect(appSettings.octave, Octave.four);
      expect(appSettings.instrument, Instrument.piano);
      expect(appSettings.playingMode, PlayingMode.singleNote);
    });

    test('Setting octave property', () {
      final appSettings = AppSettings(
        keyCentre: KeyCentre.cNat,
        scale: Scale.major,
        octave: Octave.four,
        instrument: Instrument.piano,
        playingMode: PlayingMode.singleNote,
      );

      appSettings.octave = Octave.two;

      expect(appSettings.keyCentre, KeyCentre.cNat);
      expect(appSettings.scale, Scale.major);
      expect(appSettings.octave, Octave.two);
      expect(appSettings.instrument, Instrument.piano);
      expect(appSettings.playingMode, PlayingMode.singleNote);
    });

    test('Setting instrument property', () {
      final appSettings = AppSettings(
        keyCentre: KeyCentre.cNat,
        scale: Scale.major,
        octave: Octave.four,
        instrument: Instrument.piano,
        playingMode: PlayingMode.singleNote,
      );

      appSettings.instrument = Instrument.acousticGuitar;

      expect(appSettings.keyCentre, KeyCentre.cNat);
      expect(appSettings.scale, Scale.major);
      expect(appSettings.octave, Octave.four);
      expect(appSettings.instrument, Instrument.acousticGuitar);
      expect(appSettings.playingMode, PlayingMode.singleNote);
    });

    test('Setting playingMode property', () {
      final appSettings = AppSettings(
        keyCentre: KeyCentre.cNat,
        scale: Scale.major,
        octave: Octave.four,
        instrument: Instrument.piano,
        playingMode: PlayingMode.singleNote,
      );

      appSettings.playingMode = PlayingMode.triadChord;

      expect(appSettings.keyCentre, KeyCentre.cNat);
      expect(appSettings.scale, Scale.major);
      expect(appSettings.octave, Octave.four);
      expect(appSettings.instrument, Instrument.piano);
      expect(appSettings.playingMode, PlayingMode.triadChord);
    });
  });


  group('AppSettings Service', () async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    final phKeyCenter = KeyCentre.values.firstWhere(
      (e) => e.name == prefs.getString('keyCentre'));
    final phOctave = Octave.values.firstWhere(
      (e) => e.name == prefs.getString('octave'));
    final phInstrument = Instrument.values.firstWhere(
      (e) => e.name == prefs.getString('instrument'));
    final phScale = Scale.values.firstWhere(
      (e) => e.name == prefs.getString('scale'));
    final phPlayingMode = PlayingMode.values.firstWhere(
      (e) => e.name == prefs.getString('playingMode'));

    final AppSettingsService controller = AppSettingsService();


    test('Load Settings Function', () async {
      AppSettings currentSettings = await controller.loadSettings();
      expect(phKeyCenter, currentSettings.keyCentre);
      expect(phOctave, currentSettings.octave);
      expect(phInstrument, currentSettings.instrument);
      expect(phScale, currentSettings.scale);
      expect(phPlayingMode, currentSettings.playingMode);
    });


    test('Save Settings Function', () async {
      AppSettings currentSettings = await controller.loadSettings();

      KeyCentre selectedKeyCentre = (currentSettings.keyCentre != KeyCentre.cNat) ? KeyCentre.cNat : KeyCentre.cSh;
      Scale selectedScale = (currentSettings.scale != Scale.major) ? Scale.major : Scale.minor;
      Octave selectedOctave = (currentSettings.octave != Octave.zero) ? Octave.zero : Octave.one;
      Instrument selectedInstrument = (currentSettings.instrument != Instrument.piano) ? Instrument.piano : Instrument.violin;
      PlayingMode selectedPlayingMode = (currentSettings.playingMode != PlayingMode.singleNote) ? PlayingMode.singleNote : PlayingMode.triadChord;

      await controller.saveSettings(AppSettings(
        keyCentre: selectedKeyCentre, 
        scale: selectedScale, 
        octave: selectedOctave, 
        instrument: selectedInstrument, 
        playingMode: selectedPlayingMode
      ));

      expect(selectedKeyCentre, currentSettings.keyCentre);
      expect(selectedScale, currentSettings.octave);
      expect(selectedOctave, currentSettings.instrument);
      expect(selectedInstrument, currentSettings.scale);
      expect(selectedPlayingMode, currentSettings.playingMode);


      await controller.saveSettings(AppSettings(
        keyCentre: phKeyCenter, 
        scale: phScale, 
        octave: phOctave, 
        instrument: phInstrument, 
        playingMode: phPlayingMode
      ));

      expect(phKeyCenter, currentSettings.keyCentre);
      expect(phScale, currentSettings.octave);
      expect(phOctave, currentSettings.instrument);
      expect(phInstrument, currentSettings.scale);
      expect(phPlayingMode, currentSettings.playingMode);

    });



    await prefs.setString('keyCentre', phKeyCenter.name);
    await prefs.setString('octave', phOctave.name);
    await prefs.setString('instrument', phInstrument.name);
    await prefs.setString('playingMode', phPlayingMode.name);
    await prefs.setString('scale', phScale.name);

  });
}