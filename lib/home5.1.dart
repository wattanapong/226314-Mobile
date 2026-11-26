import 'ch5.1/login_page.dart';
import 'ch5.1/register_page.dart';
import 'ch5.1/member_page.dart';
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

