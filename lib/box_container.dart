import 'package:flutter/material.dart';

void main() => runApp(BoxContainer());

class BoxContainer extends StatelessWidget {

  const BoxContainer({super.key}); 

  var itemWidth = 200.0;
  var itemHeight = 200.0;

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    Widget layout = const Text('');
    Axis direction = Axis.vertical;

    if (orientation == Orientation.landscape) {
      layout = layoutLandscape();
      direction = Axis.horizontal;
    } else {
      layout = layoutPortrait();
      direction = Axis.vertical;
    }

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Box Container')),
      ),
      body: Center( child: SingleChildScrollView(
        scrollDirection: direction,
        padding: const EdgeInsets.all(20),
        child: Center(child: layout),
      ),
      ),
    ));
  }

  Widget layoutLandscape() {
    return Row(
      children: [
    box('1', itemWidth, itemHeight, Colors.red),
    box('2', itemWidth, itemHeight, Colors.green),
    box('3', itemWidth, itemHeight, Colors.blue),
      ],
    );
  }

  Widget layoutPortrait() {
    return Column(
      children: [
        box('1', itemWidth, itemHeight, Colors.red),
        box('2', itemWidth, itemHeight, Colors.green),
        box('3', itemWidth, itemHeight, Colors.blue),
      ],
    );
  }

  Widget box(text, w, h, color) {
    return Container(
      width: w,
      height: h,
      color: color,
      alignment: Alignment.center,
      child: Text(text, textScaler: const TextScaler.linear(1.0), style: const TextStyle(color: Colors.white)),
    );
  }
}
