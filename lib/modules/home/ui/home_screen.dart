import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/modules/home/ui/pages/AudioScreen.dart';
import 'package:my_shelf_project/modules/home/ui/pages/ChatScreen.dart';
import 'package:my_shelf_project/modules/home/ui/pages/FileScreen.dart';
import 'package:my_shelf_project/modules/home/ui/pages/MediaScreen.dart';
import 'package:my_shelf_project/modules/home/ui/pages/TextScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required Widget child});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;


  final List<Widget> _pages = [
    AudioScreen(),
    MediaScreen(),
    FileScreen(),
    TextScreen(),
  ];

  final List<Color> _bottomNavColors = [
    AppColors.onboardDarkOrange,
    AppColors.onboardDarkBlue,
    AppColors.onboardDarkPink,
    AppColors.onboardDarkYellow,
  ];

  final List<Color> _bottomNavInactiveColors = [
    AppColors.onboardLightOrange,
    AppColors.onboardLightBlue,
    AppColors.onboardLightPink,
    AppColors.onboardLightYellow,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(horizontal: AppSpacing.medium,vertical: AppSpacing.large),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Theme(
            data: ThemeData(
              canvasColor: _bottomNavColors[_selectedIndex],
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/svg/audio.svg',colorFilter: ColorFilter.mode(_setColour(index:0), BlendMode.srcIn),width: 32), label: "Audio"),
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/svg/image.svg',colorFilter: ColorFilter.mode(_setColour(index:1), BlendMode.srcIn),width: 32), label: "Media"),
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/svg/document.svg',colorFilter: ColorFilter.mode(_setColour(index:2), BlendMode.srcIn),width: 32), label: "Files"),
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/svg/password.svg',colorFilter: ColorFilter.mode(_setColour(index:3), BlendMode.srcIn),width: 32), label: "Texts"),
              ],
              unselectedItemColor: _bottomNavInactiveColors[_selectedIndex],
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

  _setColour({required int index}) {
    return (_selectedIndex==index)?Colors.black:Colors.white;
  }
}
