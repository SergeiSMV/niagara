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

class AuthRepoFailure extends Failure {
  const AuthRepoFailure([super.error]);
}

class TokenRemoteFailure extends Failure {
  const TokenRemoteFailure([super.error]);
}

class TokenLocalFailure extends Failure {
  const TokenLocalFailure([super.error]);
}

class TokenRepositoryFailure extends Failure {
  const TokenRepositoryFailure([super.error]);
}
