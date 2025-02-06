import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shelf/core/theme/app_colors.dart';
import 'package:shelf/core/theme/app_spacing.dart';
import 'package:shelf/core/theme/app_text_styles.dart';
import 'package:shelf/modules/home/ui/pages/ChatScreen.dart';
import 'package:shelf/modules/home/ui/widgets/HomeTitle.dart';
import 'package:shelf/modules/home/ui/widgets/HomeToggler.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  final List<String> source = ['Passwords', 'Notes'];
  int selectedSource = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: HomeTitle(title: 'Texts'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/vector/filter.svg'),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ChatPillBar(source: source, selectedSource: selectedSource, activeColor: AppColors.onboardDarkYellow, inactiveColor: AppColors.onboardLightYellow),
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppSpacing.large, vertical: AppSpacing.medium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Pinned',style: AppTextStyles.homePinned),
                HomeToggler(
                  initialValue: true,
                  onChanged: (value) {},
                  color: AppColors.onboardDarkYellow,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
