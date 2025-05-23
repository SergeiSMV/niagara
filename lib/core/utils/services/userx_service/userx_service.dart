import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:userx_flutter/userx_flutter.dart';

import '../../../core.dart';
import '../../constants/app_constants.dart';

/// Сервис для работы с UserX (запись экрана).
@lazySingleton
class UserXService {
  const UserXService({required this.appLogger});

  final IAppLogger appLogger;

  /// Инициализирует UXCam.
  Future<void> initialize() async {
    if (AppConstants.kDebugMode) return;
    final String appKey = GetIt.I<String>(instanceName: ApiConst.userxAppKey);

    try {
      UserX.start(appKey);

      appLogger.log(
        message: '[UserXService] initialize success',
        level: LogLevel.info,
      );
    } on Exception catch (e, stackTrace) {
      appLogger.handle(e, stackTrace, '[UserXService] initialize');
    }
  }

  /// Применяет маску UXCam для страницы.
  Future<void> applyOcclusion() async {
    if (AppConstants.kDebugMode) return;
    UserX.stopScreenRecording();

    appLogger.log(
      message: '[UserXService] applyOcclusion',
      level: LogLevel.info,
    );
  }

  /// Удаляет маску UXCam со страницы.
  Future<void> removeOcclusion() async {
    if (AppConstants.kDebugMode) return;
    UserX.startScreenRecording();

    appLogger.log(
      message: '[UserXService] removeOcclusion',
      level: LogLevel.info,
    );
  }

  /// Устанавливает идентификатор пользователя для UXCam.
  ///
  /// [username] - имя пользователя или null, если пользователь не авторизован.
  Future<void> setUserIdentity(String? username) async {
    if (AppConstants.kDebugMode) return;
    try {
      if (username != null && username.isNotEmpty) {
        UserX.setUserId(username);
        appLogger.log(
          message: '[UserXService] setUserIdentity: $username',
          level: LogLevel.info,
        );
      } else {
        UserX.setUserId('anonymous_user');

        appLogger.log(
          message: '[UserXService] setUserIdentity: anonymous_user',
          level: LogLevel.info,
        );
      }
    } on Exception catch (e, stackTrace) {
      appLogger.handle(e, stackTrace, '[UserXService] setUserIdentity');
    }
  }
}
