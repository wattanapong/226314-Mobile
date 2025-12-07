import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

Logger log = Logger();

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final dio = Dio();
  String? _errorMessage;
  Map<String, dynamic>? result;

  Future<void> onload(BuildContext context) async {
    //check shared preference
    if (await isMember() && context.mounted) {
      Navigator.pushReplacementNamed(context, '/member');
    }
  }

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // Replace with your server URL
    const String serverURL = 'https://mobile.wattanapong.com/api/auth/login';

    try {

      final response = await dio.post(
        serverURL,
        data: {
          'email': email,
          'pass': password,
        },
      );
      
      if (response.statusCode == 200) {
        final responseData = response.data;

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('name', responseData['member']['name']);
        prefs.setString('email', responseData['member']['email']);

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
        final errorData = response.data;
        setState(() {
          _errorMessage = errorData['message'];
        });
      }
    } on DioException catch (e) {
      if (e.response != null){
        log.e('Login failed: ${e.response?.statusCode} - ${e.response?.data}');
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
    _emailController.text = "mobileinfo@cpe.ict.up.ac.th";
    _passwordController.text = "1234";

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                onPressed: () async {
                  await _login();
                  if (context.mounted && result != null && result!['member'] != null ) {
                    Navigator.pushReplacementNamed(context, '/member');
                  }
                },
                child: const Text('Login'),
              ),

              TextButton(onPressed: ()  {
                Navigator.pushNamed(context, '/register');  
              }                ,
                child: Text("Register")
              ),
            ]),
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
  
  Future<bool> isMember() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('name') && prefs.containsKey('email')) {
      return true;
    } else {
      return false;
    }
  }
}

