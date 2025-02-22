import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:my_shelf_project/modules/home/data/models/audio_hive_model.dart';
import 'package:my_shelf_project/modules/home/data/models/text_hive_model.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'modules/home/data/models/file_hive_model.dart';
import 'modules/home/data/models/media_hive_model.dart';

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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Hive.registerAdapter(AudioHiveAdapter());
  Hive.registerAdapter(TextHiveAdapter());
  Hive.registerAdapter(MediaHiveAdapter());
  Hive.registerAdapter(FileHiveAdapter());
  await Hive.openBox<AudioHive>('audioBox');
  await Hive.openBox<TextHive>('textBox');
  await Hive.openBox<MediaHive>('mediaBox');
  await Hive.openBox<FileHive>('fileBox');
}
