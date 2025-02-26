

import 'package:my_shelf_project/modules/home/data/datasource/local/media_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/models/media_hive_model.dart';

class MediaRepository {
  final MediaHiveService _hiveService;

  MediaRepository(this._hiveService);

  Future<void> saveMedia(MediaHive media) => _hiveService.saveMedia(media);

  List<MediaHive> fetchAllMedia() => _hiveService.getAllMedia();

  Future<void> deleteMedia(int index) => _hiveService.deleteMedia(index);

  Future<void> deleteMultipleMedia(List<String> filePaths) => _hiveService.deleteMultipleMediaByPaths(filePaths);

  Future<bool> isMediaExists(String fileName) => _hiveService.isMediaExists(fileName);

  Future<void> togglePin(String fileName) => _hiveService.togglePin(fileName);
}
