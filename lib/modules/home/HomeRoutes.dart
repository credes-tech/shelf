import 'package:go_router/go_router.dart';
import 'package:shelf/modules/home/ui/pages/AudioScreen.dart';
import 'package:shelf/modules/home/ui/pages/ChatScreen.dart';
import 'package:shelf/modules/home/ui/home_screen.dart';
import 'package:shelf/modules/home/ui/pages/FileScreen.dart';
import 'package:shelf/modules/home/ui/pages/MediaScreen.dart';
import 'package:shelf/modules/home/ui/pages/TextScreen.dart';

class HomeRoutes {
  static final routes = [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(child: child);
      },
      routes: [
        GoRoute(path: "/home/chats", builder: (context, state) => ChatScreen()),
        GoRoute(path: "/home/media", builder: (context, state) => MediaScreen()),
        GoRoute(path: "/home/audio", builder: (context, state) => AudioScreen()),
        GoRoute(path: "/home/texts", builder: (context, state) => TextScreen()),
        GoRoute(path: "/home/file", builder: (context, state) => FileScreen()),
      ],
    ),
  ];
}
