import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/constants.dart';
import 'package:flutter_application_1/core/di/locator.dart';
import 'package:flutter_application_1/domain/entities/crypto.dart';
import 'package:flutter_application_1/presentaion/coin_list/bloc/coin_list_bloc_bloc.dart';
import 'package:flutter_application_1/presentaion/coin_list/widgets/coin_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({Key? key}) : super(key: key);
  @override
  _CoinListScreenState createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  bool isSearchLoadingVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = CoinListBloc(locator.get(), locator.get());
        bloc.add(LoadInitialCoinsDataEvent());
        return bloc;
      },
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
                            context
                                .read<CoinListBloc>()
                                .add(SearchCoinDataEvent(value));
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
        return Center(
          child: SpinKitWave(
            color: Colors.white,
            size: 30.0,
          ),
        );
      case CoinListSuccessState():
        return _buildSuccessListWidget(cryptoList: state.cryptoList);
      case CoinListFailedState():
        return Center(child: Text(state.errorMessage));
    }
  }
}

class _buildSuccessListWidget extends StatelessWidget {
  const _buildSuccessListWidget({
    required this.cryptoList,
  });

  final List<CryptoEntity>? cryptoList;

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
