import 'package:flutter_test/flutter_test.dart';
import 'package:my_shelf_project/modules/home/data/models/media_hive_model.dart';
import 'package:my_shelf_project/modules/home/domain/models/media_model.dart';

void main() {
  group('MediaModel Tests', () {
    final testDate = DateTime(2023, 5, 20);

    test('should create MediaModel correctly', () {
      final model = MediaModel(
        filename: 'video.mp4',
        fileType: 'video/mp4',
        fileSize: 2048,
        date: testDate,
        filePath: '/videos/video.mp4',
        isPinned: true,
      );

      expect(model.filename, 'video.mp4');
      expect(model.fileType, 'video/mp4');
      expect(model.fileSize, 2048);
      expect(model.date, testDate);
      expect(model.filePath, '/videos/video.mp4');
      expect(model.isPinned, true);
    });

    test('should convert to MediaHive correctly', () {
      final model = MediaModel(
        filename: 'image.png',
        fileType: 'image/png',
        fileSize: 1024,
        date: testDate,
        filePath: '/images/image.png',
        isPinned: false,
      );

      final hiveModel = model.toHiveModel();

      expect(hiveModel, isA<MediaHive>());
      expect(hiveModel.filename, 'image.png');
      expect(hiveModel.fileType, 'image/png');
      expect(hiveModel.fileSize, 1024);
      expect(hiveModel.date, testDate);
      expect(hiveModel.filePath, '/images/image.png');
      expect(hiveModel.isPinned, false);
    });

    test('should create MediaModel from MediaHive correctly', () {
      final hiveModel = MediaHive(
        filename: 'music.mp3',
        fileType: 'audio/mp3',
        fileSize: 4096,
        date: testDate,
        filePath: '/music/music.mp3',
        isPinned: true,
      );

      final model = MediaModel.fromHiveModel(hiveModel);

      expect(model.filename, 'music.mp3');
      expect(model.fileType, 'audio/mp3');
      expect(model.fileSize, 4096);
      expect(model.date, testDate);
      expect(model.filePath, '/music/music.mp3');
      expect(model.isPinned, true);
    });
  });
}
