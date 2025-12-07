import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import 'RegisterPage.dart';
import 'MemberPage.dart';

Logger log = Logger();

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login Demo',
//       home: LoginWidget(),
//       routes: {
//         '/': (context) => LoginPage(),
//         '/register': (context)  =>  RegisterPage(),
//         '/member': (context) => MemberPage(),
//       },
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  Map<String, dynamic>? result;

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // Replace with your server URL
    const String serverURL = 'https://mobile.wattanapong.com/api/auth/login';

    try {
      final response = await http.post(
        Uri.parse(serverURL),
        headers: <String, String> {
      // "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      // "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
      // "Access-Control-Allow-Methods": "POST, OPTIONS",
          'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'email': email,
          'pass': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful! '
               'Welcome ${responseData['member']['name']}')),
        );

        setState(() {
          result = responseData;
        });

        //error can't use navigator across async
        // Navigator.pushNamed(context, '/member');
      } else {
        print('failed');
        final errorData = jsonDecode(response.body);
        setState(() {
          _errorMessage = errorData['message'];
        });
      }
    } catch (error) {
      print('error $error');
      setState(() {
        _errorMessage = 'An error occurred. Please try again. $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _emailController.text = "mobileinfo@cpe.ict.up.ac.th";
    _passwordController.text = "mobile226314";
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
            ElevatedButton(
              onPressed: () async {
                 await _login();
                if (context.mounted && result != null && result!['member'] != null ) {
                  Navigator.pushReplacementNamed(context, '/member');
                }
              },
              child: const Text('Login'),
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

