import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shelf/core/theme/app_colors.dart';
import 'package:shelf/modules/home/ui/widgets/custom_button.dart';
import 'package:shelf/modules/home/ui/widgets/custom_navigation.dart';
import 'package:shelf/modules/home/ui/widgets/custom_switch.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {},
          // icon: SvgPicture.asset('assets/icon/back_icon.svg'),
          icon: Icon(Icons.arrow_circle_left),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/vector/filter.svg'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 80),
        child: Column(
          children: [
            Row(
              children: [
                CustomButton(
                  text: "Whatsapp",
                  color: AppColors.onboardDarkGreen,
                ),
                const SizedBox(width: 10),
                CustomButton(
                  text: "Telegram",
                  color: AppColors.onboardLightGreen,
                ),
                const SizedBox(width: 10),
                CustomButton(
                  text: "Signal",
                  color: AppColors.onboardLightGreen,
                )
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              children: [
                Text('Pinned'),
                const SizedBox(
                  width: 215,
                ),
                CustomSwitch(
                  initialValue: true,
                  onChanged: (value) {},
                  color: AppColors.onboardLightGreen,
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomMenuBar(),
    );
  }
}
