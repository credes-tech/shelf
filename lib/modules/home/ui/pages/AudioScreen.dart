import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shelf/core/service/file_picker.dart';
import 'package:shelf/core/service/permission_service.dart';
import 'package:shelf/core/theme/app_colors.dart';
import 'package:shelf/core/theme/app_spacing.dart';
import 'package:shelf/core/theme/app_text_styles.dart';
import 'package:shelf/modules/home/ui/pages/ChatScreen.dart';
import 'package:shelf/modules/home/ui/widgets/HomeMenuItem.dart';
import 'package:shelf/modules/home/ui/widgets/HomePillBar.dart';
import 'package:shelf/modules/home/ui/widgets/HomeTitle.dart';
import 'package:shelf/modules/home/ui/widgets/HomeToggler.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final List<String> source = ['Recordings', 'Audio Files'];

  int selectedSource = 0;

  Future<void> _checkPermission() async {
    bool isGranted = await PermissionService.checkStoragePermission();
    print(isGranted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: HomeTitle(title: 'Audio'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.medium),
            child: PopupMenuButton<String>(
              icon: SvgPicture.asset('assets/svg/menu.svg', width: 28),
              color: AppColors.onboardDarkOrange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 1,
              onSelected: (value) {
                print("Selected: $value");
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                _buildPopupMenuItem(
                    "Add Audio", Icons.audiotrack_rounded, Colors.black),
                _buildPopupMenuItem(
                    "Filter Audio", Icons.filter_alt_rounded, Colors.black)
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
              activeColor: AppColors.onboardDarkOrange,
              inactiveColor: AppColors.onboardLightOrange),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: AppSpacing.large, vertical: AppSpacing.medium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Pinned', style: AppTextStyles.homePinned),
                HomeToggler(
                  initialValue: true,
                  onChanged: (value) {},
                  color: AppColors.onboardDarkOrange,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                color: AppColors.ghostModeRed),
            margin: EdgeInsets.symmetric(
                horizontal: AppSpacing.medium, vertical: AppSpacing.xSmall),
            padding: EdgeInsets.only(left: AppSpacing.medium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Recording', style: AppTextStyles.audioTitle),
                  ],
                ),
                IconButton(
                  onPressed: () async {
                    await PermissionService.requestStoragePermission();
                    final player = AudioPlayer();
                    await player.play(DeviceFileSource(
                        '/data/user/0/org.credes.shelf/cache/file_picker/1739025131940/Hello.mp3'));
                  },
                  icon: Icon(
                    Icons.pause_circle_filled_rounded,
                    size: 40,
                  ),
                )
              ],
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
          splashColor: AppColors.onboardLightOrange,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          onTap: onTapAudioBtn,
          child:
              HomeMenuItem(icon: icon, iconColor: iconColor, itemValue: text),
        ),
      ),
    );
  }

  onTapAudioBtn() async {
    await PermissionService.requestAudioPermission();
    bool isGranted = await PermissionService.checkAudioPermission();
    if (isGranted == true) {
      // it contains the files which we need to show to frontend.
      List<File>? files = await FilePickerService.pickAudioFile();
    } else {
      print("Permission Denied");
    }
  }
}
