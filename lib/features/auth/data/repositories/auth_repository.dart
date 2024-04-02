import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/auth/data/datasources/local/skip_auth_data_source.dart';
import 'package:niagara_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Репозиторий для работы с авторизацией.
@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  /// Конструктор репозитория.
  /// - [localDataSource] - локальный источник данных.
  AuthRepository({
    required IAuthLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  Talker get _logger => getIt<Talker>();

  final IAuthLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, AuthenticatedStatus>> onCheckAuthStatus() async {
    try {
      final res = await _localDataSource
          .onCheckAuthStatus()
          .then((status) => AuthenticatedStatus.values[status]);
      return Right(res);
    } on Exception catch (e, st) {
      _logger.handle(e, st);
      return Left(SkipAuthFailure());
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
      return Left(SkipAuthFailure());
    }
  }
}
