import 'ch5.3/login_page.dart';
import 'ch5.3/register_page.dart';
import 'ch5.3/member_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(LinkPage());

class LinkPage extends StatelessWidget {
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

