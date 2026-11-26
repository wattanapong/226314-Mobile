import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

Logger log = Logger();

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final dio = Dio();
  Map<String, dynamic>? result;

  String? _errorMessage;

  Future<void> register() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String name = _nameController.text;
    final messenger = ScaffoldMessenger.of(context);
    // Replace with your server URL
    const String serverURL = 'https://mobile.wattanapong.com/api/auth/register';

    if (name.trim().isEmpty || email.trim().isEmpty || password.trim().isEmpty) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
        backgroundColor: Colors.red,),
      );
      return;
    }

    try {
      final response = await dio.post(
        serverURL,
        data:{
          'email': email,
          'pass': password,
          'name': name
        }
      );

      if (response.statusCode == 201 && context.mounted) {
        final responseData = response.data;
        setState(() {
          result = responseData;
        });
        
        messenger.showSnackBar(
          SnackBar(content: Text('Register successful! Go Back to Login Page')),
        );
      }
    } on DioException catch (e) {
      if (e.response != null){
        log.e('Register failed: ${e.response?.statusCode} - ${e.response?.data}');
        setState(() {
         _errorMessage = e.response?.data["message"];
        });
      }
      else{
        setState(() {
        _errorMessage = 'An error occurred. Please try again. ${e.message}';
      });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    log.d('can pop is ${Navigator.canPop(context)}');

    return Scaffold(
      appBar: AppBar(title: Text('Register')),
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
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              ElevatedButton(
              onPressed: () async {
                await register();
              },
              child: const Text('Register'),
            ),
  
            TextButton(
              onPressed: () {
                Navigator.pop(context, '/');
              },
              child: const Text('Login'),
            ),
            ],),
            
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