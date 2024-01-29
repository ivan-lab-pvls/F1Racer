import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:racing/c_theme.dart';
import 'package:racing/data/controllers/notes_controller.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Notes',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset('images/bell.svg'),
          ),
        ],
      ),
      body: Consumer<NotesController>(
        builder: (context, controller, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.notes.length,
            itemBuilder: (context, index) {
              final note = controller.notes[index];
              return NoteItem(note: note, index: index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          final notesController = context.read<NotesController>();

          final note = await showModalBottomSheet<String>(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              context: context,
              builder: (context) => const AddNoteBottomSheet());

          if (note == null) {
            return;
          }

          notesController.addNote(note);
        },
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.note,
    required this.index,
  });
  final String note;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (dir) => context.read<NotesController>().deleteNote(index),
      key: UniqueKey(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CTheme.darkGreyColor,
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          note,
          style: const TextStyle(
            color: CTheme.whiteColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class AddNoteBottomSheet extends StatefulWidget {
  const AddNoteBottomSheet({super.key});

  @override
  State<AddNoteBottomSheet> createState() => _AddNoteBottomSheetState();
}

class _AddNoteBottomSheetState extends State<AddNoteBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              controller: _controller,
              style: const TextStyle(color: CTheme.whiteColor),
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Write your note',
                hintStyle: const TextStyle(color: CTheme.textGreyColor),
                fillColor: CTheme.darkGreyColor,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                if (_controller.text.isEmpty) return;
                Navigator.of(context).pop(_controller.text);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFFb76a27),
                      Color(0xFFe88c2b),
                    ],
                  ),
                ),
                child: const Text(
                  'Add note',
                  style: TextStyle(
                    color: CTheme.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
