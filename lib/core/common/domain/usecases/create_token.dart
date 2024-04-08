part of '../../../core.dart';

/// UseCase для получения токена
@injectable
class CreateTokenUseCase extends UseCase<void, NoParams> {
  /// Конструктор UseCase для получения токена
  const CreateTokenUseCase({
    required ITokenRepository repository,
  }) : _repository = repository;

  final ITokenRepository _repository;

  @override
  Future<Either<Failure, void>> call([NoParams? params]) async =>
      _repository.onCreateToken();
}
