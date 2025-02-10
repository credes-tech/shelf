import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marquee/marquee.dart';
import 'package:my_shelf_project/core/service/permission_service.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/providers/audio_provider.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeCard.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeMenuItem.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomePillBar.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeTitle.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeToggler.dart';

class AudioScreen extends ConsumerStatefulWidget {
  const AudioScreen({super.key});

  @override
  ConsumerState<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends ConsumerState<AudioScreen> {
  final GlobalKey _popupKey = GlobalKey();
  final List<String> source = ['Recordings', 'Audio Files'];
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Map<String, bool> _isPlaying = {};

  int selectedSource = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(audioProvider.notifier).fetchAudios();
    });
  }

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
    final audioList = ref.watch(audioProvider);
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
          audioList.isEmpty
              ?  HomeCard()
              : Expanded(
                  child: ListView.builder(
                      itemCount: audioList.length,
                      itemBuilder: (context, index) {
                        final audio = audioList[index];
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35.0),
                              color: AppColors.ghostModeRed),
                          margin: EdgeInsets.symmetric(
                              horizontal: AppSpacing.medium,
                              vertical: AppSpacing.xSmall),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => _togglePlayPause(audio.filePath),
                                icon: Icon(
                                  _isPlaying[audio.filePath] == true
                                      ? Icons.pause_circle_filled_rounded
                                      : Icons.play_circle_fill_rounded,
                                  size: 40,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: Marquee(
                                      text: audio.filename,
                                      style: AppTextStyles.audioTitle,
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      blankSpace: 20.0,
                                      velocity: 30.0,
                                      pauseAfterRound: Duration(seconds: 1),
                                      accelerationDuration:
                                          Duration(seconds: 1),
                                      accelerationCurve: Curves.linear,
                                      decelerationDuration:
                                          Duration(milliseconds: 500),
                                      decelerationCurve: Curves.easeOut,
                                    ),
                                  )
                                ],
                              ),


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
      await ref.read(audioProvider.notifier).pickAndSaveAudio();
    } else {
      print("Permission denied");
    }
    _closePopup();
  }
}


