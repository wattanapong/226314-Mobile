import 'ch4.1/HomePage.dart';
import 'ch4.1/ProductGridViewPage.dart';
import 'ch4.1/AboutPage.dart';
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

