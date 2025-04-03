import 'package:my_shelf_project/modules/home/data/models/link_hive_model.dart';
import 'dart:math';

String generateUuid() {
  final Random random = Random.secure();

  String formatBytes(int value, int length) {
    return value.toRadixString(16).padLeft(length, '0');
  }

  int generateRandomBits(int bitCount) {
    if (bitCount <= 32) {
      return random.nextInt(1 << bitCount);
    } else {
      // For values > 32 bits, combine two random 24-bit values
      int high = random.nextInt(1 << 24); // Upper 24 bits
      int low = random.nextInt(1 << 24); // Lower 24 bits
      return (high << 24) | low; // Merge to form 48-bit value
    }
  }

  return '${formatBytes(generateRandomBits(32), 8)}-'
      '${formatBytes(generateRandomBits(16), 4)}-'
      '${formatBytes(0x4000 | generateRandomBits(12), 4)}-' // UUID version 4
      '${formatBytes(0x8000 | generateRandomBits(14), 4)}-' // UUID variant 1
      '${formatBytes(generateRandomBits(48), 12)}';
}

class LinkModel {
  final String id;
  final String url;
  final String? thumbnail;
  final String? title;
  final String? description;
  final DateTime date;
  final bool isPinned;

  LinkModel({
    String? id, // Allow nullable id
    required this.url,
    required this.date,
    this.title,
    this.description,
    this.isPinned = false,
    this.thumbnail,
  }) : id = id ?? generateUuid(); // Assign id dynamically

  LinkHive toHiveModel() {
    return LinkHive(
      id: id,
      url: url,
      thumbnail: thumbnail,
      date: date,
      isPinned: isPinned,
      title: title,
      description: description,
    );
  }

  static LinkModel fromHiveModel(LinkHive linkHive) {
    return LinkModel(
      id: linkHive.id, // Now it can accept an existing ID
      date: linkHive.date,
      isPinned: linkHive.isPinned,
      url: linkHive.url,
      thumbnail: linkHive.thumbnail,
      title: linkHive.title,
      description: linkHive.description,
    );
  }
}
