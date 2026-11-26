import 'package:flutter/material.dart';
import 'package:mobile_software_development/ch5.4/ToDoList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});
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
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome $name')),
      body: ToDoListApp(),
      floatingActionButton: context.mounted ? FloatingActionButton(
        onPressed: () async {
          await logout();
          if (context.mounted){
            Navigator.pushReplacementNamed(context, '/');
          }
          
        },
        child: const Icon(Icons.logout),
      ) : null,
    );
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
    prefs.remove('email');
  }
}

