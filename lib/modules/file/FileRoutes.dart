import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/modules/file/ui/pages/ViewFile.dart';

class FileRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
        path: '/home/file/view',
        builder: (context, state) {
          final fileData = state.extra as Map<String, String>;
          return ViewFile(
            filePath: fileData['filePath']!, fileName: fileData['fileName']!,
          );
        }
    ),
  ];
}