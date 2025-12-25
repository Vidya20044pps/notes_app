// import 'package:flutter/material.dart';
// import 'screens/notes_screen.dart';

// void main() {
//   runApp(const NotesApp());
// }

// class NotesApp extends StatelessWidget {
//   const NotesApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Notes App',
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//       ),
//       home: const NotesScreen(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'screens/notes_screen.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const NotesScreen(),
    );
  }
}
