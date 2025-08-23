import 'package:flutter_application_1/data/datasource/coin_datasource.dart';
import 'package:flutter_application_1/domain/entities/crypto.dart';
import 'package:flutter_application_1/domain/repositories/coin_list_repository.dart';

class CoinRepository extends CoinListRepository {

  CoinDatasource coinDataSource;
  CoinRepository(this.coinDataSource);
  @override
  Future<List<Crypto>> getCoinList() {
    return coinDataSource.getCoinList();
  }
}