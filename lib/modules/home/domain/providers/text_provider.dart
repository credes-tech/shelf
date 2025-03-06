import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shelf_project/modules/home/data/datasource/local/text_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/repositories/text_repo_impl.dart';
import 'package:my_shelf_project/modules/home/domain/models/text_model.dart';

class TextNotifier extends StateNotifier<List<TextModel>> {
  final TextRepository _textRepository;
  bool showOnlyPinned = false;
  TextNotifier(this._textRepository) : super([]) {
    fetchTexts();
  }

  void togglePinned() {
    print("toggle pinned workinbg");
    showOnlyPinned = !showOnlyPinned;
    loadPinnedFiles();
  }

  void setTogglePin(int index) async {
    await _textRepository.setTogglePin(index);
    fetchTexts();
  }

  void loadPinnedFiles() {
    final allTexts = _textRepository.fetchAllTexts().map((hiveText) {
      return TextModel.fromHiveModel(hiveText);
    }).toList();
    print("showOnlyPinned $showOnlyPinned");
    state = (showOnlyPinned
        ? allTexts.where((texts) => texts.isPinned).toList()
        : allTexts);
  }

  void fetchTexts() {
    state = _textRepository.fetchAllTexts().map((hiveText) {
      return TextModel.fromHiveModel(hiveText);
    }).toList();
  }

  TextModel findNoteByIndex(int index) {
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
    bool isPinned,
  ) async {
    final updatedText = TextModel(
        heading: updatedHeading,
        description: updatedDescription,
        isPinned: isPinned);

    await _textRepository.updateText(index, updatedText.heading,
        updatedText.description, updatedText.isPinned);
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
