import 'package:hive/hive.dart';
import 'package:my_shelf_project/modules/home/data/models/link_hive_model.dart';
import 'package:my_shelf_project/modules/home/data/models/link_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class LinkHiveService {
  static const String _boxName = 'linkBox';

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(LinkHiveAdapter());
    await Hive.openBox<LinkHive>(_boxName);
  }

  Future<void> saveLink(LinkHive link) async {
    final box = Hive.box<LinkHive>(_boxName);
    await box.add(link);
  }

  List<LinkHive> getAllLinks() {
    final box = Hive.box<LinkHive>(_boxName);
    return box.values.toList();
  }

  Future<void> deleteLink(int index) async {
    final box = Hive.box<LinkHive>(_boxName);
    await box.deleteAt(index);
  }

  Future<void> deleteMultipleLinkByPaths(List<String> linkUrls) async {
    final box = Hive.box<LinkHive>(_boxName);
    final keysToDelete = box.keys.where((key) {
      final link = box.get(key);
      return linkUrls.contains(link?.url);
    }).toList();
    if (keysToDelete.isNotEmpty) {
      await box.deleteAll(keysToDelete);
    }
  }

  // Future<bool> isLinkExists(String linkName) async {
  //   final box = Hive.box<LinkHive>(_boxName);
  //   return box.values
  //       .any((link) => link.linkname.toLowerCase() == linkName.toLowerCase());
  // }

  Future<void> togglePin(String url) async {
    final box = Hive.box<LinkHive>(_boxName);
    final index = box.values.toList().indexWhere((link) => link.url == url);

    if (index != -1) {
      final link = box.getAt(index);
      if (link != null) {
        final updatedLink = LinkHive(
          id: link.id,
          url: link.url,
          thumbnail: link.thumbnail,
          date: link.date,
          title: link.title,
          description: link.description,
          isPinned: !link.isPinned,
        );
        await box.putAt(index, updatedLink);
      }
    }
  }
}
