part of '../../core.dart';

/// Абстрактный класс [BaseUseCase] с параметрами [Type] и [Params].
/// [Type] - тип возвращаемого значения,
/// [Params] - тип параметров, которые принимает случай использования.
/// Возвращает [Either] с [Failure] и [Type].
abstract class BaseUseCase<Type, Params> {
  /// Создает объект случая использования.
  const BaseUseCase();

  /// Метод [call] выполняет логику случая использования. Принимает параметры
  /// [params] и возвращает [Either] с [Failure] и [Type].
  Future<Either<Failure, Type>> call(Params params);
}

/// Пустой класс [NoParams] для случаев использования без параметров.
class NoParams {}
