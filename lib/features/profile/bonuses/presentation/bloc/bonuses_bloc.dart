import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/domain/use_cases/get_bonuses_use_case.dart';

part 'bonuses_bloc.freezed.dart';
part 'bonuses_event.dart';
part 'bonuses_state.dart';

typedef _Emit = Emitter<BonusesState>;

@injectable
class BonusesBloc extends Bloc<BonusesEvent, BonusesState> {
  BonusesBloc(this._getBonusesUseCase) : super(const _Initial()) {
    on<_StartedEvent>(_onStarted);

    // При первом обращении получаем бонусы
    add(const _StartedEvent());
  }

  final GetBonusesUseCase _getBonusesUseCase;

  Future<void> _onStarted(
    _StartedEvent event,
    _Emit emit,
  ) async {
    emit(const _Loading());
    (await _getBonusesUseCase.call()).fold(
      (failure) => emit(_Error(message: failure.error)),
      (bonuses) => emit(_Loaded(bonuses: bonuses)),
    );
  }
}
