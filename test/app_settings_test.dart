import 'dart:ffi';

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


  group('AppSettings Service', () {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs;
    
      const KeyCentre phKeyCenter = KeyCentre.cNat;
      const Octave phOctave = Octave.zero;
      const Instrument phInstrument = Instrument.piano;
      const Scale phScale = Scale.major;
      const PlayingMode phPlayingMode = PlayingMode.singleNote;

      final AppSettingsService controller = AppSettingsService();

    Future<dynamic> testInitSettings() async {
      prefs = await SharedPreferences.getInstance();
      await prefs.setString('keyCentre', phKeyCenter.name);
      await prefs.setString('octave', phOctave.name);
      await prefs.setString('instrument', phInstrument.name);
      await prefs.setString('playingMode', phPlayingMode.name);
      await prefs.setString('scale', phPlayingMode.name);
      
    }
    
    test('Load Settings Function', () async {
      await testInitSettings();

      AppSettings currentSettings = await controller.loadSettings();

      expect(phKeyCenter, currentSettings.keyCentre);
      expect(phOctave, currentSettings.octave);
      expect(phInstrument, currentSettings.instrument);
      expect(phScale, currentSettings.scale);
      expect(phPlayingMode, currentSettings.playingMode);
    });


    test('Save Settings Function', () async {
      await testInitSettings();

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

      AppSettings newSettings = await controller.loadSettings();

      expect(selectedKeyCentre, newSettings.keyCentre);
      expect(selectedScale, newSettings.scale);
      expect(selectedOctave, newSettings.octave);
      expect(selectedInstrument, newSettings.instrument);
      expect(selectedPlayingMode, newSettings.playingMode);

      await controller.saveSettings(AppSettings(
        keyCentre: phKeyCenter, 
        scale: phScale, 
        octave: phOctave, 
        instrument: phInstrument, 
        playingMode: phPlayingMode
      ));

      AppSettings phSettings = await controller.loadSettings();

      expect(phKeyCenter, phSettings.keyCentre);
      expect(phScale, phSettings.scale);
      expect(phOctave, phSettings.octave);
      expect(phInstrument, phSettings.instrument);
      expect(phPlayingMode, phSettings.playingMode);

    });

  });
}