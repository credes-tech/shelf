import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/core/theme/app_text_styles.dart';
import 'package:my_shelf_project/modules/home/domain/models/audio_model.dart';

class MusicPlayerCard extends StatelessWidget {
  final AudioModel? audio;
  final
  const MusicPlayerCard({super.key, required this.audio});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)),
                  height: 8,
                  width: 125,
                ),
                Icon(
                  Icons.star_border,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    _tag("Most Recent"),
                    _tag("Morning Beats"),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            // Progress Bar
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: _position.inSeconds.toDouble()),
                          duration: Duration(milliseconds: 300), // Smooth transition effect
                          builder: (context, value, child) {
                            return Slider(
                              min: 0,
                              max: _duration.inSeconds.toDouble(),
                              value: _isSeeking ? value : _position.inSeconds.toDouble(),
                              onChanged: (newValue) {
                                setState(() {
                                  _isSeeking = true;
                                });
                              },
                              onChangeStart: (newValue) {
                                setState(() {
                                  _isSeeking = true;
                                });
                              },
                              onChangeEnd: (newValue) {
                                setState(() {
                                  _isSeeking = false;
                                  _seekTo(newValue);
                                });
                              },
                              activeColor: AppColors.onboardDarkOrange,
                              inactiveColor: Colors.white,
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
                          "0:00",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        Text(
                          "4:23",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.repeat,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () {})),
                Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.skip_previous,
                          color: Colors.black,
                        ),
                        onPressed: () {})),
                Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.replay_5,
                          color: Colors.black,
                        ),
                        onPressed: () {})),
                IconButton(
                    icon: Icon(
                      Icons.play_circle_filled,
                      size: 58,
                      color: AppColors.onboardDarkOrange,
                    ),
                    onPressed: () {}),
                Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.forward_5,
                          color: Colors.black,
                        ),
                        onPressed: () {})),
                Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.skip_next,
                          color: Colors.black,
                        ),
                        onPressed: () {})),
                Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.playlist_add,
                          color: Colors.black,
                        ),
                        onPressed: () {})),
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
