import 'package:flutter_test/flutter_test.dart';
import 'package:my_shelf_project/modules/home/data/models/text_hive_model.dart';
import 'package:my_shelf_project/modules/home/domain/models/text_model.dart';

void main() {
  group('TextModel Tests', () {
    test('should create TextModel correctly', () {
      final model = TextModel(
        heading: 'My Heading',
        description: 'This is a description.',
        isPinned: true,
      );

      expect(model.heading, 'My Heading');
      expect(model.description, 'This is a description.');
      expect(model.isPinned, true);
    });

    test('should convert to TextHive correctly', () {
      final model = TextModel(
        heading: 'Title',
        description: 'Some description',
        isPinned: false,
      );

      final hiveModel = model.toHiveModel();

      expect(hiveModel, isA<TextHive>());
      expect(hiveModel.heading, 'Title');
      expect(hiveModel.description, 'Some description');
      expect(hiveModel.isPinned, false);
    });

    test('should create TextModel from TextHive correctly', () {
      final hiveModel = TextHive(
        heading: 'Note Heading',
        description: 'Note details go here',
        isPinned: true,
      );

      final model = TextModel.fromHiveModel(hiveModel);

      expect(model.heading, 'Note Heading');
      expect(model.description, 'Note details go here');
      expect(model.isPinned, true);
    });
  });
}
