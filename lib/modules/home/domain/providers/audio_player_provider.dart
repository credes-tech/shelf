import 'dart:developer';

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
  bool onRepeat = false;

  void initializePlayerListeners() {
    log('initialized player listeners', name: '🔴 RED_LOG');
    _audioPlayer.onDurationChanged.listen((Duration d) {
      duration = d;
      notifyListeners();
    });
    _audioPlayer.onPositionChanged.listen((Duration p) {
      position = p;
      notifyListeners();
    });
    _audioPlayer.onPlayerComplete.listen((_) {
      log('audio is completed $onRepeat');
      if (onRepeat) {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.resume();
        isPlaying = true;
      } else {
        isPlaying = false;
        position = Duration.zero;
      }
      notifyListeners();
    });
    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      log('isPlaying state  $isPlaying');
      notifyListeners();
    });
  }

  void seekForward() {
    final newPosition = position + Duration(seconds: 5);
    if (newPosition < duration) {
      _audioPlayer.seek(newPosition);
      position = newPosition;
    }
    notifyListeners();
  }

  void seekBackward() {
    final newPosition = position - Duration(seconds: 5);
    if (newPosition > Duration.zero) {
      _audioPlayer.seek(newPosition);
      position = newPosition;
    } else {
      _audioPlayer.seek(Duration.zero);

      position = Duration.zero;
    }
    notifyListeners();
  }

  Future<void> play(String filePath) async {
    // _audioPlayer.stop();
    try {
      await _audioPlayer.setSourceUrl(filePath);
      await _audioPlayer.resume();
    } catch (e) {
      log(' the error is occurring in the play state $e');
    }
    notifyListeners();
  }

  void pause() {
    _audioPlayer.pause();
    notifyListeners();
  }

  void seekTo(Duration newPosition) {
    _audioPlayer.seek(newPosition);
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
