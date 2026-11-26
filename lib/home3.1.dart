import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          title:
              const Center(child: Text('Full lifecycle of a StatefulWidget')),
        ),
        body: const Center(
          child: LoginForm(),
        ))));

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _email;

  @override
  void initState() {
    super.initState(); // เรียกก่อนเสมอ
    _email = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose(); // คืนหน่วยความจำ
    super.dispose(); // เรียกท้ายสุด
  }

  @override
  Widget build(BuildContext context) {
    return TextField(controller: _email);
  }
}
