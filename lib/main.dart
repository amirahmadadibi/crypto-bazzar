import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/locator.dart';
import 'package:flutter_application_1/presentaion/coin_list/screens/coin_list_screen.dart';

void main() async {

  await setupLocator();
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CoinListScreen(),
    );
  }
}
