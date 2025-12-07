import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

Logger log = Logger();

class MemberPage extends StatelessWidget {

  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Demo',
      home: MemberWidget(),
    );
  }
}

class MemberWidget extends StatefulWidget {

  const MemberWidget({super.key});

  @override
  State createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(child: Text('ยินดีต้อนรับ ')),
    );
  }
}