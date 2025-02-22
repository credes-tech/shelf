import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/modules/media/ui/pages/MediaViewerScreen.dart';

class MediaRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
        path: '/home/media/view',
        builder: (context, state) {
          final mediaData = state.extra as Map<String, String>;
          return MediaViewerScreen(
            filePath: mediaData['filePath']!,
            fileType: mediaData['fileType']!,
          );
        }
    ),
  ];
}