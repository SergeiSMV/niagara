import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/authorization/phone_auth/data/data_sources/auth_local_data_source.dart';
import 'package:niagara_app/features/authorization/phone_auth/data/data_sources/auth_remote_data_source.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/repositories/auth_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository extends BaseRepository implements IAuthRepository {
  AuthRepository(
    super._logger,
    super._networkInfo,
    this._authLDS,
    this._authRDS,
  );

  final IAuthLocalDataSource _authLDS;
  final IAuthRemoteDatasource _authRDS;

  /// Кешируем номер телефона, чтобы избежать нескольких запросов к хранилищам.
  String? _cachedPhone;

  @override
  Failure get failure => const AuthRepositoryFailure();

  @override
  Stream<AuthenticatedStatus> get authStatusStream =>
      _authLDS.authStatusStream.distinct().map((status) {
        final verbose = AuthenticatedStatus.values[status];

        getIt<IAppLogger>().log(
          level: LogLevel.info,
          message: 'Auth status changed to: $verbose',
        );

        return verbose;
      });

  @override
  Future<Either<Failure, void>> logout() => execute(_logout);

  @override
  Future<Either<Failure, AuthenticatedStatus>> checkAuthStatus() =>
      execute(_checkAuthStatus);

  @override
  Future<Either<Failure, void>> sendPhone({required String phone}) =>
      execute(() => _sendPhone(phone));

  @override
  Future<Either<Failure, void>> skipAuth() => execute(_skipAuth);

  @override
  Future<Either<Failure, void>> resendCode() {
    if (_cachedPhone == null) {
      return Future.value(const Left(ResendCodeFailure()));
    }

    return execute(() => _sendPhone(_cachedPhone!));
  }

  @override
  Future<Either<Failure, void>> checkCode({required String code}) =>
      execute(() => _checkCode(code));

  Future<AuthenticatedStatus> _checkAuthStatus() async {
    return _authLDS
        .checkAuthStatus()
        .then((value) => AuthenticatedStatus.values[value]);
  }

  Future<void> _sendPhone(String phone) async {
    _cachedPhone = phone;
    return _authRDS.onCreateCode(phone: phone).fold(
      (failure) => throw CreateCodeFailure(failure.error),
      (isValid) {
        if (!isValid) throw const CreateCodeFailure();
        return;
      },
    );
  }

  Future<void> _checkCode(String code) async {
    if (_cachedPhone == null) throw const PhoneNotFoundFailure();

    return _authRDS.onConfirmCode(phone: _cachedPhone!, code: code).fold(
      (failure) => throw ValidateCodeFailure(failure.error),
      (success) async {
        if (!success) throw const ValidateCodeFailure();

        await _authLDS.setAuthStatus(
          status: AuthenticatedStatus.authenticated.index,
        );
        _cachedPhone = null;
      },
    );
  }

  Future<void> _skipAuth() {
    return _authLDS.setAuthStatus(
      status: AuthenticatedStatus.unauthenticated.index,
    );
  }

  Future<void> _logout() {
    return _authRDS.logout().fold(
          (failure) => throw AuthRepositoryFailure(failure.error),
          (success) => _authLDS.setAuthStatus(
            status: AuthenticatedStatus.unauthenticated.index,
          ),
        );
  }
}
