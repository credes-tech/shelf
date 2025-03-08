import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shelf_project/core/service/file_picker.dart';
import 'package:my_shelf_project/modules/home/data/datasource/local/audio_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/repositories/audio_repo_impl.dart';
import 'package:my_shelf_project/modules/home/domain/models/audio_model.dart';

class AudioNotifier extends StateNotifier<List<AudioModel>> {
  final AudioRepository _audioRepo;
  final FilePickerService _filePickerService;
  final Map<String, Duration> audioDurations = {};
  bool showOnlyPinned = false;

  AudioNotifier(this._audioRepo, this._filePickerService) : super([]) {
    fetchAudios();
  }

  void fetchAudios() async {
    final audios = _audioRepo.fetchAllAudio().map((hiveAudio) {
      return AudioModel.fromHiveModel(hiveAudio);
    }).toList();
    state = audios;
    await loadAllDurations(audios);
  }

  AudioModel loadNextAudio(AudioModel audio) {
    final audioList = state;
    final idx = audioList.indexOf(audio);
    log('$idx');
    if (audioList.length > idx + 1) {
      return audioList[idx + 1];
    }
    return audioList[0];
  }

  AudioModel loadPrevAudio(AudioModel audio) {
    final audioList = state;
    final idx = audioList.indexOf(audio);
    log('$idx');
    if (idx - 1 >= 0) {
      return audioList[idx - 1];
    }
    return audioList[audioList.length - 1];
  }

  Future<void> loadAllDurations(List<AudioModel> audioList) async {
    log('this function is repeating');
    for (int index = 0; index < audioList.length; index++) {
      log('the index is $index and ${audioList.length}');
      final audio = audioList[index];
      log('the audio is getting printed ${audio.filename}');
      if (!audioDurations.containsKey(audio.filePath)) {
        audioDurations[audio.filePath] =
            await _fetchAudioDuration(audio.filePath);
      }
    }
  }

  Future<Duration> _fetchAudioDuration(String filepath) async {
    final player = AudioPlayer();
    await player.setSourceUrl(filepath);
    final duration = await player.getDuration() ?? Duration.zero;
    await player.dispose();
    return duration;
  }

  Duration? getDuration(String filePath) {
    return audioDurations[filePath];
  }

  Future<void> loadPinnedFiles() async {
    final allAudios = _audioRepo.fetchAllAudio().map((hiveAudio) {
      return AudioModel.fromHiveModel(hiveAudio);
    }).toList();
    state = (showOnlyPinned
        ? allAudios.where((audio) => audio.isPinned).toList()
        : allAudios);
  }

  void togglePin(String fileName) {
    _audioRepo.togglePin(fileName);
    fetchAudios();
  }

  Future<void> togglePinnedFilter() async {
    showOnlyPinned = !showOnlyPinned;
    await loadPinnedFiles();
  }

  Future<void> pickAndSaveAudio() async {
    String? filePath = await _filePickerService.pickAudioFile();
    if (filePath != null) {
      final newAudio = AudioModel(
        filename: filePath.split('/').last,
        fileType: filePath.split('.').last,
        fileSize: File(filePath).lengthSync(),
        date: DateTime.now(),
        filePath: filePath,
      );
      await _audioRepo.saveAudio(newAudio.toHiveModel());
      state = [...state, newAudio];
    }
  }

  Future<String> getIndexedFile(int index) async {
    return state[index].filePath;
  }

  Future<void> deleteAudio(int index) async {
    final fileToDelete = state[index].filePath;
    await _audioRepo.deleteAudio(index);
    final file = File(fileToDelete);
    if (await file.exists()) {
      await file.delete();
    }
    state = List.from(state)..removeAt(index);
  }
}

final audioProvider =
    StateNotifierProvider<AudioNotifier, List<AudioModel>>((ref) {
  final audioRepo = AudioRepository(AudioHiveService());
  final filePickerService = FilePickerService();
  return AudioNotifier(audioRepo, filePickerService);
});
