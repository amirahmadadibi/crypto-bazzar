import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/constants.dart';
import 'package:flutter_application_1/domain/entities/crypto.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({Key? key, this.cryptoList}) : super(key: key);
  List<Crypto>? cryptoList;
  @override
  _CoinListScreenState createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? cryptoList;
  bool isSearchLoadingVisible = false;
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
          style: TextStyle(fontFamily: 'mr', color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                onChanged: (value) {
                  _filterList(value);
                },
                decoration: InputDecoration(
                    hintText: 'اسم رمزارز معتبر را سرچ کنید... ',
                    hintStyle:
                        TextStyle(fontFamily: 'iranYekan', color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 26, 182, 135)),
              ),
            ),
          ),
          Visibility(
            visible: isSearchLoadingVisible,
            child: Text(
              '...در حال اپدیت اطلاعات رمز ارزها',
              style: TextStyle(color: greenColor, fontFamily: 'mr'),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              backgroundColor: greenColor,
              color: blackColor,
              onRefresh: () async {
                List<Crypto> fereshData = await _getData();
                setState(() {
                  cryptoList = fereshData;
                });
              },
              child: ListView.builder(
                itemCount: cryptoList!.length,
                itemBuilder: (context, index) {
                  return _getListTileItem(cryptoList![index]);
                },
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget _getListTileItem(Crypto crypto) {
    return ListTile(
      title: Text(
        crypto.name,
        style: TextStyle(color: greenColor),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        crypto.symbol,
        style: TextStyle(color: greyColor),
        overflow: TextOverflow.ellipsis,
      ),
      leading: SizedBox(
        width: 30.0,
        child: Center(
          child: Text(
            crypto.rank.toString(),
            style: TextStyle(color: greyColor),
          ),
        ),
      ),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    crypto.priceUsd.toStringAsFixed(2),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    crypto.changePercent24hr.toStringAsFixed(2),
                    style: TextStyle(
                      color: _getColorChangeText(crypto.changePercent24hr),
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            SizedBox(width: 8), // Add some spacing
            SizedBox(
                width: 30, // Reduced width to prevent overflow
                child: Center(
                  child: _getIconChangePercent(crypto.changePercent24hr),
                )),
          ],
        ),
      ),
    );
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

  Color _getColorChangeText(double percentChange) {
    return percentChange <= 0 ? redColor : greenColor;
  }

  Future<List<Crypto>> _getData() async {
    var response = await Dio().get(
        'https://rest.coincap.io/v3/assets?apiKey=658ec474b1f482e18ab745c9b26c4cb4a9a4f31486679c749c0e65b8d9b1ab25');
    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();
    return cryptoList;
  }

  Future<void> _filterList(String enteredKeyword) async {
    List<Crypto> cryptoResultList = [];
    if (enteredKeyword.isEmpty) {
      setState(() {
        isSearchLoadingVisible = true;
      });
      var result = await _getData();
      setState(() {
        cryptoList = result;
        isSearchLoadingVisible = false;
      });
      return;
    }
    cryptoResultList = cryptoList!.where((element) {
      return element.name.toLowerCase().contains(enteredKeyword.toLowerCase());
    }).toList();

    setState(() {
      cryptoList = cryptoResultList;
    });
  }
}
