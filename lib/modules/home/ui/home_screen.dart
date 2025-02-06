import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shelf/core/theme/app_colors.dart';
import 'package:shelf/core/theme/app_spacing.dart';
import 'package:shelf/modules/home/ui/pages/AudioScreen.dart';
import 'package:shelf/modules/home/ui/pages/ChatScreen.dart';
import 'package:shelf/modules/home/ui/pages/FileScreen.dart';
import 'package:shelf/modules/home/ui/pages/MediaScreen.dart';
import 'package:shelf/modules/home/ui/pages/TextScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required Widget child});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> _routes = [
    "/home/chats",
    "/home/audio",
    "/home/media",
    "/home/file",
    "/home/texts",
  ];

  final List<Widget> _pages = [
    ChatScreen(),
    AudioScreen(),
    MediaScreen(),
    FileScreen(),
    TextScreen(),
  ];

  final List<Color> _bottomNavColors = [
    AppColors.onboardDarkGreen,
    AppColors.onboardDarkOrange,
    AppColors.onboardDarkBlue,
    AppColors.onboardDarkPink,
    AppColors.onboardDarkYellow,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Theme(
            data: ThemeData(
              canvasColor: _bottomNavColors[_selectedIndex],
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/svg/chat.svg'), label: "Chats"),
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/svg/audio.svg'), label: "Audio"),
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/svg/image.svg'), label: "Media"),
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/svg/document.svg'), label: "Files"),
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/svg/password.svg'), label: "Texts"),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              elevation: 10,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
