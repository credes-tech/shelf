import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marquee/marquee.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/models/audio_model.dart';

class AudioText extends ConsumerStatefulWidget {
  final AudioModel audio;
  final Duration? duration;
  const AudioText({super.key, required this.audio, required this.duration});

  @override
  ConsumerState createState() => _AudioTextState();
}

class _AudioTextState extends ConsumerState<AudioText> {
  String formatDate(DateTime date) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    String day = date.day.toString().padLeft(2, '0');
    String month = monthNames[date.month - 1];

    return '$day $month';
  }

  Duration? duration = Duration.zero;
  // Future<void> _getAudioDuration() async {
  //   AudioPlayer player = AudioPlayer();
  //   await player.setSourceUrl(widget.audio.filePath);
  //   Duration? audioDuration = await player.onDurationChanged.first;
  //   await player.dispose();
  //   log('hii audio duration $audioDuration');
  //
  //   setState(() {
  //     duration = audioDuration;
  //     log('audio duration $audioDuration');
  //   });
  // }

  @override
  void initState() {
    super.initState();
    if (widget.duration != null) duration = widget.duration;
    // _getAudioDuration();
  }

  @override
  Widget build(BuildContext context) {
    final audio = widget.audio;
    final date = formatDate(audio.date);

    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
            child: Marquee(
              text: audio.filename,
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
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Text(
                date.toString(),
                style: AppTextStyles.caption,
              ),
              // Text(' - ', style: TextStyle(color: Colors.black, fontSize: 12)),
              // Text(
              //   "${duration!.inMinutes} min",
              //   style: TextStyle(color: Colors.black, fontSize: 12),
              // )
            ],
          ),
        ],
      ),
    );
  }
}

//
// class AudioText extends StatelessWidget {
//   final Future<Duration?> duration;
//   const AudioText({super.key, required this.audio, required this.duration});
//
//   final AudioModel audio;
//
//
//   @override
//
// }
