part of '../../../core.dart';

/// UseCase для проверки токена
@injectable
class CheckTokenUseCase extends UseCaseNoParams<bool> {
  /// Конструктор UseCase для проверки токена
  const CheckTokenUseCase({
    required ITokenRepository repository,
  }) : _repository = repository;

  final ITokenRepository _repository;

  @override
  Future<Either<Failure, bool>> call() async => _repository.onCheckToken();
}
