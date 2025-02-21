import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/providers/text_provider.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeCard.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeMenuItem.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomePillBar.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeTitle.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeToggler.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/NotesCard.dart';

class TextScreen extends ConsumerStatefulWidget {
  const TextScreen({super.key});

  @override
  ConsumerState<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends ConsumerState<TextScreen> {
  final List<String> source = ['Passwords', 'Notes'];
  // bool isPressed = false;
  final Map<int, bool> isPressed = {};
  // final Map<String, bool> _isPlaying = {};
  int selectedSource = 0;

  void selectPressedNote(int index) {
    setState(() {
      if (!isPressed.containsKey(index)) isPressed[index] = false;
      isPressed[index] = true;
    });
  }

  void onTapDeleteBtn(index) {
    setState(() {
      isPressed.remove(index);
    });
    ref.read(textProvider.notifier).deleteText(index);
  }

  void _toggleOption(int index) {
    setState(() {
      if (!isPressed.containsKey(index)) isPressed[index] = false;
      isPressed[index] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textList = ref.watch(textProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: HomeTitle(title: 'Texts'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.medium),
            child: PopupMenuButton<String>(
              icon: SvgPicture.asset('assets/svg/menu.svg', width: 28),
              color: AppColors.onboardDarkYellow,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 1,
              onSelected: (value) {
                print("Selected: $value");
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                _buildPopupMenuItem(
                    "Add Text", Icons.text_fields_rounded, Colors.black),
                _buildPopupMenuItem(
                    "Filter Text", Icons.filter_alt_rounded, Colors.black)
              ],
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HomePillBar(
              source: source,
              selectedSource: selectedSource,
              activeColor: AppColors.onboardDarkYellow,
              inactiveColor: AppColors.onboardLightYellow),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.large, vertical: AppSpacing.medium),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.stars_rounded,
                      size: 35,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    HomeToggler(
                      initialValue: true,
                      onChanged: (value) {},
                      color: AppColors.onboardDarkYellow,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    context.push('/home/texts/new');
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(
                          left: AppSpacing.medium,
                          right: AppSpacing.xSmall,
                          top: AppSpacing.xSmall,
                          bottom: AppSpacing.xSmall),
                      backgroundColor: AppColors.onboardDarkYellow),
                  child: Row(
                    children: [
                      Text("Add New", style: AppTextStyles.homePinned),
                      SizedBox(width: 8),
                      Icon(
                        Icons.add_circle_rounded,
                        size: 35,
                        color: Colors.black,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          textList.isEmpty
              ? HomeCard(
                  text: "No Notes found",
                  icon: Icons.add,
                  description: "Tap Add New button to add new Note",
                )
              : Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.medium),
                      child: Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: AppSpacing.small,
                        spacing: AppSpacing.small,
                        children: textList.asMap().entries.map((value) {
                          int index = value.key;
                          var data = value.value;
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: GestureDetector(
                              onLongPress: () => selectPressedNote(index),
                              child: (isPressed[index] ?? false)
                                  ? Container(
                                      height: 125,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: AppColors.onboardLightYellow),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: AppSpacing.xxSmall,
                                          vertical: AppSpacing.xSmall),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.ios_share,
                                                color: Colors.black,
                                              )),
                                          IconButton(
                                              onPressed: () =>
                                                  onTapDeleteBtn(index),
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.black,
                                              )),
                                          IconButton(
                                              onPressed: () =>
                                                  _toggleOption(index),
                                              icon: Icon(
                                                Icons.close_rounded,
                                                color: Colors.black,
                                              ))
                                        ],
                                      ),
                                    )
                                  : NotesCard(
                                      title: data.heading,
                                      description: data.description,
                                      onTap: () {
                                        context.push('/home/texts/note/$index');
                                      },
                                    ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
      String text, IconData icon, Color iconColor) {
    return PopupMenuItem<String>(
      value: text,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          splashColor: AppColors.onboardLightYellow,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            print("$text clicked");
          },
          child:
              HomeMenuItem(icon: icon, iconColor: iconColor, itemValue: text),
        ),
      ),
    );
  }
}
