import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/core/utils/logger/logger.dart';
import 'package:niagara_app/features/auth/data/datasources/local/skip_auth_data_source.dart';
import 'package:niagara_app/features/auth/domain/repositories/auth_repository.dart';

/// Репозиторий для работы с авторизацией.
@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  /// Конструктор репозитория.
  /// - [localDataSource] - локальный источник данных.
  /// - [logger] - логгер.
  AuthRepository({
    required IAuthLocalDataSource localDataSource,
    required IAppLogger logger,
  })  : _localDataSource = localDataSource,
        _logger = logger;

  final IAuthLocalDataSource _localDataSource;
  final IAppLogger _logger;

  @override
  Future<Either<Failure, AuthenticatedStatus>> onCheckAuthStatus() async {
    try {
      final res = await _localDataSource.onCheckAuthStatus();
      return Right(AuthenticatedStatus.values[res]);
    } on Exception catch (e, st) {
      _logger.handle(e, st);
      return Left(AuthRepoFailure());
    }
  }

  @override
  Future<Either<Failure, void>> onSetAuthStatus({
    required AuthenticatedStatus status,
  }) async {
    try {
      await _localDataSource.onSetAuthStatus(status: status.index);
      return const Right(null);
    } on Exception catch (e, st) {
      _logger.handle(e, st);
      return Left(AuthRepoFailure());
    }
  }
}
