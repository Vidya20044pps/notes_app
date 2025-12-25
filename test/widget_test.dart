import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/main.dart';

void main() {
  testWidgets('Notes app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const NotesApp());

    expect(find.text('Notes'), findsOneWidget);
  });
}
