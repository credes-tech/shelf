import 'package:my_shelf_project/modules/home/data/datasource/local/link_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/models/link_hive_model.dart';

class LinkRepository {
  final LinkHiveService _hiveService;

  LinkRepository(this._hiveService);

  Future<void> saveLink(LinkHive link) => _hiveService.saveLink(link);

  List<LinkHive> fetchAllLink() => _hiveService.getAllLinks();

  Future<void> deleteLink(int index) => _hiveService.deleteLink(index);

  Future<void> deleteMultipleLinks(List<String> filePaths) =>
      _hiveService.deleteMultipleLinkByPaths(filePaths);

  // Future<bool> isLinkExists(String fileName) =>
  //     _hiveService.isLinkExists(fileName);

  Future<void> togglePin(String fileName) => _hiveService.togglePin(fileName);
}
