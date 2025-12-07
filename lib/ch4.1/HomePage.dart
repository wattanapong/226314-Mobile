import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<String> routes = ['/', '/product', '/about'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('หน้าหลัก')),
          backgroundColor: Colors.lightBlueAccent,
        ),
        // body: Center(
            // child: Column(
              // children: [
              //   const SizedBox(height: 20),
              //   const Text('Welcome'),
              //   const SizedBox(height: 20),
              //   btnPage(context, 'Product', '/product'),
              //   btnPage(context, 'About', '/about'),
              // ],
            // )
    // ),
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
                Navigator.pushNamed(context, routes[index]);
              }),
        ));
  }
}
