
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// StatelessWidget is used for parts of the UI that do not change over time.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Stateless&Stateful Demo',

      home: Scaffold(
        body: const Center(
          child: MessageWidget(),
        ), 
      ), 
    ); 
  }
}

class MessageWidget extends StatefulWidget {
// We use 'super.key' to properly manage the widget in the tree.
  const MessageWidget({super.key});

  @override
  State<MessageWidget> createState() => MessageWidgetstate();
}

class MessageWidgetstate extends State<MessageWidget> {

  void showMessage() {
    ScaffoldMessenger.of(context) . showSnackBar(
    SnackBar(content: Text('Clicked!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    ElevatedButton(
    onPressed: showMessage,
    child: const Text('Go'),
    ), 
    ], 
    ); 
  } 
}
