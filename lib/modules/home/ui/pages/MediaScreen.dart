import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shelf/core/theme/app_colors.dart';
import 'package:shelf/core/theme/app_spacing.dart';
import 'package:shelf/core/theme/app_text_styles.dart';
import 'package:shelf/modules/home/ui/pages/ChatScreen.dart';
import 'package:shelf/modules/home/ui/widgets/HomeTitle.dart';
import 'package:shelf/modules/home/ui/widgets/HomeToggler.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  final List<String> source = ['Photo', 'Video', 'GIF'];
  int selectedSource = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: HomeTitle(title: 'Media'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.medium),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/svg/menu.svg',width: 28),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ChatPillBar(source: source, selectedSource: selectedSource, activeColor: AppColors.onboardDarkBlue, inactiveColor: AppColors.onboardLightBlue),
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
                  color: AppColors.onboardDarkBlue,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
