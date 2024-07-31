import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_description.dart';
import 'package:niagara_app/features/profile/referral_program/domain/use_cases/get_referral_description_use_case.dart';

part 'referral_event.dart';
part 'referral_state.dart';
part 'referral_bloc.freezed.dart';

@injectable
class ReferralBloc extends Bloc<ReferralEvent, ReferralState> {
  ReferralBloc(
    this._getInfo,
  ) : super(const _Loading()) {
    on<_StartedEvent>(_onStarted);

    add(const ReferralEvent.started());
  }

  final GetReferralDescriptionUseCase _getInfo;

  Future<void> _onStarted(
    _StartedEvent event,
    Emitter<ReferralState> emit,
  ) async {
    emit(const _Loading());
    await _getInfo(NoParams()).fold(
      (failure) => emit(_Error(message: failure.error)),
      (info) => emit(_Loaded(statusDescription: info)),
    );
  }
}
