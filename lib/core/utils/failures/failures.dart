// ignore_for_file: public_member_api_docs

part of '../../core.dart';

/// Класс [Failure] является базовым классом для всех ошибок, которые могут
/// возникнуть в приложении. Содержит описание ошибки (при наличии).
sealed class Failure with EquatableMixin implements Exception {
  /// Создает экземпляр [Failure].
  /// - [error] - описание ошибки.
  const Failure(this.error);

  final String? error;

  @override
  List<Object?> get props => [error];
}

// ! ------------------------------- Token ------------------------------- ! //
class CreateTokenFailure extends Failure {
  const CreateTokenFailure([super.error]);
}

class GetTokenFailure extends Failure {
  const GetTokenFailure([super.error]);
}

class TokenNotFoundFailure extends Failure {
  const TokenNotFoundFailure([super.error = 'Token not found']);
}

class BasicAuthFailure extends Failure {
  const BasicAuthFailure([super.error]);
}

// ! ----------------------------- Device ID ----------------------------- ! //
class DeviceIdFailure extends Failure {
  const DeviceIdFailure([super.error = 'Device ID failure']);
}

// ! -------------------------------- Auth ------------------------------- ! //
class CreateCodeFailure extends Failure {
  const CreateCodeFailure([super.error = 'Invalid phone number']);
}

class ValidateCodeFailure extends Failure {
  const ValidateCodeFailure([super.error = 'Invalid auth code']);
}

class CheckAuthStatusFailure extends Failure {
  const CheckAuthStatusFailure([super.error]);
}

class ResendCodeFailure extends Failure {
  const ResendCodeFailure([super.error]);
}

class SkipAuthFailure extends Failure {
  const SkipAuthFailure([super.error]);
}

class PhoneNotFoundFailure extends Failure {
  const PhoneNotFoundFailure([super.error = 'Phone not found']);
}

// ! ------------------------------ Location ------------------------------ ! //

class PermissionDeniedForeverException extends Failure {
  const PermissionDeniedForeverException([super.error = 'Permission denied']);
}

class ServiceNotEnabledException extends Failure {
  const ServiceNotEnabledException([super.error = 'Location service failure']);
}
