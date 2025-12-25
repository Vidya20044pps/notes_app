// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../database/notes_database.dart';
// import '../widgets/notes_dialog.dart';

// class NotesScreen extends StatefulWidget {
//   const NotesScreen({super.key});

//   @override
//   State<NotesScreen> createState() => _NotesScreenState();
// }

// class _NotesScreenState extends State<NotesScreen> {
//   List<Map<String, dynamic>> notes = [];

//   final List<Color> noteColors = [
//     Colors.yellow.shade200,
//     Colors.green.shade200,
//     Colors.blue.shade200,
//     Colors.pink.shade200,
//   ];

//   @override
//   void initState() {
//     super.initState();
//     fetchNotes();
//   }

//   Future<void> fetchNotes() async {
//     final data = await NotesDatabase.instance.getNotes();
//     setState(() {
//       notes = data;
//     });
//   }

//   void openDialog({Map<String, dynamic>? note}) {
//     showDialog(
//       context: context,
//       builder: (_) => NotesDialog(
//         noteId: note?['id'],
//         title: note?['title'],
//         content: note?['content'],
//         colorIndex: 0,
//         noteColors: noteColors,
//         onNotesSaved: fetchNotes,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Notes')),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => openDialog(),
//         child: const Icon(Icons.add),
//       ),
//       body: ListView.builder(
//         itemCount: notes.length,
//         itemBuilder: (context, index) {
//           final note = notes[index];
//           final date = DateFormat('dd MMM yyyy, hh:mm a').format(
//             DateTime.fromMillisecondsSinceEpoch(note['createdTime']),
//           );

//           return Card(
//             child: ListTile(
//               title: Text(note['title']),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(note['content']),
//                   const SizedBox(height: 4),
//                   Text(
//                     date,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//               onTap: () => openDialog(note: note),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/notes_database.dart';
import '../widgets/notes_dialog.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    final data = await NotesDatabase.instance.getNotes();
    setState(() => notes = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => NotesDialog(onSaved: loadNotes),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: notes.isEmpty
          ? const Center(child: Text('No notes yet'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Card(
                  child: ListTile(
                    title: Text(note['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(note['content']),
                        Text(
                          DateFormat('dd MMM yyyy, hh:mm a').format(
                            DateTime.fromMillisecondsSinceEpoch(
                              note['createdTime'],
                            ),
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => NotesDialog(
                          noteId: note['id'],
                          title: note['title'],
                          content: note['content'],
                          onSaved: loadNotes,
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await NotesDatabase.instance
                            .deleteNote(note['id']);
                        loadNotes();
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
