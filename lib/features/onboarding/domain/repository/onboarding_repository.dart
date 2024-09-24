import 'package:niagara_app/core/core.dart';

/// Репозиторий для работы с онбордингом.
abstract interface class IOnboardingRepository {
  /// Устанавливает статус прохождения онбординга `true`.
  Future<Either<Failure, void>> setPassed();

  /// Проверяет, прошел ли пользователь онбординг.
  Future<Either<Failure, bool>> isPassed();
}
