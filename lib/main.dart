import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await setupDependencies();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

setupDependencies() {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelf',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      // home: ,
    );
  }
}
