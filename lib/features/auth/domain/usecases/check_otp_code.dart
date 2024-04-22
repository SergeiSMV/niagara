import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/auth/domain/repositories/auth_repository.dart';

/// Проверяет код подтверждения.
///
/// Возвращает:
/// - [void] если код подтверждения верный.
/// - [Failure] если код подтверждения не верный.
@injectable
class CheckOTPCodeUseCase extends BaseUseCase<void, CheckOTPParams> {
  CheckOTPCodeUseCase({
    required IAuthRepository repository,
  }) : _repository = repository;

  final IAuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(CheckOTPParams params) =>
      _repository.checkCode(code: params.code);
}

class CheckOTPParams extends Equatable {
  const CheckOTPParams({
    required this.code,
  });

  final String code;

  @override
  List<Object?> get props => [code];
}
