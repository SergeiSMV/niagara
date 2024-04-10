import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/auth/domain/repositories/auth_repository.dart';

/// Повторно отправляет код подтверждения.
/// 
/// Возвращает [ResendCodeFailure], если номер телефона не был отправлен.
/// Возвращает [Right<void>] если номер телефона был отправлен.
@injectable
class ResendPhoneUseCase extends UseCase<void, NoParams> {
  ResendPhoneUseCase({
    required IAuthRepository repository,
  }) : _repository = repository;

  final IAuthRepository _repository;

  @override
  Future<Either<Failure, void>> call([NoParams? params]) =>
      _repository.resendCode();
}
