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
    return Padding(
        padding: EdgeInsets.only(left: 20),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Audio Name",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              // Text("hii"),
              Expanded(
                  child: Row(
                children: [
                  Text("waveform"),
                ],
              )),
            ],
          ),
        ));

    return Marquee(
      text: audio.filename,
      style: AppTextStyles.audioTitle,
      // scrollAxis: Axis.horizontal,
      // crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20.0,
      velocity: 30.0,
      // pauseAfterRound: Duration(seconds: 1),
      // accelerationDuration: Duration(seconds: 1),
      // accelerationCurve: Curves.linear,
      // decelerationDuration: Duration(milliseconds: 500),
      // decelerationCurve: Curves.easeOut,
    );
  }
}
