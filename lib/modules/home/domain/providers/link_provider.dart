import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shelf_project/modules/home/data/datasource/local/link_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/repositories/link_repo_impl.dart';
import 'package:my_shelf_project/modules/home/domain/models/link_model.dart';

class LinkNotifier extends StateNotifier<List<LinkModel>> {
  final LinkRepository _linkRepo;
  bool showOnlyPinned = false;

  LinkNotifier(
    this._linkRepo,
  ) : super([]) {
    fetchLinks();
  }

  void fetchLinks() {
    state = _linkRepo.fetchAllLink().map((hiveLink) {
      return LinkModel.fromHiveModel(hiveLink);
    }).toList();
  }

  Future<void> addNewLink(LinkModel link) async {
    // final newText = LinkModel(url: url, date: DateTime.now());
    await _linkRepo.saveLink(link.toHiveModel());
    state = [...state, link];
  }

  Future<void> loadPinnedLinks() async {
    final allLinks = _linkRepo.fetchAllLink().map((hiveLink) {
      return LinkModel.fromHiveModel(hiveLink);
    }).toList();
    state = (showOnlyPinned
        ? allLinks.where((link) => link.isPinned).toList()
        : allLinks);
  }

  void togglePin(String fileName) {
    _linkRepo.togglePin(fileName);
    fetchLinks();
  }

  Future<String> getIndexedLink(int index) async {
    return state[index].url;
  }

  Future<void> deleteLink(List<LinkModel> docLinks) async {
    final linkPaths = docLinks.map((link) => link.url).toList();
    await _linkRepo.deleteMultipleLinks(linkPaths);
    fetchLinks();
  }

  bool togglePinnedFilter() {
    showOnlyPinned = !showOnlyPinned;
    loadPinnedLinks();
    return showOnlyPinned;
  }

  bool onlyTogglePin() {
    showOnlyPinned = !showOnlyPinned;
    return showOnlyPinned;
  }
}

final linkProvider =
    StateNotifierProvider<LinkNotifier, List<LinkModel>>((ref) {
  final linkRepo = LinkRepository(LinkHiveService());
  return LinkNotifier(linkRepo);
});
