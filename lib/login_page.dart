import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pvstore/home.dart';
import 'package:pvstore/utils.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final Uri url = Uri.parse(
      'https://pvstore.padhaivadhai.com/api/login?email=$email&password=$password',
    );

    try {
      final response = await http.post(url);
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);

        if (data['message'] == 'Login successful') {
          // Save the access token and user details in SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('accessToken', data['access_token']);
          await prefs.setString('userName', data['user']['name']);
          await prefs.setString('userEmail', data['user']['email']);
          await prefs.setString('userPassword', password);

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Login successful!')));

          // Navigate to the home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => MyHomePage(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Login failed.')),
          );
        }
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Server error.')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.jpg', // Path to the logo
              height: 70, // Adjust the height as needed
            ),
            SizedBox(height: 20),
            Text(
              'Log in to Your Account',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Text(
              "Log in to your account to continue shopping, track your orders, and manage your preferences.",
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : pvStyleButton(
                  'Login',
                  color: Colors.blue,
                  onPressed: _login,
                  icon: Icons.login,
                ),
          ],
        ),
      ),
    );
  }
}
