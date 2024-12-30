import 'package:flutter/widgets.dart';
import 'package:music_app/component/playScreen/keyboard/note/note_controller.dart';

class NoteView extends StatefulWidget {
  final NoteController controller;

  const NoteView({super.key, required this.controller});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}