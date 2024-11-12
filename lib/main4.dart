import 'package:flutter/material.dart';

var displayText = TextEditingController();
var userText = TextEditingController();
var passText = TextEditingController();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() =>
    runApp(MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Login Page')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: userText,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: passText,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true, // Hides password text
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                ElevatedButton.icon(
                    onPressed: () {
                      var text = "username: ${userText.text}\n";
                      text += "password: ${passText.text}";
                      displayText.text = text;
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("Login")),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: navigatorKey.currentState!.context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Register"),
                          content: const Text("Registration functionality will go here."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text("Close"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text("Register"),
                )
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: displayText,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    ));
