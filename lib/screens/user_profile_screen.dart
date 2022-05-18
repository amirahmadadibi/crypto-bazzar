import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/crypto.dart';

import '../data/model/user.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({Key? key, this.cryptoList}) : super(key: key);
  List<Crypto>? cryptoList;
  @override
  _CoinListScreenState createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? cryptoList;

  @override
  void initState() {
    super.initState();
    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView.builder(
        itemCount: cryptoList!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              color: Colors.red,
              child: Center(
                child: Text(
                  cryptoList![index].name,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}
