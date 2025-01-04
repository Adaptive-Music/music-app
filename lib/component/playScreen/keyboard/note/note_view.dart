import 'package:flutter/widgets.dart';
import 'package:music_app/component/playScreen/keyboard/note/note_viewmodel.dart';

class NoteView extends StatefulWidget {
  final NoteViewModel viewModel;

  const NoteView({super.key, required this.viewModel});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}