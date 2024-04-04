part of '../../../core.dart';

/// UseCase для получения токена
@injectable
class GetTokenUseCase extends UseCaseNoParams<void> {
  /// Конструктор UseCase для получения токена
  const GetTokenUseCase({
    required ITokenRepository repository,
  }) : _repository = repository;
  
  final ITokenRepository _repository;

  @override
  Future<Either<Failure, void>> call() async => _repository.getToken();
}
