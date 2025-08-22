import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/constants.dart';
import 'package:flutter_application_1/domain/entities/crypto.dart';
import 'package:flutter_application_1/presentaion/coin_list/bloc/coin_list_bloc_bloc.dart';
import 'package:flutter_application_1/presentaion/coin_list/widgets/coin_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => CoinListBloc(),
      child: BlocConsumer<CoinListBloc, CoinListBlocState>(
        listener: (context, state) {
          if (state is CoinListFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<CoinListBloc, CoinListBlocState>(
            builder: (context, state) {
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
                            // _filterList(value);
                          },
                          decoration: InputDecoration(
                              hintText: 'اسم رمزارز معتبر را سرچ کنید... ',
                              hintStyle: TextStyle(
                                  fontFamily: 'iranYekan', color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 26, 182, 135)),
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
                          context
                              .read<CoinListBloc>()
                              .add(RefreshCoinDataEvent());
                        },
                        child: _buildByState(state),
                      ),
                    )
                  ],
                )),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildByState(CoinListBlocState state) {
    switch (state) {
      case CoinListLoadingState():
        return Center(child: CircularProgressIndicator());
      case CoinListSuccessState():
        return _buildSuccessListWidget(cryptoList: state.cryptoList);
      case CoinListFailedState():
        return Center(child: Text(state.errorMessage));
    }
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

class _buildSuccessListWidget extends StatelessWidget {
  const _buildSuccessListWidget({
    required this.cryptoList,
  });

  final List<Crypto>? cryptoList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptoList!.length,
      itemBuilder: (context, index) {
        return coinListItem(cryptoList![index]);
      },
    );
  }
}
