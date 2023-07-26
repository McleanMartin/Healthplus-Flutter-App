import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  var jsonList;
  @override
  void initState() {
    getData();
  }

  void getData() async {
    try {
      var response =
          await Dio().get('http://powerapi.pythonanywhere.com/api/profile');
      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data['alerts'] as List;
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: jsonList == null ? 0 : jsonList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
              title: Text(jsonList[index]['center']),
              subtitle: Text(jsonList[index]['btype']),
            ));
          }),
    );
  }
}
