import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/modules/editor/ui/pages/NotesScreen.dart';

class NotesRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
        path: '/home/texts/note/:index',
        builder: (context, state) {
          final String? noteId = state.pathParameters['index'];
          return NotesScreen(index: noteId);
        }
    ),
  ];
}