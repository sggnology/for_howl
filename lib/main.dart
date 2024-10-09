import 'package:flutter/material.dart';
import 'package:for_howl/service/audio_handler/MyAudioHandler.dart';
import 'package:for_howl/service/setting/SettingService.dart';
import 'package:for_howl/service/shared_preference/SharedPreferenceService.dart';
import 'package:for_howl/view/home/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesService().init();
  await MyAudioHandler().init();
  await SettingService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ForHowl',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
