import '../../../../../../core/core.dart';
import '../../repositories/auth_repository.dart';

/// Проверяет код подтверждения.
///
/// Возвращает:
/// - [void] если код подтверждения верный.
/// - [Failure] если код подтверждения не верный.
@injectable
class CheckOTPCodeUseCase extends BaseUseCase<void, CheckOTPParams> {
  CheckOTPCodeUseCase(this._repository);

  /// Репозиторий для работы с аутентификацией
  final IAuthRepository _repository;

  /// Проверяет код подтверждения
  @override
  Future<Either<Failure, void>> call(CheckOTPParams params) =>
      _repository.checkCode(
        code: params.code,
        user: params.user,
        marketing: params.marketing,
      );
}

/// Параметры для проверки кода подтверждения
class CheckOTPParams extends Equatable {
  const CheckOTPParams({
    required this.code,
    required this.user,
    required this.marketing,
  });

  /// Код подтверждения
  final String code;

  /// Согласие на обработку персональных данных
  final bool user;

  /// Согласие на маркетинговые коммуникации
  final bool marketing;

  @override
  List<Object?> get props => [
        code,
        user,
        marketing,
      ];
}
