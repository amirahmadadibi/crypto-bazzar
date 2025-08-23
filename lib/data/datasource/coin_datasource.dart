import 'package:flutter_application_1/domain/entities/crypto.dart';

abstract class CoinDatasource {
  Future<List<CryptoEntity>> getCoinList();
  Future<List<CryptoEntity>> searchCoinList(String query);
}
