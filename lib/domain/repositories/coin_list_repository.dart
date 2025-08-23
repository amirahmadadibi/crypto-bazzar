import 'package:flutter_application_1/domain/entities/crypto.dart';

abstract class CoinListRepository {
  Future<List<Crypto>> getCoinList();
}