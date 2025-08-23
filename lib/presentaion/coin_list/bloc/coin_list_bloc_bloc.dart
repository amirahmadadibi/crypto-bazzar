import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities/crypto.dart';
import 'package:flutter_application_1/domain/usecase/get_all_coins_usecase.dart';
import 'package:flutter_application_1/domain/usecase/search_coin_list_usecase.dart';
part 'coin_list_bloc_event.dart';
part 'coin_list_bloc_state.dart';

class CoinListBloc extends Bloc<CoinListBlocEvent, CoinListBlocState> {
  AllCoinListUseCase allCoinListUseCase;
  SearchCoinListUseCase searchCoinListUseCase;
  CoinListBloc(this.allCoinListUseCase, this.searchCoinListUseCase) : super(CoinListLoadingState()) {
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
      emit(CoinListLoadingState());

      var response = await searchCoinListUseCase.call(event.query);

      emit(CoinListSuccessState(response));
    });
  }
}
