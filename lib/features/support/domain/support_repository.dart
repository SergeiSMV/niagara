import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/core.dart';
import '../../../core/utils/enums/auth_status.dart';
import '../data/mappers/support_chat_credentials_mapper.dart';
import '../data/remote/support_remote_data_source.dart';
import 'support_chat_credentials.dart';

/// Репозиторий для получения данных для подключения к чату службы поддержки.
abstract interface class ISupportRepository {
  /// Получает данные для подключения к чату службы поддержки.
  Future<Either<Failure, SupportChatCredentials>> getSupportChatCredentials();

  /// Нужно ли очищать кэш сессии (удалять историю чатов).
  Future<Either<Failure, bool>> get shouldClearCache;

  /// Очищает кэш сессии (удаляет историю чатов).
  Future<Either<Failure, void>> clearCache();
}

@LazySingleton(as: ISupportRepository)
class SupportRepository extends BaseRepository implements ISupportRepository {
  SupportRepository(
    super._logger,
    super._networkInfo,
    this._authStatusStream,
    this._supportRemoteDataSource,
  ) {
    initSubscription();
  }

  /// Источник данных для получения данных для подключения к чату службы поддержки.
  final ISupportRemoteDataSource _supportRemoteDataSource;

  /// Инициализирует подписку на [Stream] статуса авторизации.
  ///
  /// Нужно для удаления истории чата при выходе из аккаунта.
  void initSubscription() {
    _authStatusStream.listen((status) async {
      if (!status.hasAuth) {
        await clearCache();
      }
    });
  }

  /// [Stream] статуса авторизации.
  final Stream<AuthenticatedStatus> _authStatusStream;

  @override
  Failure get failure => const SupportRepositoryFailure();

  @override
  Future<Either<Failure, SupportChatCredentials>>
      getSupportChatCredentials() async => execute(
            () async =>
                _supportRemoteDataSource.getSupportChatCredentials().fold(
              (failure) => throw failure,
              (credentials) async {
                final creds = credentials.toModel();

                // Добавляем версию приложения в атрибуты пользователя.
                final packageInfo = await PackageInfo.fromPlatform();
                creds.userAttributes.values['APP_VERSION'] =
                    packageInfo.version;

                return creds;
              },
            ),
          );

  @override
  Future<Either<Failure, bool>> get shouldClearCache async =>
      const Right(false);

  @override
  Future<Either<Failure, void>> clearCache() async {
    try {
      await InAppWebViewController.clearAllCache();
      await WebStorageManager.instance().deleteAllData();
      return const Right(null);
    } on Object catch (_) {
      return Left(failure);
    }
  }
}
