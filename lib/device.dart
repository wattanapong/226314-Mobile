import 'package:flutter/material.dart';

void main() => runApp(const DeviceSize());

class DeviceSize extends StatelessWidget {
  const DeviceSize({super.key});


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Device Size')),
          ),
          body: Container(
            padding: const EdgeInsets.only(top: 30),
            alignment: Alignment.topCenter,
            child: Text(
              'width: $w, height: $h\n' 'orientation: $orientation',
              // textScaleFactor: 1.5,
              textScaler: const TextScaler.linear(1.5),
            ),
          )),
    );
  }
}


