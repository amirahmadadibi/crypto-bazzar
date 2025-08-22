part of 'coin_list_bloc_bloc.dart';

@immutable
sealed class CoinListBlocEvent {}

class LoadInitialCoinsDataEvent extends CoinListBlocEvent {}
class RefreshCoinDataEvent extends CoinListBlocEvent {}
