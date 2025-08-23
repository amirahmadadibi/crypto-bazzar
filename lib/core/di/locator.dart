import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/network/dio_client.dart';
import 'package:flutter_application_1/data/datasource/coin_datasource.dart';
import 'package:flutter_application_1/data/datasource/coin_remote_datasource.dart';
import 'package:flutter_application_1/data/repositories/coin_repository.dart';
import 'package:flutter_application_1/domain/repositories/coin_list_repository.dart';
import 'package:flutter_application_1/domain/usecase/get_all_coins_usecase.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> setupLocator() async {
  //dio clients
  locator.registerSingleton<Dio>(DioClient.instance);

  //datasource

  locator.registerFactory<CoinDatasource>(
      () => CoinRemoteDatasource(locator.get()));
  //repository
  locator
      .registerFactory<CoinListRepository>(() => CoinRepository(locator.get()));

  //useCases
  locator
      .registerSingleton<AllCoinListUseCase>(AllCoinListUseCase(locator.get()));
}
