import 'package:flutter_application_1/domain/entities/crypto.dart';

abstract class CoinDatasource {
  Future<List<Crypto>> getCoinList();
}