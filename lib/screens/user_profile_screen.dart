import 'package:flutter/material.dart';

import '../data/model/user.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({Key? key, this.user}) : super(key: key);
  List<User>? user;
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<User>? user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(user![0].name),
      ),
    );
  }
}
