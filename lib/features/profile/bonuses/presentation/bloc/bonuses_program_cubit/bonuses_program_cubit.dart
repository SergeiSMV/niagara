import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses_program.dart';
import 'package:niagara_app/features/profile/bonuses/domain/use_cases/get_bonuses_program_use_case.dart';

part 'bonuses_program_cubit.freezed.dart';
part 'bonuses_program_state.dart';

@injectable
class BonusesProgramCubit extends Cubit<BonusesProgramState> {
  BonusesProgramCubit(this._bonusesProgramUseCase)
      : super(const BonusesProgramState.initial()) {
    /// Получение информации о программе бонусов
    getAboutBonusProgram();
  }

  final GetBonusesProgramUseCase _bonusesProgramUseCase;

  Future<void> getAboutBonusProgram() async {
    _emit(const BonusesProgramState.loading());

    await _bonusesProgramUseCase.call().fold(
          (_) => _emit(const BonusesProgramState.error()),
          (bonusesProgram) =>
              _emit(BonusesProgramState.loaded(bonusesProgram: bonusesProgram)),
        );
  }

  void _emit(BonusesProgramState state) {
    if (isClosed) return;
    emit(state);
  }
}
