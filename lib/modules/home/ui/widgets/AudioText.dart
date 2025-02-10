


import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/models/audio_model.dart';

class AudioText extends StatelessWidget {
  const AudioText({
    super.key,
    required this.audio,
  });

  final AudioModel audio;

  @override
  Widget build(BuildContext context) {
    return Marquee(
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
    );
  }
}