
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});


  @override
  State createState() {
    return AboutPageState();
  }
}

class AboutPageState extends State<AboutPage> {
  int _currentIndex = 2;
  List<String> routes = ['/', '/product', '/about'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body:  const Padding(
        padding: EdgeInsets.only(left:50.0, top:50),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('About\n1\n2\n3'),
            SizedBox(height: 20),
          ],
        )

      ),
        bottomNavigationBar:
        BottomNavigationBar(
          currentIndex: _currentIndex,
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
                _currentIndex = index;
                Navigator.pushNamed(context, routes[index], arguments: index);
              }),
        )
    );
  }
}