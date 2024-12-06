import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/special/enums.dart';

// Model class for app settings
class AppSettings {
  final KeyCenter keyCenter;
  final Octave octave;
  final Instrument instrument;
  final PlayingMode playingMode;

  const AppSettings({
    required this.keyCenter,
    required this.octave,
    required this.instrument,
    required this.playingMode,
  });
}

// Default settings
const defaultSettings = AppSettings(
  keyCenter: KeyCenter.cNat,
  octave: Octave.four,
  instrument: Instrument.piano,
  playingMode: PlayingMode.singleNote,
);

