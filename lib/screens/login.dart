import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:healthplus/screens/home.dart';
import 'package:healthplus/screens/registration.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _submitForm(email, password) async {
    if (_formKey.currentState!.validate()) {
      final Dio _dio = Dio();
      final url = 'http://127.0.0.1:8000/api/login';
      var response = await _dio.post(
        url,
        data: {
          'username': email,
          'password': password,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      Map data = response.data;

      if (response.statusCode == 200 || data['token'] != null) {
        //signupp successfull
        //save session

        final box = GetStorage();
        box.write('token', data['token']);
        
        //navigate to home screen
        Navigator.pushNamed(context, '/home');
      } else {
        //handle signup failure
        Map data = response.data;
        print(data);
        final message = "";
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Sign Up Failed'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text('OK'))
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('HealthPlus Login'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(
                'assets/images/logo.png',
                width: 200,
              )),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 32.0,
              ),
              SizedBox(
                height: 50.0,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _submitForm(_emailController.text.toString(),
                      _passwordController.text.toString()),
                  child: Text('Login'),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 32.0,
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  ),
                  child: Text('register new account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
