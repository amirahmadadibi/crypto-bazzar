import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'coin_list_bloc_event.dart';
part 'coin_list_bloc_state.dart';

class CoinListBlocBloc extends Bloc<CoinListBlocEvent, CoinListBlocState> {
  CoinListBlocBloc() : super(CoinListBlocInitial()) {
    on<CoinListBlocEvent>((event, emit) {
     
    });
  }
}
