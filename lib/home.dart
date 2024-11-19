import 'package:example/HomePage.dart';
import 'package:example/ProductGridViewPage.dart';
import 'package:example/AboutPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(LinkPage());


class LinkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Link Page Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/product': (context)  =>  ProductGridViewPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}

