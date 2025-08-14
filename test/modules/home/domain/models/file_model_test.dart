import 'package:flutter_test/flutter_test.dart';
import 'package:my_shelf_project/modules/home/data/models/file_hive_model.dart';
import 'package:my_shelf_project/modules/home/domain/models/file_model.dart';

void main() {
  group('FileModel Tests', () {
    final testDate = DateTime(2023, 5, 20);
    final fileModel = FileModel(
      filename: 'document.pdf',
      fileType: 'pdf',
      fileSize: 2048,
      date: testDate,
      filePath: '/docs/document.pdf',
      isPinned: true,
    );

    test('should create FileModel with correct properties', () {
      expect(fileModel.filename, 'document.pdf');
      expect(fileModel.fileType, 'pdf');
      expect(fileModel.fileSize, 2048);
      expect(fileModel.date, testDate);
      expect(fileModel.filePath, '/docs/document.pdf');
      expect(fileModel.isPinned, true);
    });

    test('should convert to FileHive correctly', () {
      final hiveModel = fileModel.toHiveModel();

      expect(hiveModel, isA<FileHive>());
      expect(hiveModel.filename, fileModel.filename);
      expect(hiveModel.fileType, fileModel.fileType);
      expect(hiveModel.fileSize, fileModel.fileSize);
      expect(hiveModel.date, fileModel.date);
      expect(hiveModel.filePath, fileModel.filePath);
      expect(hiveModel.isPinned, fileModel.isPinned);
    });

    test('should create FileModel from FileHive correctly', () {
      final hiveModel = FileHive(
        filename: 'notes.txt',
        fileType: 'txt',
        fileSize: 512,
        date: testDate,
        filePath: '/notes/notes.txt',
        isPinned: false,
      );

      final fromHive = FileModel.fromHiveModel(hiveModel);

      expect(fromHive.filename, hiveModel.filename);
      expect(fromHive.fileType, hiveModel.fileType);
      expect(fromHive.fileSize, hiveModel.fileSize);
      expect(fromHive.date, hiveModel.date);
      expect(fromHive.filePath, hiveModel.filePath);
      expect(fromHive.isPinned, hiveModel.isPinned);
    });

    test('should have default isPinned as false', () {
      final model = FileModel(
        filename: 'temp.txt',
        fileType: 'txt',
        fileSize: 256,
        date: testDate,
        filePath: '/tmp/temp.txt',
      );

      expect(model.isPinned, false);
    });
  });
}
