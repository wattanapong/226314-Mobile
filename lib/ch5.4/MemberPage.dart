import 'package:flutter/material.dart';
import 'package:mobile_software_development/ch6.4/ToDoList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberPage extends StatefulWidget {
  @override
  State createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  String? name = '';
  String? email = '';

  Future<void> readData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      email = prefs.getString('email');
    });

  }

  @override
  void initState() {
    super.initState();
    print('$name $email');
    readData();
    print('$name $email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome $name')),
      body: ToDoListApp(),

    );
  }
}

