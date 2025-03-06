



import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shelf_project/core/service/file_picker.dart';
import 'package:my_shelf_project/modules/home/data/datasource/local/media_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/repositories/media_repo_impl.dart';
import 'package:my_shelf_project/modules/home/domain/models/media_model.dart';


class MediaNotifier extends StateNotifier<List<MediaModel>> {
  final MediaRepository _mediaRepo;
  final FilePickerService _filePickerService;
  bool showOnlyPinned = false;

  MediaNotifier(this._mediaRepo,this._filePickerService) : super([]) {
    fetchMedia();
  }

  void fetchMedia() {
    state = _mediaRepo.fetchAllMedia().map((hiveMedia) {
      return MediaModel.fromHiveModel(hiveMedia);
    }).toList();
  }

  Future<void> loadPinnedFiles() async {
    final allMedia = _mediaRepo.fetchAllMedia().map((hiveMedia) {
      return MediaModel.fromHiveModel(hiveMedia);
    }).toList();
    state = (showOnlyPinned
        ? allMedia.where((media) => media.isPinned).toList()
        : allMedia);
  }

  void togglePin(String fileName) {
    _mediaRepo.togglePin(fileName);
    fetchMedia();
  }


  Future<void> pickAndSaveMedia() async {
    String? filePath = await _filePickerService.pickMediaFile();
    if (filePath != null) {
      final newMedia = MediaModel(
        filename: filePath.split('/').last,
        fileType: filePath.split('.').last,
        fileSize: File(filePath).lengthSync(),
        date: DateTime.now(),
        filePath: filePath,
      );
      print(newMedia.toHiveModel().filename);
      await _mediaRepo.saveMedia(newMedia.toHiveModel());
      state = [...state,newMedia];
    }
  }

  Future<String> getIndexedFile(int index) async {
    return state[index].filePath;
  }

  Future<void> deleteMedia(int index) async {
    final fileToDelete = state[index].filePath;
    await _mediaRepo.deleteMedia(index);
    final file = File(fileToDelete);
    if (await file.exists()) {
      await file.delete();
    }
    state = List.from(state)..removeAt(index);
  }

  void togglePinnedFilter() {
    showOnlyPinned = !showOnlyPinned;
    loadPinnedFiles();
  }
}


final mediaProvider =
StateNotifierProvider<MediaNotifier, List<MediaModel>>((ref) {
  final mediaRepo = MediaRepository(MediaHiveService());
  final filePickerService = FilePickerService();
  return MediaNotifier(mediaRepo,filePickerService);
});