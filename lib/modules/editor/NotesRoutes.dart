import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/modules/editor/ui/pages/AddNewNote.dart';
import 'package:my_shelf_project/modules/editor/ui/pages/NotesScreen.dart';
import 'package:my_shelf_project/modules/home/ui/pages/TextScreen.dart';

class NotesRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
        path: '/home/texts/note/:index',
        builder: (context, state) {
          final int noteId = int.parse(state.pathParameters['index']!);
          return NotesScreen(index: noteId);
        }),
    GoRoute(path: '/home/texts/new', builder: (context, state) => AddNewNote()),
    GoRoute(
        path: '/home/textScreen',
        builder: (context, state) {
          return TextScreen();
        })
  ];
}
