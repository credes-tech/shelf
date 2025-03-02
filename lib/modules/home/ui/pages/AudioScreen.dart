import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_shelf_project/core/service/permission_service.dart';
import 'package:my_shelf_project/core/service/share_service.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_spacing.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/models/audio_model.dart';
import 'package:my_shelf_project/modules/home/domain/providers/audio_provider.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/AudioText.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeCard.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeMenuItem.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomePillBar.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeTitle.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/HomeToggler.dart';
import 'package:my_shelf_project/modules/home/ui/widgets/MusicPlayerCard.dart';

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
  final Map<String, bool> _isOpen = {};
  bool isPinActive = false;
  bool isSubCategoryActive = false;
  AudioModel? currentlyPlaying = null;
  final String emptyHeading = "No audio found!";
  final String emptyDescription = "Tap Add New button to save your files";

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  bool _isSeeking = false;
  int selectedSource = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(audioProvider.notifier).fetchAudios();
    });
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });
    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying.updateAll((key, value) => false);
      });
    });
    _audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      if (s == PlayerState.paused) {
        _isPlaying.updateAll((key, value) => false);
      }
    });
  }

  void _togglePlayPause(AudioModel audio) {
    String filePath = audio.filePath;
    if (_isPlaying[audio.filePath] == true) {
      _audioPlayer.pause();
      setState(() {
        _isPlaying[filePath] = false;
        currentlyPlaying = null;
      });
    } else {
      _audioPlayer.stop();
      setState(() {
        _isPlaying.updateAll((key, value) => false);
        _isPlaying[filePath] = true;
        _position = Duration.zero;
        currentlyPlaying = audio;
      });
      _audioPlayer.play(DeviceFileSource(filePath));
    }
    // setState(() {
    //
    // });
  }

  void _toggleOption(String filePath) {
    if (_isPlaying[filePath] == true) {
      return;
    }
    if (_isOpen[filePath] == true) {
      setState(() {
        _isOpen[filePath] = false;
      });
    } else {
      setState(() {
        _isOpen.updateAll((key, value) => false);
        _isOpen[filePath] = true;
      });
    }
  }

  void _seekTo(double value) {
    final newPosition = Duration(seconds: value.toInt());
    _audioPlayer.seek(newPosition);
  }

  void _seekForward() {
    final newPosition = _position + Duration(seconds: 10);
    if (newPosition < _duration) {
      _audioPlayer.seek(newPosition);
      setState(() {
        _position = newPosition;
      });
    }
  }

  void _seekBackward() {
    final newPosition = _position - Duration(seconds: 10);
    if (newPosition > Duration.zero) {
      _audioPlayer.seek(newPosition);
      setState(() {
        _position = newPosition;
      });
    } else {
      _audioPlayer.seek(Duration.zero);
      setState(() {
        _position = Duration.zero;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Release resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool audioPinnedNotifier =
        ref.read(audioProvider.notifier).showOnlyPinned;
    final audioList = ref.watch(audioProvider);
    print("audioList $audioList");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.xSmall),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_circle_rounded),
            color: Colors.black,
            iconSize: 30,
          ),
        ),
        title: GestureDetector(
          onTap: _toggleSubCategory,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HomeTitle(title: 'Audio'),
              Icon(
                isSubCategoryActive
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
                size: 25,
                color: Colors.black,
              )
            ],
          ),
        ),
        titleSpacing: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_rounded),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () async {
              await ref.read(audioProvider.notifier).togglePinnedFilter();
              pinController(audioPinnedNotifier);
            },
            icon: Icon(
              isPinActive ? Icons.star_rounded : Icons.star_border_rounded,
            ),
            color: Colors.black,
          ),
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
                    "Menu Option 1", Icons.bar_chart_rounded, Colors.black),
                _buildPopupMenuItem(
                    "Menu Option 2", Icons.bar_chart_rounded, Colors.black)
              ],
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isSubCategoryActive)
            HomePillBar(
              source: source,
              selectedSource: selectedSource,
              activeColor: AppColors.onboardDarkOrange,
              inactiveColor: AppColors.onboardLightOrange,
              onSelected: (index) {
                setState(() {
                  selectedSource = index; // Update selected pill
                });
              },
            ),
          audioList.isEmpty
              ? HomeCard(
                  title: emptyHeading,
                  description: emptyDescription,
                  icon: Icons.audiotrack_rounded,
                  iconColor: AppColors.onboardDarkOrange)
              : Expanded(
                  child: ListView.builder(
                      itemCount: audioList.length,
                      itemBuilder: (context, index) {
                        final audio = audioList[index];
                        return GestureDetector(
                          onLongPress: () => _toggleOption(audio.filePath),
                          onDoubleTap: () =>
                              togglePinAudio(audio.filePath, audio.filename),
                          child: (_isOpen[audio.filePath] == true)
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35.0),
                                      color: AppColors.onboardLightOrange),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: AppSpacing.medium,
                                      vertical: AppSpacing.xSmall),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: AppSpacing.medium),
                                          child: Text(
                                            audio.filename,
                                            style: AppTextStyles.audioTitle,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () =>
                                              ShareService.shareFile(
                                                  audio.filePath),
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
                                              _toggleOption(audio.filePath),
                                          icon: Icon(
                                            Icons.close_rounded,
                                            color: Colors.black,
                                          ))
                                    ],
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35.0),
                                      color: AppColors.ghostModeRed),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: AppSpacing.medium,
                                      vertical: AppSpacing.xSmall),
                                  child: SizedBox(
                                    height: 69,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  (audio.isPinned ? 0.6 : 0.7),
                                              child: AudioText(
                                                audio: audio,
                                              ),
                                            )
                                          ],
                                        ),
                                        audio.isPinned
                                            ? SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                              )
                                            : SizedBox(),
                                        audio.isPinned
                                            ? Icon(
                                                Icons.stars_rounded,
                                                size: 30,
                                                color:
                                                    AppColors.onboardDarkOrange,
                                              )
                                            : SizedBox(),
                                        IconButton(
                                          onPressed: () =>
                                              _togglePlayPause(audio),
                                          icon: Icon(
                                            (_isPlaying[audio.filePath] == true)
                                                ? Icons
                                                    .pause_circle_filled_rounded
                                                : Icons
                                                    .play_circle_filled_rounded,
                                            size: 40,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        );
                      }),
                ),
          if (currentlyPlaying != null)
            Positioned(
              bottom: -20,
              left: 0,
              right: 0,
              child: MusicPlayerCard(audio: currentlyPlaying),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onTapAudioBtn(context),
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add_box,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }

  // Widget get _popupAudioModal {
  //   return Container(
  //     child: ,
  //   );
  // }

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
          onTap: () {},
          child:
              HomeMenuItem(icon: icon, iconColor: iconColor, itemValue: text),
        ),
      ),
    );
  }

  void onTapAudioBtn(BuildContext context) async {
    bool isGranted = await PermissionService.requestAudioPermission();
    if (isGranted == true) {
      await ref.read(audioProvider.notifier).pickAndSaveAudio();
    } else {
      print("Permission denied");
    }
  }

  void onTapDeleteBtn(index) async {
    String currentFilePath =
        await ref.read(audioProvider.notifier).getIndexedFile(index);
    if (_isPlaying[currentFilePath] == true) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying[currentFilePath] = false;
        _isOpen[currentFilePath] = false;
      });
      _audioPlayer.stop();
    }
    setState(() {
      _isPlaying.remove(currentFilePath);
      _isOpen.remove(currentFilePath);
    });
    await ref.read(audioProvider.notifier).deleteAudio(index);
  }

  _toggleSubCategory() {
    setState(() {
      isSubCategoryActive = !isSubCategoryActive;
    });
  }

  void togglePinAudio(String filePath, String fileName) {
    if (_isPlaying[filePath] == true) {
      return;
    }
    ref.read(audioProvider.notifier).togglePin(fileName);
  }

  void pinController(bool audioPinnedNotifier) {
    setState(() {
      isPinActive = audioPinnedNotifier;
    });
  }

  // widget showAudioModal() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       SizedBox(
  //         height: 20,
  //       ),
  //       SizedBox(
  //         height: 30,
  //         width: MediaQuery.of(context).size.width * 0.6,
  //         child: AudioText(
  //           audio: audio,
  //         ),
  //       ),
  //       TweenAnimationBuilder<double>(
  //         tween: Tween<double>(begin: 0, end: _position.inSeconds.toDouble()),
  //         duration: Duration(milliseconds: 300), // Smooth transition effect
  //         builder: (context, value, child) {
  //           return Slider(
  //             min: 0,
  //             max: _duration.inSeconds.toDouble(),
  //             value: _isSeeking ? value : _position.inSeconds.toDouble(),
  //             onChanged: (newValue) {
  //               setState(() {
  //                 _isSeeking = true;
  //               });
  //             },
  //             onChangeStart: (newValue) {
  //               setState(() {
  //                 _isSeeking = true;
  //               });
  //             },
  //             onChangeEnd: (newValue) {
  //               setState(() {
  //                 _isSeeking = false;
  //                 _seekTo(newValue);
  //               });
  //             },
  //             activeColor: AppColors.onboardDarkOrange,
  //             inactiveColor: Colors.white,
  //             thumbColor: AppColors.onboardLightOrange,
  //           );
  //         },
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           IconButton(
  //               onPressed: () => ShareService.shareFile(audio.filePath),
  //               icon: Icon(
  //                 Icons.ios_share,
  //                 color: Colors.black,
  //               )),
  //           IconButton(
  //               onPressed: _seekBackward,
  //               icon: Icon(
  //                 Icons.replay_10_rounded,
  //                 color: Colors.black,
  //               )),
  //           IconButton(
  //             onPressed: () => _togglePlayPause(audio.filePath),
  //             icon: Icon(
  //               Icons.pause_circle_filled_rounded,
  //               size: 60,
  //               color: AppColors.onboardDarkOrange,
  //             ),
  //           ),
  //           IconButton(
  //               onPressed: _seekForward,
  //               icon: Icon(
  //                 Icons.forward_10_rounded,
  //                 color: Colors.black,
  //               )),
  //           IconButton(
  //               onPressed: () => onTapDeleteBtn(index),
  //               icon: Icon(
  //                 Icons.delete,
  //                 color: Colors.black,
  //               ))
  //         ],
  //       ),
  //       SizedBox(
  //         height: 10,
  //       ),
  //     ],
  //   );
  // }
}
