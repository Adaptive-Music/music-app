enum Scale {
  major(name: 'Major', intervals: [0, 2, 4, 5, 7, 9, 11]),
  minor(name: 'Minor', intervals: [0, 2, 3, 5, 7, 8, 10]),
  harmonicMinor(name: 'Harmonic Minor', intervals: [0, 2, 3, 5, 7, 8, 11]),
  pentatonicMinor(name: 'Pentatonic Minor', intervals: [0, 3, 5, 7, 10]),
  pentatonicMajor(name: 'Pentatonic Major', intervals: [0, 4, 5, 7, 11]);

  const Scale({
    required this.name,
    required this.intervals,
  });

  final String name;
  final List<int> intervals;

  // Static method to find intervals by name
  static List<int> getIntervals(String name) {
    return Scale.values.firstWhere((scale) => scale.name == name).intervals;
  }
}

enum KeyCenter {
  cNat(name: 'C', key: 0),
  cSh(name: 'C# / Db', key: 1),
  dNat(name: 'D', key: 2),
  dSh(name: 'D# / Eb', key: 3),
  eNat(name: 'E', key: 4),
  fNat(name: 'F', key: 5),
  fSh(name: 'F# / Gb', key: 6),
  gNat(name: 'G', key: 7),
  gSh(name: 'G# / Ab', key: 8),
  aNat(name: 'A', key: 9),
  aSh(name: 'A# / Bb', key: 10),
  bNat(name: 'B', key: 11);

  const KeyCenter({
    required this.name,
    required this.key,
  });

  final String name;
  final int key;

  static int getKey(String name) {
    return KeyCenter.values
        .firstWhere((keyCenter) => keyCenter.name == name)
        .key;
  }
}

enum Octave {
  zero(name: '0', number: 12),
  one(name: '1', number: 24),
  two(name: '2', number: 36),
  three(name: '3', number: 48),
  four(name: '4', number: 60),
  five(name: '5', number: 72),
  six(name: '6', number: 84),
  seven(name: '7', number: 96),
  eight(name: '8', number: 108);

  const Octave({
    required this.name,
    required this.number,
  });

  final String name;
  final int number;

  static int getNum(String name) {
    return Octave.values.firstWhere((octave) => octave.name == name).number;
  }
}

enum Instrument {
  piano(bank: 0, program: 2),
  violin(bank: 0, program: 40),
  acousticGuitar(bank: 0, program: 25),
  electricGuitar(bank: 0, program: 29),
  flute(bank: 0, program: 73),
  trumpet(bank: 0, program: 56),
  choir(bank: 0, program: 52),
  dog(bank: 1, program: 123),
  ;

  const Instrument({
    required this.bank,
    required this.program,
  });

  final int bank;
  final int program;

  String get name {
    String last = toString().split('.').last;
    last = last.replaceAllMapped(
        RegExp(r'([a-z])([A-Z])'), (Match m) => '${m[1]} ${m[2]}');
    return last[0].toUpperCase() + last.substring(1);
  }
}
