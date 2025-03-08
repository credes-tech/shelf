import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquee/marquee.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/modules/home/domain/models/audio_model.dart';
import 'package:my_shelf_project/modules/home/domain/providers/audio_player_provider.dart';
import 'package:my_shelf_project/modules/home/domain/providers/audio_provider.dart';

class MusicPlayerCard extends ConsumerStatefulWidget {
  final AudioModel? audio;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final Function(dynamic) onPlay;
  final Function(dynamic) onPause;
  const MusicPlayerCard({
    super.key,
    required this.audio,
    required this.onNext,
    required this.onPrev,
    required this.onPause,
    required this.onPlay,
  });
  @override
  ConsumerState<MusicPlayerCard> createState() => _MusicPlayerCardState();
}

class _MusicPlayerCardState extends ConsumerState<MusicPlayerCard> {
  final Map<String, bool> repeat = {};
  AudioModel? audio;
  @override
  void initState() {
    super.initState();
    audio = widget.audio!;
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:$minutes:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
  }

  void onPressRepeat(audio, controller) {
    if (repeat.containsKey(audio.filePath)) {
      setState(() {
        repeat[audio.filePath] = !repeat[audio.filePath]!;
      });
    } else {
      repeat[audio.filePath] = true;
    }
    controller.onRepeat = repeat[audio.filePath]!;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(audioPlayerControllerProvider);

    void onPressNextAudioBtn() {
      AudioModel nextAudio =
          ref.read(audioProvider.notifier).loadNextAudio(audio!);
      controller.play(nextAudio.filePath);
      setState(() {
        audio = nextAudio;
      });
      widget.onNext();
    }

    void onPressPrevAudiobtn() {
      AudioModel prevAudio =
          ref.read(audioProvider.notifier).loadPrevAudio(audio!);
      controller.play(prevAudio.filePath);
      setState(() {
        audio = prevAudio;
      });
      widget.onPrev();
    }

    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon(
                //   Icons.delete,
                //   color: Colors.black,
                // ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)),
                  height: 8,
                  width: 125,
                ),

                // Icon(
                //   Icons.star_border,
                //   color: Colors.black,
                // ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                // Album Art
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.onboardLightOrange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.album, size: 50, color: Colors.black),
                ),
                SizedBox(width: 16),

                // Song Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                      SizedBox(
                        height: 30,
                        child: Marquee(
                          text: audio!.filename,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
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
                      ),
                      _infoRow("Artist", "---"),
                      _infoRow("Duration", "---"),
                      _infoRow("Format", "---"),
                      _infoRow("Album", "---"),
                      _infoRow("Created at", "---"),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 12),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Wrap(
            //       spacing: 8,
            //       children: [
            //         _tag("Most Recent"),
            //         _tag("Morning Beats"),
            //       ],
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 5,
            ),
            // Progress Bar
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                      begin: 0, end: controller.position.inSeconds.toDouble()),
                  duration:
                      Duration(milliseconds: 300), // Smooth transition effect
                  builder: (context, value, child) {
                    return Slider(
                      min: 0,
                      max: controller.duration.inSeconds.toDouble(),
                      value: controller.isSeeking
                          ? value
                          : controller.position.inSeconds.toDouble(),
                      onChanged: (newValue) {
                        controller.isSeeking = true;
                      },
                      onChangeStart: (newValue) {
                        controller.isSeeking = true;
                      },
                      onChangeEnd: (newValue) {
                        controller.seekTo(Duration(seconds: newValue.toInt()));
                        controller.isSeeking = false;
                      },
                      activeColor: AppColors.onboardDarkOrange,
                      inactiveColor: Colors.grey,
                      thumbColor: AppColors.onboardLightOrange,
                    );
                  },
                ),
                Transform.translate(
                  offset: Offset(0, -13),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatDuration(controller.position),
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        Text(
                          formatDuration(controller.duration),
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Expanded(
                //   child: IconButton(
                //     icon: Icon(
                //       Icons.repeat,
                //       size: 20,
                //       color: (repeat[audio!.filePath] == true)
                //           ? AppColors.onboardDarkOrange
                //           : Colors.black,
                //     ),
                //     onPressed: () => onPressRepeat(audio, controller),
                //   ),
                // ),
                Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.skip_previous,
                          color: Colors.black,
                        ),
                        onPressed: onPressPrevAudiobtn)),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.replay_5,
                      color: Colors.black,
                    ),
                    onPressed: controller.seekBackward,
                  ),
                ),
                IconButton(
                    icon: Icon(
                      controller.isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      size: 58,
                      color: AppColors.onboardDarkOrange,
                    ),
                    onPressed: () {
                      if (controller.isPlaying) {
                        widget.onPause(audio);
                      } else {
                        widget.onPlay(audio);
                        // controller.play(audio!.filePath);
                      }
                    }),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.forward_5,
                      color: Colors.black,
                    ),
                    onPressed: controller.seekForward,
                  ),
                ),
                Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.skip_next,
                          color: Colors.black,
                        ),
                        onPressed: onPressNextAudioBtn)),
                // Expanded(
                //     child: IconButton(
                //         icon: Icon(
                //           Icons.playlist_add,
                //           color: Colors.black,
                //         ),
                //         onPressed: () {})),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: RichText(
        text: TextSpan(
          text: "$label : ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
