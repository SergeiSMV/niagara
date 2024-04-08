part of '../../core.dart';

/// Абстрактный класс [UseCase] с параметрами [Type] и [Params].
/// [Type] - тип возвращаемого значения,
/// [Params] - тип параметров, которые принимает случай использования.
/// Возвращает [Either] с [Failure] и [Type].
abstract class UseCase<Type, Params> {
  /// Создает объект случая использования.
  const UseCase();

  /// Метод [call] выполняет логику случая использования. Принимает параметры
  /// [params] и возвращает [Either] с [Failure] и [Type].
  Future<Either<Failure, Type>> call([Params? params]);
}

/// Пустой класс [NoParams] для случаев использования без параметров.
class NoParams {}
