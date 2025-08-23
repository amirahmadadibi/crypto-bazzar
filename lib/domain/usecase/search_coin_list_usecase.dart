import 'package:flutter_application_1/domain/entities/crypto.dart';
import 'package:flutter_application_1/domain/repositories/coin_list_repository.dart';

class SearchCoinListUseCase {
  final CoinListRepository coinListRepository;

  SearchCoinListUseCase(this.coinListRepository);

  Future<List<CryptoEntity>> call(String query) {
    return coinListRepository.searchCoinList(query);
  }
}
