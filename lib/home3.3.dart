import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Scaffold Row')),
        ),
        body: Center(
          child: Container(
          width: 220,
          height: 120,
          // ระยะนอกกล่อง / ในกล่อง
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.deepPurple),
            boxShadow: const [
              BoxShadow(blurRadius: 8, color: Colors.black26),
            ],
          ),
          child: const Text('การ์ดสินค้า'),
        )))));
