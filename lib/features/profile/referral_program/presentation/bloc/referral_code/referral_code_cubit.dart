import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_code_data.dart';
import 'package:niagara_app/features/profile/referral_program/domain/use_cases/create_referral_code_use_case.dart';
import 'package:share_plus/share_plus.dart';

part 'referral_code_state.dart';
part 'referral_code_cubit.freezed.dart';

/// Кубит для работы с кодом приглашения.
@injectable
class ReferralCodeCubit extends Cubit<ReferralCodeState> {
  ReferralCodeCubit(this._createReferralCodeUseCase)
      : super(const ReferralCodeState.initial());

  final CreateReferralCodeUseCase _createReferralCodeUseCase;

  /// Создает код приглашения и запускает модальное окно для его отпарвки через
  /// нативный шаринг.
  Future<void> createReferralCode() async {
    // Если код уже создан, сразу делимся им
    if (state is _Loaded) {
      return _shareCode((state as _Loaded).data);
    }

    emit(const ReferralCodeState.loading());

    final result = await _createReferralCodeUseCase(NoParams());
    result.fold(
      (failure) => emit(const ReferralCodeState.error()),
      (data) async {
        emit(ReferralCodeState.loaded(data));
        return _shareCode((state as _Loaded).data);
      },
    );
  }

  Future<void> _shareCode(ReferralCodeData data) => Share.share(data.message);
}
