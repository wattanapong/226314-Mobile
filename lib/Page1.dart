import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 1')
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text("Page 1"),
          TextButton(onPressed: ()  {
                Navigator.pushNamed(context, '/page2');  
          },
            child: Text("Page2")
          ),
        ],
        )
      ),
     
    );       
  }
}