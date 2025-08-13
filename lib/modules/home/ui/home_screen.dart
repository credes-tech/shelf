import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/providers/fab_action_provider.dart';
import 'package:my_shelf_project/modules/home/ui/pages/AudioScreen.dart';
import 'package:my_shelf_project/modules/home/ui/pages/ChatScreen.dart';
import 'package:my_shelf_project/modules/home/ui/pages/FileScreen.dart';
import 'package:my_shelf_project/modules/home/ui/pages/LinkScreen.dart';
import 'package:my_shelf_project/modules/home/ui/pages/MediaScreen.dart';
import 'package:my_shelf_project/modules/home/ui/pages/TextScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required Widget child});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  final List<Widget> _pages = [
    AudioScreen(),
    MediaScreen(),
    FileScreen(),
    TextScreen(),
    LinkScreen(),
  ];

  final List<Color> _bottomNavColors = [
    AppColors.onboardLightOrange,
    AppColors.onboardLightBlue,
    AppColors.onboardLightPink,
    AppColors.onboardLightYellow,
    AppColors.onboardLightGreen,
  ];

  final List<Color> _navBarColors = [
    AppColors.navBarOrange,
    AppColors.navBarBlue,
    AppColors.navBarPink,
    AppColors.navBarYellow,
    AppColors.navBarGreen,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: _pages,
          ),
          Positioned(
            bottom: 20,
            // left: AppSpacing.large,
            // right: 95,
            child: Container(
              width: 350,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Theme(
                        data: ThemeData(
                          canvasColor: _bottomNavColors[_selectedIndex],
                        ),
                        child: BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          items: [
                            BottomNavigationBarItem(
                                icon: Padding(
                                  padding: EdgeInsets.only(
                                      left: AppSpacing.xxSmall,
                                      bottom: AppSpacing.xxSmall,
                                      right: AppSpacing.xxSmall,
                                      top: AppSpacing.xSmall),
                                  child: SvgPicture.asset(
                                      'assets/svg/audio.svg',
                                      colorFilter: ColorFilter.mode(
                                          _setColour(index: 0),
                                          BlendMode.srcIn),
                                      width: 30),
                                ),
                                label: "Audio"),
                            BottomNavigationBarItem(
                                icon: Padding(
                                  padding: EdgeInsets.only(
                                      left: AppSpacing.xxSmall,
                                      bottom: AppSpacing.xxSmall,
                                      right: AppSpacing.xxSmall,
                                      top: AppSpacing.xSmall),
                                  child: SvgPicture.asset(
                                      'assets/svg/image.svg',
                                      colorFilter: ColorFilter.mode(
                                          _setColour(index: 1),
                                          BlendMode.srcIn),
                                      width: 30),
                                ),
                                label: "Media"),
                            BottomNavigationBarItem(
                                icon: Padding(
                                  padding: EdgeInsets.only(
                                      left: AppSpacing.xxSmall,
                                      bottom: AppSpacing.xxSmall,
                                      right: AppSpacing.xxSmall,
                                      top: AppSpacing.xSmall),
                                  child: SvgPicture.asset(
                                      'assets/svg/document.svg',
                                      colorFilter: ColorFilter.mode(
                                          _setColour(index: 2),
                                          BlendMode.srcIn),
                                      width: 30),
                                ),
                                label: "Files"),
                            BottomNavigationBarItem(
                                icon: Padding(
                                  padding: EdgeInsets.only(
                                      left: AppSpacing.xxSmall,
                                      bottom: AppSpacing.xxSmall,
                                      right: AppSpacing.xxSmall,
                                      top: AppSpacing.xSmall),
                                  child: SvgPicture.asset(
                                      'assets/svg/password.svg',
                                      colorFilter: ColorFilter.mode(
                                          _setColour(index: 3),
                                          BlendMode.srcIn),
                                      width: 30),
                                ),
                                label: "Texts"),
                            BottomNavigationBarItem(
                                icon: Padding(
                                  padding: EdgeInsets.only(
                                      left: AppSpacing.xxSmall,
                                      bottom: AppSpacing.xxSmall,
                                      right: AppSpacing.xxSmall,
                                      top: AppSpacing.xSmall),
                                  child: SvgPicture.asset('assets/svg/link.svg',
                                      colorFilter: ColorFilter.mode(
                                          _setColour(index: 4),
                                          BlendMode.srcIn),
                                      width: 30),
                                ),
                                label: "Link"),
                          ],
                          currentIndex: _selectedIndex,
                          selectedItemColor: _navBarColors[_selectedIndex],
                          unselectedItemColor: Colors.white,
                          showSelectedLabels: true,
                          showUnselectedLabels: true,
                          selectedLabelStyle: AppTextStyles.navLabel,
                          unselectedLabelStyle: AppTextStyles.navLabel,
                          onTap: _onItemTapped,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      final fabAction = ref.watch(fabActionProvider);

                      return FloatingActionButton(
                        onPressed:
                            fabAction, // Will be null if no action is set
                        backgroundColor: _bottomNavColors[_selectedIndex],
                        elevation: 0,
                        shape: const CircleBorder(),
                        child: Icon(
                          Icons.add_circle_rounded,
                          size: 25,
                          color: _navBarColors[_selectedIndex],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _setColour({required int index}) {
    return (_selectedIndex == index) ? _navBarColors[index] : Colors.white;
  }
}
