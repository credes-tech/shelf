import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:my_shelf_project/modules/home/data/models/audio_hive_model.dart';
import 'package:my_shelf_project/modules/home/data/models/text_hive_model.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(ProviderScope(child: MyApp()));
}

setupDependencies() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AudioHiveAdapter());
  Hive.registerAdapter(TextHiveAdapter());
  await Hive.openBox<AudioHive>('audioBox');
  await Hive.openBox<TextHive>('textBox');
}
