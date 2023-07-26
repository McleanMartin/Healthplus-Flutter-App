import 'package:flutter/material.dart';
import 'package:healthplus/screens/alerts.dart';
import 'package:healthplus/screens/home.dart';
import 'package:healthplus/screens/login.dart';
import 'package:healthplus/screens/splash.dart';
import 'package:get_storage/get_storage.dart';
import 'components/utility/constants.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Health Plus',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        primarySwatch: Colors.red,
      ),
      initialRoute:'/',
      routes: {
        '/':(context) => SplashPage (),
        '/home':(context) => HomePage(),
        '/login':(context) => LoginPage(),
        
      },
    );
  }
}

