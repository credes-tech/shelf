import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shelf_project/core/service/file_picker.dart';
import 'package:my_shelf_project/modules/home/data/datasource/local/audio_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/models/audio_hive_model.dart';
import 'package:my_shelf_project/modules/home/data/repositories/audio_repo_impl.dart';
import 'package:my_shelf_project/modules/home/domain/models/audio_model.dart';

class AudioNotifier extends StateNotifier<List<AudioModel>> {
  final AudioRepository _audioRepo;
  final FilePickerService _filePickerService;
  bool showOnlyPinned = false;

  AudioNotifier(this._audioRepo,this._filePickerService) : super([]) {
    fetchAudios();
  }

  void fetchAudios() {
    state = _audioRepo.fetchAllAudio().map((hiveAudio) {
      return AudioModel.fromHiveModel(hiveAudio);
    }).toList();
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

  void togglePinnedFilter() {
    showOnlyPinned = !showOnlyPinned;
    loadPinnedFiles();
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
      state = [...state,newAudio];
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
  return AudioNotifier(audioRepo,filePickerService);
});
