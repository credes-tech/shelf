import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shelf_project/modules/home/data/datasource/local/text_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/repositories/text_repo_impl.dart';
import 'package:my_shelf_project/modules/home/domain/models/text_model.dart';

class TextNotifier extends StateNotifier<List<TextModel>> {
  final TextRepository _textRepository;
  TextNotifier(this._textRepository) : super([]) {
    fetchTexts();
  }
  void fetchTexts() {
    state = _textRepository.fetchAllTexts().map((hiveText) {
      return TextModel.fromHiveModel(hiveText);
    }).toList();
  }

  Future<TextModel> findNoteByIndex(int index) async {
    return state[index];
  }

  Future<void> addNewText(String heading, String description) async {
    final newText = TextModel(heading: heading, description: description);
    await _textRepository.saveText(newText.toHiveModel());
    state = [...state, newText];
  }

  Future<void> deleteText(int index) async {
    await _textRepository.deleteText(index);
    state = List.from(state)..removeAt(index);
  }

  Future<void> updateText(
    int index,
    String updatedHeading,
    String updatedDescription,
  ) async {
    final updatedText =
        TextModel(heading: updatedHeading, description: updatedDescription);
    await _textRepository.updateText(
        index, updatedText.heading, updatedText.description);
    state = [
      ...state.sublist(0, index),
      updatedText,
      ...state.sublist(index + 1),
    ];
  }
}

final textProvider =
    StateNotifierProvider<TextNotifier, List<TextModel>>((ref) {
  final textRepo = TextRepository(TextHiveService());
  return TextNotifier(textRepo);
});
