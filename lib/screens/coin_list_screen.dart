import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/constant/constants.dart';
import 'package:flutter_application_1/data/model/crypto.dart';

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
          return ListTile(
              title: Text(cryptoList![index].name),
              subtitle: Text(cryptoList![index].symbol),
              leading: SizedBox(
                width: 30.0,
                child: Center(
                  child: Text(
                    cryptoList![index].rank.toString(),
                  ),
                ),
              ),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cryptoList![index].priceUsd.toStringAsFixed(2),
                        ),
                        Text(cryptoList![index]
                            .changePercent24hr
                            .toStringAsFixed(2))
                      ],
                    ),
                    SizedBox(
                        width: 50,
                        child: Center(
                          child: _getIconChangePercent(
                              cryptoList![index].changePercent24hr),
                        )),
                  ],
                ),
              ));
        },
      ),
    ));
  }

  Widget _getIconChangePercent(double percentChange) {
    return percentChange <= 0
        ? Icon(
            Icons.trending_down,
            size: 24,
            color: redColor,
          )
        : Icon(
            Icons.trending_up,
            size: 24,
            color: greenColor,
          );
  }
}
