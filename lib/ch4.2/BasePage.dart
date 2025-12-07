import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final Widget body;
  final int index;

  const BasePage({super.key, required this.body, required this.index});

  @override
  State createState() {
    return BasePageState();
  }
}

class BasePageState extends State<BasePage> {

  final List<String> routes = ['/', '/product', '/about'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: widget.body,
        bottomNavigationBar:
        BottomNavigationBar(
          currentIndex: widget.index,
          selectedItemColor: Colors.amber[800],
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront),
              label: 'Product',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
          ],
          onTap: (index) =>
              setState(() {
                Navigator.pushNamed(context, routes[index]);
              }),
        )
    );
  }
}

