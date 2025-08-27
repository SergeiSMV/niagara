import 'package:bloc/bloc.dart';

import '../../../../../../core/core.dart';

/// Кубит для работы с проверкой согласия на обработку персональных данных
/// и маркетинговых коммуникаций
@injectable
class PrivacyCheckCubit extends Cubit<({bool user, bool marketing})> {
  PrivacyCheckCubit() : super((user: false, marketing: false));

  /// Устанавливает значение для пользовательского соглашения
  void setUser(bool value) {
    emit((user: value, marketing: state.marketing));
  }

  /// Устанавливает значение для маркетинговых соглашенийa
  void setMarketing(bool value) {
    emit((user: state.user, marketing: value));
  }

  /// Сбрасывает оба состояния в false
  void reset() {
    emit((user: false, marketing: false));
  }
}
