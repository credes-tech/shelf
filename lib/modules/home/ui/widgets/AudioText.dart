import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marquee/marquee.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/models/audio_model.dart';

class AudioText extends StatelessWidget {
  const AudioText({
    super.key,
    required this.audio,
  });

  final AudioModel audio;

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
      'Dec'
    ];

    String day = date.day.toString().padLeft(2, '0');
    String month = monthNames[date.month - 1];

    return '$day $month';
  }

  @override
  Widget build(BuildContext context) {
    final date = formatDate(audio.date);
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            audio.filename,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          // Text("hii"),
          Row(
            children: [
              SvgPicture.asset('assets/svg/waveform.svg',
                  width: 50,
                  colorFilter:
                      const ColorFilter.mode(Colors.red, BlendMode.srcIn)
                  // color: Colors.black,
                  ),
              SizedBox(
                width: 50,
              ),
              Text(
                date.toString(),
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );

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
