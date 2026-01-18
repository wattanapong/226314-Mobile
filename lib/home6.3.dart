import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Get a list of available cameras
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(camera: firstCamera),
    ),
  );
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({super.key, required this.camera});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  
  CameraImage? _lastFrame;
  bool _isStreaming = false;
  int _frameCount = 0;

  @override
  void initState() {
    super.initState();
    
    // --- ขั้นตอนวิธี (Algorithm) for Instant Stream ---
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium, 
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420, // Most efficient for Android/iOS
    );

    _initializeControllerFuture = _controller.initialize().then((_) {
      _startFastStream();
    });
  }

  // --- ขั้นตอนวิธี (Algorithm): Start Image Stream ---
  void _startFastStream() {
    _controller.startImageStream((CameraImage image) {
      // This function runs every time the camera sensor produces a frame
      // (usually 30-60 times per second)
      setState(() {
        _lastFrame = image;
        _frameCount++;
      });
    });
    setState(() => _isStreaming = true);
  }

  @override
  void dispose() {
    // Ensure stream is stopped before disposing
    if (_isStreaming) {
      _controller.stopImageStream();
    }
    _controller.dispose();
    super.dispose();
  }

  // "Capture" now happens instantly because the data is already in memory
  void _captureInstantSnapshot() {
    if (_lastFrame == null) return;

    final frame = _lastFrame!;
    
    // Show the metadata of the captured frame instantly
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Instant Frame Captured"),
        content: Text(
          "Resolution: ${frame.width} x ${frame.height}\n"
          "Format: ${frame.format.group}\n"
          "Planes: ${frame.planes.length}\n"
          "Timestamp: ${DateTime.now().toString().substring(11, 19)}"
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streaming Camera'),
        actions: [
          Center(child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text("FPS Context: $_frameCount"),
          ))
        ],
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                SizedBox.expand(child: CameraPreview(_controller)),
                Positioned(
                  bottom: 100,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black54,
                    child: Text(
                      "Stream Active: ${_lastFrame?.width ?? 0}x${_lastFrame?.height ?? 0}",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _captureInstantSnapshot,
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.flash_on),
      ),
    );
  }
}