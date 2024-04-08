part of '../../../core.dart';

/// UseCase для проверки токена
@injectable
class CheckTokenUseCase extends UseCase<bool, NoParams> {
  /// Конструктор UseCase для проверки токена
  const CheckTokenUseCase({
    required ITokenRepository repository,
  }) : _repository = repository;

  final ITokenRepository _repository;

  @override
  Future<Either<Failure, bool>> call([NoParams? params]) async =>
      _repository.onCheckToken();
}
