import 'package:flutter_application_1/domain/entities/crypto.dart';
import 'package:flutter_application_1/domain/repositories/coin_list_repository.dart';

class AllCoinListUseCase {
  CoinListRepository coinListRepository;
  AllCoinListUseCase(this.coinListRepository);
  Future<List<CryptoEntity>> call() {
    return coinListRepository.getCoinList();
  }
}
