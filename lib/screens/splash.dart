import 'dart:async';
import 'package:flutter/material.dart';
import 'package:healthplus/screens/home.dart';
import 'package:healthplus/screens/login.dart';
import '../components/utility/logincheck.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () async {
      bool? logincheck = await loginCheck();

      if (logincheck == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/doctors.png',
          ),
        ),
      ),
    );
  }
}
