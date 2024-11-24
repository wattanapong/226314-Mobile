import 'ch5.2/HomePage.dart';
import 'ch5.2/ProductGridViewPage.dart';
import 'ch5.2/AboutPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(LinkPage());


class LinkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/product': (context)  =>  ProductGridViewPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}

