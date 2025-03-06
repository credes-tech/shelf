import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioPlayerControllerProvider =
    ChangeNotifierProvider<AudioPlayerController>((ref) {
  return AudioPlayerController();
});

class AudioPlayerController extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isSeeking = false;
  bool isPlaying = false;

  void initializePlayerListeners() {
    _audioPlayer.onDurationChanged.listen((Duration d) {
      duration = d;
    });
    _audioPlayer.onPositionChanged.listen((Duration p) {
      position = p;
    });
    _audioPlayer.onPlayerComplete.listen((_) {
      isPlaying = false;
      position = Duration.zero;
    });
    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
    });
  }

  AudioPlayerController() {
    Future<void> play(String filePath) async {
      await _audioPlayer.setSourceUrl(filePath);
      await _audioPlayer.resume();
    }

    void pause() {
      _audioPlayer.pause();
    }

    void seekTo(Duration newPosition) {
      _audioPlayer.seek(newPosition);
    }

    @override
    void dispose() {
      _audioPlayer.dispose();
      super.dispose();
    }
  }
}
