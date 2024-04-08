part of '../../../core.dart';

/// UseCase для получения токена
@injectable
class GetTokenUseCase extends UseCase<String, NoParams> {
  /// Конструктор UseCase для получения токена
  const GetTokenUseCase({
    required ITokenRepository repository,
  }) : _repository = repository;

  final ITokenRepository _repository;

  @override
  Future<Either<Failure, String>> call([NoParams? params]) async =>
      _repository.onGetToken();
}
