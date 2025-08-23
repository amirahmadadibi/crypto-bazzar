import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities/crypto.dart';
import 'package:flutter_application_1/domain/usecase/get_all_coins_usecase.dart';
part 'coin_list_bloc_event.dart';
part 'coin_list_bloc_state.dart';

class CoinListBloc extends Bloc<CoinListBlocEvent, CoinListBlocState> {
  AllCoinListUseCase allCoinListUseCase;
  CoinListBloc(this.allCoinListUseCase) : super(CoinListLoadingState()) {
    on<LoadInitialCoinsDataEvent>((event, emit) async {
      emit(CoinListLoadingState());

      var response = await allCoinListUseCase.call();

      emit(CoinListSuccessState(response));
    });

    on<RefreshCoinDataEvent>((event, emit) async {
      emit(CoinListLoadingState());

      var response = await allCoinListUseCase.call();

      emit(CoinListSuccessState(response));
    });

    on<SearchCoinDataEvent>((event, emit) async {
      // emit(CoinListLoadingState());
      // List<Crypto> cryptoResultList = [];
      // var response = await Dio().get(
      //     'https://rest.coincap.io/v3/assets?apiKey=658ec474b1f482e18ab745c9b26c4cb4a9a4f31486679c749c0e65b8d9b1ab25');
      // List<Crypto> cryptoList = response.data['data']
      //     .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
      //     .toList();

      // cryptoResultList = cryptoList.where((element) {
      //   return element.name.toLowerCase().contains(event.query.toLowerCase());
      // }).toList();

      // if (response.statusCode == 200) {
      //   emit(CoinListSuccessState(cryptoResultList));
      // } else {
      //   emit(CoinListFailedState("Failed to fetch data"));
      // }
    });
  }
}
