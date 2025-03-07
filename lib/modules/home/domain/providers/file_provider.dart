import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shelf_project/core/service/file_picker.dart';
import 'package:my_shelf_project/modules/home/data/datasource/local/file_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/repositories/file_repo_impl.dart';
import 'package:my_shelf_project/modules/home/domain/models/file_model.dart';


class FileNotifier extends StateNotifier<List<FileModel>> {
  final FileRepository _fileRepo;
  final FilePickerService _filePickerService;
  bool showOnlyPinned = false;

  FileNotifier(this._fileRepo,this._filePickerService) : super([]) {
    fetchFiles();
  }

  void fetchFiles() {
    state = _fileRepo.fetchAllFile().map((hiveFile) {
      return FileModel.fromHiveModel(hiveFile);
    }).toList();
  }

  Future<void> loadPinnedFiles() async {
    final allFiles = _fileRepo.fetchAllFile().map((hiveFile) {
      return FileModel.fromHiveModel(hiveFile);
    }).toList();
    state = (showOnlyPinned
        ? allFiles.where((file) => file.isPinned).toList()
        : allFiles);
  }

  void togglePin(String fileName) {
    _fileRepo.togglePin(fileName);
    fetchFiles();
  }

  Future<void> pickAndSaveFile() async {
    String? filePath = await _filePickerService.pickDocFile();
    if (filePath != null) {
      final newFile = FileModel(
        filename: filePath.split('/').last,
        fileType: filePath.split('.').last,
        fileSize: File(filePath).lengthSync(),
        date: DateTime.now(),
        filePath: filePath,
      );
      await _fileRepo.saveFile(newFile.toHiveModel());
      state = [...state,newFile];
    }
  }

  Future<String> getIndexedFile(int index) async {
    return state[index].filePath;
  }

  Future<void> deleteFile(List<FileModel> docFiles) async {
    final filePaths = docFiles.map((file) => file.filePath).toList();
    await _fileRepo.deleteMultipleFiles(filePaths);
    for (var doc in docFiles) {
      final file = File(doc.filePath);
      if (await file.exists()) {
        await file.delete();
      }
    }
    fetchFiles();
  }

  bool togglePinnedFilter() {
    showOnlyPinned = !showOnlyPinned;
    loadPinnedFiles();
    return showOnlyPinned;
  }
}

final fileProvider =
StateNotifierProvider<FileNotifier, List<FileModel>>((ref) {
  final fileRepo = FileRepository(FileHiveService());
  final filePickerService = FilePickerService();
  return FileNotifier(fileRepo,filePickerService);
});

