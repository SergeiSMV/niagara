import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';

/// [Cubit] для выбора способа активации ВИП-подписки.
@injectable
class VipActivationSelectionCubit extends Cubit<ActivationOption?> {
  VipActivationSelectionCubit() : super(null);

  /// Выбирает опцию активации.
  ///
  /// Если переданная опция равна текущей, то она снимается.
  void select(ActivationOption option) {
    if (option == state) {
      emit(null);
      return;
    }

    emit(option);
  }
}
