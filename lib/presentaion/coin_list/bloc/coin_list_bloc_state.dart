part of 'coin_list_bloc_bloc.dart';

@immutable
sealed class CoinListBlocState {}

final class CoinListLoadingState extends CoinListBlocState {}

final class CoinListSuccessState extends CoinListBlocState {
  final List<Crypto> cryptoList;

  CoinListSuccessState(this.cryptoList);
}

final class CoinListFailedState extends CoinListBlocState {
  final String errorMessage;

  CoinListFailedState(this.errorMessage);
}
