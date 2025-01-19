import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_app/component/settings/app_settings_model.dart';
import 'package:music_app/component/settings/app_settings_service.dart';
import 'package:music_app/component/settings/app_settings_utils.dart';
import 'package:music_app/component/settings/app_settings_notifier.dart';
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

      expect(currentSettings.keyCentre, phKeyCenter);
      expect(currentSettings.octave, phOctave);
      expect(currentSettings.instrument, phInstrument);
      expect(currentSettings.scale, phScale);
      expect(currentSettings.playingMode, phPlayingMode);
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


      expect(newSettings.keyCentre, selectedKeyCentre);
      expect(newSettings.scale, selectedScale);
      expect(newSettings.octave, selectedOctave);
      expect(newSettings.instrument, selectedInstrument);
      expect(newSettings.playingMode, selectedPlayingMode);

      await controller.saveSettings(AppSettings(
        keyCentre: phKeyCenter, 
        scale: phScale, 
        octave: phOctave, 
        instrument: phInstrument, 
        playingMode: phPlayingMode
      ));

      AppSettings phSettings = await controller.loadSettings();

      expect(phSettings.keyCentre, phKeyCenter);
      expect(phSettings.scale, phScale);
      expect(phSettings.octave, phOctave);
      expect(phSettings.instrument, phInstrument);
      expect(phSettings.playingMode, phPlayingMode);

    });

  });

  group('AppSettings Utils', () {

    group('updateModeDrop Function', () {

      test('updateModeDrop Function - 3 Modes', () {
    
      List<PlayingMode> majorDropList = updateModeDrop(Scale.major); 
      expect(majorDropList.length, 3);

      List<PlayingMode> minorDropList = updateModeDrop(Scale.minor); 
      expect(minorDropList.length, 3);

      List<PlayingMode> harMinorDropList = updateModeDrop(Scale.harmonicMinor); 
      expect(harMinorDropList.length, 3);

      });

      test('updateModeDrop Function - 2 Modes', () {
      
        List<PlayingMode> pentaMajorDropList = updateModeDrop(Scale.pentatonicMajor); 
        expect(pentaMajorDropList.length, 2);

        List<PlayingMode> pentaMinorDropList = updateModeDrop(Scale.pentatonicMinor); 
        expect(pentaMinorDropList.length, 2);

      });

    });

    group('updateModeSelect Function', () {
      PlayingMode singleMode = PlayingMode.singleNote; 
      PlayingMode triadChord = PlayingMode.triadChord; 
      PlayingMode powerChord = PlayingMode.powerChord; 

      PlayingMode majorSingle = updateModeSelect(Scale.major, singleMode);
      PlayingMode minorSingle = updateModeSelect(Scale.minor, singleMode);
      PlayingMode harMinorSingle = updateModeSelect(Scale.harmonicMinor, singleMode);
      PlayingMode pentaMajorSingle = updateModeSelect(Scale.pentatonicMajor, singleMode);
      PlayingMode pentaMinorSingle = updateModeSelect(Scale.pentatonicMinor, singleMode);

      PlayingMode majorTriad = updateModeSelect(Scale.major, triadChord);
      PlayingMode minorTriad = updateModeSelect(Scale.minor, triadChord);
      PlayingMode harMinorTriad = updateModeSelect(Scale.harmonicMinor, triadChord);
      PlayingMode pentaMajorTriad = updateModeSelect(Scale.pentatonicMajor, triadChord);
      PlayingMode pentaMinorTriad = updateModeSelect(Scale.pentatonicMinor, triadChord);

      PlayingMode majorPower = updateModeSelect(Scale.major, powerChord);
      PlayingMode minorPower = updateModeSelect(Scale.minor, powerChord);
      PlayingMode harMinorPower = updateModeSelect(Scale.harmonicMinor, powerChord);
      PlayingMode pentaMajorPower = updateModeSelect(Scale.pentatonicMajor, powerChord);
      PlayingMode pentaMinorPower = updateModeSelect(Scale.pentatonicMinor, powerChord);

      test('Retain same playingMode', () {
        expect(majorSingle, singleMode);
        expect(minorSingle, singleMode);
        expect(harMinorSingle, singleMode);
        expect(pentaMajorSingle, singleMode);
        expect(pentaMinorSingle, singleMode);

        expect(majorTriad, triadChord);
        expect(minorTriad, triadChord);
        expect(harMinorTriad, triadChord);

        expect(majorPower, powerChord);
        expect(minorPower, powerChord);
        expect(harMinorPower, powerChord);
        expect(pentaMajorPower, powerChord);
        expect(pentaMinorPower, powerChord);
      });

      test('Switch to single playingMode', () {
          expect(pentaMajorTriad, singleMode);
          expect(pentaMinorTriad, singleMode);
      });
    
    });
    
  });

  group('AppSettingsNotifier', () {
    late ProviderContainer container;
    late AppSettingsNotifier notifier;
    late AppSettingsService service;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
      notifier = container.read(appSettingsProvider.notifier);
      service = AppSettingsService();
    });

    test('Initial state is default settings', () async {
      final defaultSettings = AppSettings(
        keyCentre: KeyCentre.cNat,
        scale: Scale.major,
        octave: Octave.four,
        instrument: Instrument.piano,
        playingMode: PlayingMode.singleNote,
      );

      expect(notifier.state.keyCentre, defaultSettings.keyCentre);
      expect(notifier.state.scale, defaultSettings.scale);
      expect(notifier.state.octave, defaultSettings.octave);
      expect(notifier.state.instrument, defaultSettings.instrument);
      expect(notifier.state.playingMode, defaultSettings.playingMode);
    });

    test('saveSettings updates the state', () async {
      final newSettings = AppSettings(
        keyCentre: KeyCentre.gNat,
        scale: Scale.minor,
        octave: Octave.two,
        instrument: Instrument.acousticGuitar,
        playingMode: PlayingMode.triadChord,
      );

      notifier.saveSettings(newSettings);
      
      expect(notifier.state.keyCentre, newSettings.keyCentre);
      expect(notifier.state.scale, newSettings.scale);
      expect(notifier.state.octave, newSettings.octave);
      expect(notifier.state.instrument, newSettings.instrument);
      expect(notifier.state.playingMode, newSettings.playingMode);
    });
  });
}