import 'package:my_shelf_project/modules/home/data/datasource/local/audio_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/models/audio_hive_model.dart';
import 'package:my_shelf_project/modules/home/domain/models/audio_model.dart';

class AudioRepository {
  final AudioHiveService _hiveService;

  AudioRepository(this._hiveService);

  Future<void> saveAudio(AudioHive audio) => _hiveService.saveAudio(audio);

  List<AudioHive> fetchAllAudio() => _hiveService.getAllAudios();

  Future<void> deleteAudio(int index) => _hiveService.deleteAudio(index);

  Future<bool> isAudioExists(String fileName) =>
      _hiveService.isAudioExists(fileName);

  Future<void> togglePin(String fileName) => _hiveService.togglePin(fileName);
  Future<void> deleteMultipleAudios(List<String> selectedAudioList) =>
      _hiveService.deleteMultipleAudios(selectedAudioList);
}
