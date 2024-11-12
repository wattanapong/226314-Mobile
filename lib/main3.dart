import 'dart:math';

import 'package:flutter/material.dart';
import 'calculate_utils.dart';

var displayText = TextEditingController();
var userText = TextEditingController();
var passText = TextEditingController();

void main() => runApp(MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Login Page')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userText,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passText,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true, // Hides password text
            ),
            const SizedBox(height: 24.0),

            ElevatedButton.icon(
                onPressed: () {
                  var text = "username: ${userText.text}\n";
                  text += "password: ${passText.text}";
                  displayText.text = text;
                },
                icon: const Icon(Icons.login),
                label: const Text("Login")),


              TextField(
                controller: displayText,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),


            // ElevatedButton(onPressed: () {}, child: const Text("Login")),
            // TextButton.icon(
            //   style: TextButton.styleFrom(
            //     foregroundColor: const Color(0xFF000000),
            //     backgroundColor: const Color(0xFF00FFFF),
            //   ),
            //   onPressed: (){},
            //   icon: const Icon(Icons.login),
            //   label: const Text('Login (text)'),
            // ),
            // OutlinedButton.icon(
            //   style: TextButton.styleFrom(
            //     foregroundColor: const Color(0xFF000000),
            //     backgroundColor: const Color(0xFF00FFFF),
            //   ),
            //   onPressed: (){},
            //   icon: const Icon(Icons.login),
            //   label: const Text('Login (outline)'),
            // )
          ],
        ),
      ),
    )));
