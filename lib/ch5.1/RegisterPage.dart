import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      home: RegisterWidget(),
    );
  }
}

class RegisterWidget extends StatefulWidget {

  const RegisterWidget({super.key});

  @override
  State createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  String? _errorMessage;

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String name = _nameController.text;

    // Replace with your server URL
    const String serverURL = 'https://mobile.wattanapong.com/api/auth/register';

    try {

      final messenger = ScaffoldMessenger.of(context);
      
      final response = await http.post(
        Uri.parse(serverURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'pass': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        messenger.showSnackBar(
          SnackBar(content: Text('Login successful! Welcome ${responseData['user']['name']}')),
        );
      } else {
        final errorData = jsonDecode(response.body);
        setState(() {
          _errorMessage = errorData['message'];
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Register'),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}