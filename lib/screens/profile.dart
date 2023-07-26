import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

void logout(){
  final box = GetStorage();
  box.remove('token');
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          children: <Widget>[
            
            Center(
              child: Image.asset(
              'assets/images/avatar.jpg'
      
              ),
            ),
            SizedBox(
                height: 16.0,
              ),
            Text(
              "Profile",
              style: TextStyle(fontFamily: "Gotham", fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black)
            ),
            
          ],
          
        ),
      ),
    );
  }
}