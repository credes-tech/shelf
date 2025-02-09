import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marquee/marquee.dart';
import 'package:shelf/core/service/file_picker.dart';
import 'package:shelf/core/service/permission_service.dart';
import 'package:shelf/core/theme/app_colors.dart';
import 'package:shelf/core/theme/app_spacing.dart';
import 'package:shelf/core/theme/app_text_styles.dart';
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
  final GlobalKey _popupKey = GlobalKey();
  final List<String> source = ['Recordings', 'Audio Files'];
  final List<String> _audioFiles = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Map<String, bool> _isPlaying = {};

  int selectedSource = 0;

  Future<void> _togglePlayPause(String filePath) async {
    if (_isPlaying[filePath] == true) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying[filePath] = false;
      });
    } else {
      _audioPlayer.stop();
      setState(() {
        _isPlaying.updateAll((key, value) => false);
        _isPlaying[filePath] = true;
      });
      await _audioPlayer.play(DeviceFileSource(filePath));
    }
  }

  void _closePopup() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Release resources
    super.dispose();
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
              key: _popupKey,
              icon: SvgPicture.asset('assets/svg/menu.svg', width: 28),
              color: AppColors.onboardDarkOrange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 1,
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
          Expanded(
            child: ListView.builder(
                itemCount: _audioFiles.length,
                itemBuilder: (context, index) {
                  String filePath = _audioFiles[index];
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.0),
                        color: AppColors.ghostModeRed),
                    margin: EdgeInsets.symmetric(
                        horizontal: AppSpacing.medium,
                        vertical: AppSpacing.xSmall),
                    padding: EdgeInsets.only(left: AppSpacing.medium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Marquee(
                                text: filePath.split('/').last,
                                style: AppTextStyles.audioTitle,
                                scrollAxis: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                blankSpace: 20.0,
                                velocity: 30.0,
                                pauseAfterRound: Duration(seconds: 1),
                                accelerationDuration: Duration(seconds: 1),
                                accelerationCurve: Curves.linear,
                                decelerationDuration: Duration(milliseconds: 500),
                                decelerationCurve: Curves.easeOut,
                              ),
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () async {
                          },
                          icon: Icon(
                            Icons.share_rounded,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _togglePlayPause(filePath),
                          icon: Icon(
                            _isPlaying[filePath] == true
                                ? Icons.pause_circle_filled_rounded
                                : Icons.play_circle_fill_rounded,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                  );
                }),
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

  void onTapAudioBtn() async {
    bool isGranted = await PermissionService.requestAudioPermission();
    if (isGranted == true) {
      String? path = await FilePickerService.pickAudioFile();
      if (path != null) {
        setState(() {
          _audioFiles.add(path);
          _isPlaying[path] = false;
        });
      }
    } else {
      print("Permission denied");
    }
    _closePopup();
  }
}
