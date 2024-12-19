import 'package:flutter_bloc/flutter_bloc.dart';

class CheckBonusesCubit extends Cubit<BonusesState> {
  CheckBonusesCubit() : super(BonusesState.initial);

  // int bonuses =

  void reset() => emit(BonusesState.initial);
}

enum BonusesState {
  initial,
  loading,
  error,
  success,
}
