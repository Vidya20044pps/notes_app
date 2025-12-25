// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../database/notes_database.dart';

// class NotesDialog extends StatefulWidget {
//   final int? noteId;
//   final String? title;
//   final String? content;
//   final int colorIndex;
//   final List<Color> noteColors;
//   final VoidCallback onNotesSaved;

//   const NotesDialog({
//     super.key,
//     this.noteId,
//     this.title,
//     this.content,
//     required this.colorIndex,
//     required this.noteColors,
//     required this.onNotesSaved,
//   });

//   @override
//   State<NotesDialog> createState() => _NotesDialogState();
// }

// class _NotesDialogState extends State<NotesDialog> {
//   late TextEditingController titleController;
//   late TextEditingController contentController;

//   @override
//   void initState() {
//     super.initState();
//     titleController = TextEditingController(text: widget.title ?? '');
//     contentController = TextEditingController(text: widget.content ?? '');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final date =
//         DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now());

//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.noteId == null ? 'Add Note' : 'Edit Note'),
//           const SizedBox(height: 4),
//           Text(
//             date,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: titleController,
//             decoration: const InputDecoration(
//               hintText: 'Title',
//               border: InputBorder.none,
//             ),
//           ),
//           TextField(
//             controller: contentController,
//             maxLines: 5,
//             decoration: const InputDecoration(
//               hintText: 'Content',
//               border: InputBorder.none,
//             ),
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             if (widget.noteId == null) {
//               await NotesDatabase.instance
//                   .addNote(titleController.text, contentController.text);
//             } else {
//               await NotesDatabase.instance.updateNote(
//                 widget.noteId!,
//                 titleController.text,
//                 contentController.text,
//               );
//             }
//             widget.onNotesSaved();
//             Navigator.pop(context);
//           },
//           child: const Text('Save'),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/notes_database.dart';

class NotesDialog extends StatefulWidget {
  final int? noteId;
  final String? title;
  final String? content;
  final VoidCallback onSaved;

  const NotesDialog({
    super.key,
    this.noteId,
    this.title,
    this.content,
    required this.onSaved,
  });

  @override
  State<NotesDialog> createState() => _NotesDialogState();
}

class _NotesDialogState extends State<NotesDialog> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title ?? '');
    contentController = TextEditingController(text: widget.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final date =
        DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now());

    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.noteId == null ? 'Add Note' : 'Edit Note'),
          Text(date, style: const TextStyle(fontSize: 12)),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: contentController,
            maxLines: 5,
            decoration: const InputDecoration(hintText: 'Content'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (titleController.text.isEmpty ||
                contentController.text.isEmpty) return;

            if (widget.noteId == null) {
              await NotesDatabase.instance.addNote(
                titleController.text,
                contentController.text,
              );
            } else {
              await NotesDatabase.instance.updateNote(
                widget.noteId!,
                titleController.text,
                contentController.text,
              );
            }

            widget.onSaved();
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
