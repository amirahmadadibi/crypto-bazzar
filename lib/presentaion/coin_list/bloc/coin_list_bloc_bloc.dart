import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities/crypto.dart';
part 'coin_list_bloc_event.dart';
part 'coin_list_bloc_state.dart';

class CoinListBloc extends Bloc<CoinListBlocEvent, CoinListBlocState> {
  CoinListBloc() : super(CoinListLoadingState()) {
    on<LoadInitialCoinsDataEvent>((event, emit) async {
      emit(CoinListLoadingState());

      var response = await Dio().get(
          'https://rest.coincap.io/v3/assets?apiKey=658ec474b1f482e18ab745c9b26c4cb4a9a4f31486679c749c0e65b8d9b1ab25');
      List<Crypto> cryptoList = response.data['data']
          .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
          .toList();

      if (response.statusCode == 200) {
        emit(CoinListSuccessState(cryptoList));
      } else {
        emit(CoinListFailedState("Failed to fetch data"));
      }
    });

    on<RefreshCoinDataEvent>((event, emit) async {
      emit(CoinListLoadingState());

      var response = await Dio().get(
          'https://rest.coincap.io/v3/assets?apiKey=658ec474b1f482e18ab745c9b26c4cb4a9a4f31486679c749c0e65b8d9b1ab25');
      List<Crypto> cryptoList = response.data['data']
          .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
          .toList();

      if (response.statusCode == 200) {
        emit(CoinListSuccessState(cryptoList));
      } else {
        emit(CoinListFailedState("Failed to fetch data"));
      }
    });
  }
}
