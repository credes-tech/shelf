import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.music_note_rounded, size: 60
                  , color: AppColors.onboardDarkOrange),
              SizedBox(height: 10),
              Text(
                "No audio files found!",
                style:AppTextStyles.audioTitle,
              ),
              SizedBox(height: 8),
              RichText(text: TextSpan(
                style: AppTextStyles.caption,
                children: [
                  TextSpan(text: "Tap "),
                  WidgetSpan(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: SvgPicture.asset('assets/svg/menu.svg', width: 15,height: 15,colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
                  )),
                  TextSpan(text: " button to add a new Audio file")
                ]
              ))
            ],
          ),
        ),
      ),
    );
  }
}