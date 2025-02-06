import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shelf/core/theme/app_colors.dart';
import 'package:shelf/core/theme/app_spacing.dart';
import 'package:shelf/core/theme/app_text_styles.dart';
import 'package:shelf/modules/home/ui/widgets/HomeTitle.dart';
import 'package:shelf/modules/home/ui/widgets/HomePills.dart';
import 'package:shelf/modules/home/ui/widgets/CustomNavigation.dart';
import 'package:shelf/modules/home/ui/widgets/HomeToggler.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> source = ['Whatsapp', 'Telegram', 'Signal'];
  int selectedSource = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: HomeTitle(title: 'Chats'),
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
          ChatPillBar(source: source, selectedSource: selectedSource, activeColor: AppColors.onboardDarkGreen, inactiveColor: AppColors.onboardLightGreen),
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
                  color: AppColors.onboardDarkGreen,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChatPillBar extends StatelessWidget {
  const ChatPillBar({
    super.key,
    required this.source,
    required this.selectedSource,
    required this.activeColor,
    required this.inactiveColor
  });

  final List<String> source;
  final int selectedSource;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: AppSpacing.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: source.length,
                  itemBuilder: (context, index) {
                    return HomePills(
                      text: source[index],
                      color: (selectedSource==index) ? activeColor: inactiveColor,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
