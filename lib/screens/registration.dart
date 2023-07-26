import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthplus/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _idNumberController = TextEditingController();

  Future<void> _submitForm(
    firstname,
    lastname,
    email,
    nId,
    password,
  ) async {
    final Dio _dio = Dio();
    final url = 'http://127.0.0.1:8000/api/register';
    // if (_formKey.currentState.validate()) {

    // }
    try {
      var response = await _dio.post(url, data: {
        'firstname': firstname,
        'lastname': lastname,
        'national_ID': nId,
        'email': email,
        'password': password,
      });

      Map data = response.data;
      if (response.statusCode == 200 || response.data != null) {
        //signupp successfull

        //save session
        final box = GetStorage();
        box.write('token', data['token']);
        final message = "Signup Successful";
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Nofication'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text('OK'))
            ],
          ),
        );
        //navigate to home screen
        Navigator.pushNamed(context, '/home');
      } else {
        //handle signup failure
        final message = data['error'];
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
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('HealthPlus Sign Up'),
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
                controller: _fnameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _lnameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your last name';
                  }
                  return null;
                },
              ),
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
                controller: _idNumberController,
                decoration: InputDecoration(
                  labelText: 'ID Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your ID number';
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
                  onPressed: () {
                    _submitForm(
                      _fnameController.text.toString(),
                      _lnameController.text.toString(),
                      _emailController.text.toString(),
                      _idNumberController.text.toString(),
                      _passwordController.text.toString(),
                    );
                  },
                  child: Text('Sign Up'),
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
                      builder: (context) => LoginPage(),
                    ),
                  ),
                  child: Text(
                    'already have an account',
                    style: TextStyle(
                      fontFamily: 'veralaRound',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
