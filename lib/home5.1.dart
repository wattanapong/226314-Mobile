import 'ch5.1/LoginPage.dart';
import 'ch5.1/RegisterPage.dart';
import 'ch5.1/MemberPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(LinkPage());

class LinkPage extends StatelessWidget {

  const LinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context)  =>  RegisterPage(),
        '/member': (context) => MemberPage(),
      },
    );
  }
}

