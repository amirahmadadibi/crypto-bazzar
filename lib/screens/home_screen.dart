import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/user.dart';
import 'package:flutter_application_1/screens/user_profile_screen.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String title = 'loading....';
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.grey[800],
          body: SafeArea(
              child: Center(
            child: SpinKitSquareCircle(
              color: Colors.white,
              size: 80.0,
            ),
          ))),
    );
  }

  void getData() async {
    // var uri = Uri.parse('https://jsonplaceholder.typicode.com/users/1');
    // Response response = await get(uri);
    // int id = jsonDecode(response.body)['id'];
    // String name = jsonDecode(response.body)['name'];
    // String username = jsonDecode(response.body)['username'];
    // String phone = jsonDecode(response.body)['phone'];
    // String city = jsonDecode(response.body)['address']['city'];

    // User user = User(id, name, username, city, phone);
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/users');
    var test1 = response.data;

    List<User> userList = response.data
        .map<User>((jsonMapObject) => User.fromMapJson(jsonMapObject))
        .toList();

    var test2 = userList;
    print('test');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(
          user: userList,
        ),
      ),
    );
  }
}
