import 'package:flutter_test/flutter_test.dart';
import 'package:my_shelf_project/modules/home/data/models/link_hive_model.dart';
import 'package:my_shelf_project/modules/home/domain/models/link_model.dart';

void main() {
  group('LinkModel Tests', () {
    final testDate = DateTime(2023, 5, 20);

    test('should create LinkModel with provided ID', () {
      final model = LinkModel(
        id: '1234abcd',
        url: 'https://example.com',
        date: testDate,
        title: 'Example',
        description: 'Test description',
        thumbnail: 'thumb.png',
        isPinned: true,
      );

      expect(model.id, '1234abcd');
      expect(model.url, 'https://example.com');
      expect(model.date, testDate);
      expect(model.title, 'Example');
      expect(model.description, 'Test description');
      expect(model.thumbnail, 'thumb.png');
      expect(model.isPinned, true);
    });

    test('should generate a UUID if no ID is provided', () {
      final model = LinkModel(
        url: 'https://example.com',
        date: testDate,
      );

      expect(model.id, isNotEmpty);
      expect(model.id, matches(RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$')));
    });

    test('should convert to LinkHive correctly', () {
      final model = LinkModel(
        id: 'custom-id',
        url: 'https://example.com',
        date: testDate,
        title: 'Example',
        description: 'Test description',
        thumbnail: 'thumb.png',
        isPinned: true,
      );

      final hiveModel = model.toHiveModel();

      expect(hiveModel, isA<LinkHive>());
      expect(hiveModel.id, 'custom-id');
      expect(hiveModel.url, 'https://example.com');
      expect(hiveModel.date, testDate);
      expect(hiveModel.title, 'Example');
      expect(hiveModel.description, 'Test description');
      expect(hiveModel.thumbnail, 'thumb.png');
      expect(hiveModel.isPinned, true);
    });

    test('should create LinkModel from LinkHive correctly', () {
      final hiveModel = LinkHive(
        id: 'hive-id',
        url: 'https://example.com',
        date: testDate,
        title: 'From Hive',
        description: 'Hive description',
        thumbnail: 'hive_thumb.png',
        isPinned: false,
      );

      final model = LinkModel.fromHiveModel(hiveModel);

      expect(model.id, 'hive-id');
      expect(model.url, 'https://example.com');
      expect(model.date, testDate);
      expect(model.title, 'From Hive');
      expect(model.description, 'Hive description');
      expect(model.thumbnail, 'hive_thumb.png');
      expect(model.isPinned, false);
    });
  });
}
