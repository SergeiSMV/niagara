// ignore_for_file: one_member_abstracts

part of '../core.dart';

/// Абстрактный класс [UseCase] является базовым классом для всех случаев
/// использования в приложении. Он принимает два параметра: [Type] - тип
/// возвращаемого значения, и [Params] - тип параметров, которые принимает
/// случай использования. Возвращает [Either] с [Failure] и [Type].
abstract class UseCase<Type, Params> {
  /// Создает объект случая использования.
  const UseCase();

  /// Метод [call] выполняет логику случая использования. Принимает параметры
  /// [params] и возвращает [Either] с [Failure] и [Type].
  Future<Either<Failure, Type>> call(Params params);
}

/// Класс [NoParams] используется для передачи пустых параметров в случае, если
/// у [UseCase] нет параметров.
class NoParams extends Equatable {
  /// Создает объект пустых параметров.
  const NoParams();
  @override
  List<Object?> get props => [];
}
