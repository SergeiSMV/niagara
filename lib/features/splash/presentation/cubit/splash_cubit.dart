import 'package:flutter_bloc/flutter_bloc.dart';

/// Кубит для управления состоянием загрузки приложения
class SplashCubit extends Cubit<bool> {
  /// Конструктор по умолчанию
  SplashCubit() : super(false);

  /// Уведомление о готовности к переходу
  void readyToNavigate() => emit(true);
}
