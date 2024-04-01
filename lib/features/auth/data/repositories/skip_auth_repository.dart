import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/auth/data/datasources/local/skip_auth_data_source.dart';
import 'package:niagara_app/features/auth/domain/repositories/skip_auth_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Репозиторий для работы с флагом пропуска авторизации.
@LazySingleton(as: ISkipAuthRepository)
class SkipAuthRepository implements ISkipAuthRepository {
  /// Конструктор репозитория.
  /// - [localDataSource] - локальный источник данных.
  SkipAuthRepository({
    required ISkipAuthLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  Talker get _logger => getIt<Talker>();

  final ISkipAuthLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, bool>> checkSkipAuth() async {
    try {
      final skipAuth = await _localDataSource.getSkipAuth();
      return Right(skipAuth);
    } on Exception catch (e, st) {
      _logger.handle(e, st);
      return Left(SkipAuthFailure());
    }
  }

  @override
  Future<Either<Failure, void>> skipAuth({required bool skipAuth}) async {
    try {
      final result = await _localDataSource.cacheSkipAuth(skipAuth: skipAuth);
      return Right(result);
    } on Exception catch (e, st) {
      _logger.handle(e, st);
      return Left(SkipAuthFailure());
    }
  }

  // Future<Either<Failure, T>> _execute<T>({
  //   required Future<T> Function() function,
  //   required Failure failure,
  // }) async {
  //   try {
  //     final result = await function();
  //     return Right(result);
  //   } on Exception catch (e, st) {
  //     _logger.handle(e, st);
  //     return Left(failure);
  //   }
  // }
}
