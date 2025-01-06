import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'ch7/Camera2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        cameras: cameras,
      ),
    ),
  );
}
