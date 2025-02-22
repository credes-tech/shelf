import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/providers/text_provider.dart';
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
  int selectedSource = 0;

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
                horizontal: AppSpacing.medium, vertical: AppSpacing.xSmall),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    HomeToggler(
                      initialValue: true,
                      onChanged: (value) {},
                      color: AppColors.onboardDarkYellow,
                    ),
                    SizedBox(width: 5,),
                    Text("Quick Access",style: AppTextStyles.pinLabelText),
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
                        size: 30,
                        color: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          textList.isEmpty
              ? Text("Text are empty right now")
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
                              child: NotesCard(
                                  title: data.heading,
                                  description: data.description,
                                  onTap: () {
                                    context.push('/home/texts/note/$index');
                                  }));
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
