
import 'BasePage.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});


  @override
  Widget build(BuildContext context) {

    Widget body = const Padding(
        padding: EdgeInsets.only(left:50.0, top:50),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('About\n1\n2\n3\n4'),
            SizedBox(height: 20),
          ],
        )
    );

    return BasePage(body: body, index: 2);
  }
}

