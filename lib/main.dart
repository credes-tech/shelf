import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shelf/modules/home/data/models/audio_hive_model.dart';
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
  // Hive.registerAdapter(AudioHiveAdapter()); // Register the AudioHive adapter
  // await Hive.openBox<AudioHive>('audioHiveBox'); // Open a box for AudioHive
  await Hive.openBox('settings');
}
