part of 'bonuses_program_cubit.dart';

@freezed
class BonusesProgramState with _$BonusesProgramState {
  const factory BonusesProgramState.initial() = _Initial;
  const factory BonusesProgramState.loading() = _Loading;
  const factory BonusesProgramState.loaded({
    required BonusesProgram bonusesProgram,
  }) = _Loaded;
  const factory BonusesProgramState.error() = _Error;
}
