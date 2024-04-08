// ignore_for_file: public_member_api_docs

part of '../../core.dart';

/// Класс [Failure] является базовым классом для всех ошибок, которые могут
/// возникнуть в приложении. Он реализует [Equatable] для сравнения объектов
/// ошибок. Все ошибки должны наследоваться от этого класса.
sealed class Failure extends Equatable {
  /// Создает экземпляр [Failure].
  /// - [error] - описание ошибки.
  const Failure([this.error]);

  final String? error;

  @override
  List<Object?> get props => [error];
}

// ! ------------------------------- Token ------------------------------- ! //
class GetTokenFailure extends Failure {
  const GetTokenFailure([super.error]);
}

class CheckTokenFailure extends Failure {
  const CheckTokenFailure([super.error]);
}

// ! -------------------------------- Auth ------------------------------- ! //
class CreateCodeFailure extends Failure {
  const CreateCodeFailure([super.error]);
}

class ValidateCodeFailure extends Failure {
  const ValidateCodeFailure([super.error]);
}

class CheckAuthStatusFailure extends Failure {
  const CheckAuthStatusFailure([super.error]);
}

class SkipAuthFailure extends Failure {
  const SkipAuthFailure([super.error]);
}
