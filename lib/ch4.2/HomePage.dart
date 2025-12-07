import 'package:flutter/material.dart';
import 'BasePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return const BasePage(body: Center(child: Text('หน้าหลัก')), index: 0);
  }
}

