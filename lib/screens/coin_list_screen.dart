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
        backgroundColor: blackColor,
        appBar: AppBar(
          backgroundColor: blackColor,
          title: Text(
            'کیریپتو بازار',
            style: TextStyle(fontFamily: 'mr'),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: cryptoList!.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(
                    cryptoList![index].name,
                    style: TextStyle(color: greenColor),
                  ),
                  subtitle: Text(
                    cryptoList![index].symbol,
                    style: TextStyle(color: greyColor),
                  ),
                  leading: SizedBox(
                    width: 30.0,
                    child: Center(
                      child: Text(
                        cryptoList![index].rank.toString(),
                        style: TextStyle(color: greyColor),
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              cryptoList![index].priceUsd.toStringAsFixed(2),
                              style: TextStyle(color: greyColor, fontSize: 18),
                            ),
                            Text(
                              cryptoList![index]
                                  .changePercent24hr
                                  .toStringAsFixed(2),
                              style: TextStyle(
                                color: _getColorChnageText(
                                    cryptoList![index].changePercent24hr),
                              ),
                            )
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

  Color _getColorChnageText(double percentChange) {
    return percentChange <= 0 ? redColor : greenColor;
  }
}
