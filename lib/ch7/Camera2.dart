import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

Logger log = Logger();

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.cameras,
  });

  final List<CameraDescription> cameras;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen>
    with TickerProviderStateMixin {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late AnimationController _animateController;
  ResolutionPreset _selectedResolution = ResolutionPreset.medium;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.cameras[0],
      _selectedResolution,
    );

    _animateController = AnimationController(

      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..addListener(() {
        setState(() {});
      });

    _animateController.repeat(reverse: true);

    super.initState();

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Take a picture')),
        // You must wait until the controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner until the
        // controller has finished initializing.
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return CameraPreview(_controller);
            } else {
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator(
                value: _animateController.value,));
            }
          },
        ),
        floatingActionButton:
        Padding
          (
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                FloatingActionButton(
                    onPressed: _showResolutionOptions,
                    child: const Icon(Icons.settings)),
                FloatingActionButton(
                  onPressed: showCameras,
                    child: const Icon(Icons.flip_camera_android)),
                FloatingActionButton(
                    onPressed: showCameraOptions,
                    child: const Icon(Icons.videocam)),
                FloatingActionButton(
                    onPressed: takePicture,
                    child: const Icon(Icons.camera_alt)),
                ]

            )
        ));
  }

  Future<void> _initializeCamera() async {
    if (widget.cameras.isNotEmpty) {
      _controller = CameraController(
        widget.cameras[0],
        _selectedResolution,
      );

      _controller.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      }).catchError((e) {
        print('Camera initialization error: $e');
      });
    } else {
      print('No cameras available');
    }
  }

  void _showResolutionOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: ResolutionPreset.values.map((resolution) {
              return ListTile(
                title: Text(resolution.toString().split('.').last),
                onTap: () {
                  Navigator.pop(context);
                  _updateResolution(resolution);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void showCameras() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a picture'),
                onTap: () {
                  Navigator.pop(context);
                  // _takePicture();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a video'),
                onTap: () {
                  Navigator.pop(context);
                  // _takeVideo();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showCameraOptions() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a picture'),
                onTap: () {
                  Navigator.pop(context);
                  // _takePicture();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a video'),
                onTap: () {
                  Navigator.pop(context);
                  // _takeVideo();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateResolution(ResolutionPreset resolution) {
    setState(() {
      _selectedResolution = resolution;
    });

    _controller.dispose();
    _initializeCamera();
  }

  void takePicture() async {
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and get the file `image`
      // where it was saved.
      final image = await _controller.takePicture();

      log.d(image.path);

      if (!context.mounted) return;

      // If the picture was taken, display it on a new screen.
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(
            // Pass the automatically generated path to
            // the DisplayPictureScreen widget.
            imagePath: image.path,
          ),
        ),
      );
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }
}



// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}