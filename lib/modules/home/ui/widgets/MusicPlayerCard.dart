import 'package:flutter/material.dart';
import 'package:my_shelf_project/core/theme/app_colors.dart';
import 'package:my_shelf_project/modules/home/domain/models/audio_model.dart';

class MusicPlayerCard extends StatelessWidget {
  final AudioModel? audio;
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
                      Text(
                        audio!.filename,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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
            Wrap(
              spacing: 8,
              children: [
                _tag("Most Recent"),
                _tag("Morning Beats"),
              ],
            ),
            SizedBox(height: 8),

            // Progress Bar
            Slider(
              value: 0.2,
              onChanged: (v) {},
              min: 0,
              max: 1,
            ),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(icon: Icon(Icons.repeat), onPressed: () {}),
                IconButton(icon: Icon(Icons.skip_previous), onPressed: () {}),
                IconButton(
                  icon: Icon(Icons.play_circle_filled, size: 48),
                  onPressed: () {},
                ),
                IconButton(icon: Icon(Icons.skip_next), onPressed: () {}),
                IconButton(icon: Icon(Icons.playlist_add), onPressed: () {}),
              ],
            ),
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
