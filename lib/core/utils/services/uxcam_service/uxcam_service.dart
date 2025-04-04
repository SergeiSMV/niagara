import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../core.dart';
import '../../constants/app_constants.dart';

/// Маска для UXCam.
final _blur = FlutterUXBlur();

/// Сервис для работы с UXCam.
@lazySingleton
class UXCamService {
  const UXCamService({required this.appLogger});
  final IAppLogger appLogger;

  /// Инициализирует UXCam.
  Future<void> initialize() async {
    if (AppConstants.kDebugMode) return;
    final uxcamKey = GetIt.I<String>(instanceName: ApiConst.uxcamAppKey);
    try {
      FlutterUxcam.optIntoSchematicRecordings();
      final config = FlutterUxConfig(
        userAppKey: uxcamKey,
        enableAutomaticScreenNameTagging: false,
      );
      await FlutterUxcam.startWithConfiguration(config).then((_) {
        appLogger.log(
          message: 'initialize success',
          level: LogLevel.info,
        );
      });
    } on Exception catch (e, stackTrace) {
      appLogger.handle(e, stackTrace);
    }
  }

  /// Применяет маску UXCam для страницы.
  Future<void> applyOcclusion() async {
    if (AppConstants.kDebugMode) return;
    FlutterUxcam.applyOcclusion(_blur);
  }

  /// Удаляет маску UXCam со страницы.
  Future<void> removeOcclusion() async {
    if (AppConstants.kDebugMode) return;
    FlutterUxcam.removeOcclusion(_blur);
  }

  /// Устанавливает идентификатор пользователя для UXCam.
  ///
  /// [username] - имя пользователя или null, если пользователь не авторизован.
  Future<void> setUserIdentity(String? username) async {
    if (AppConstants.kDebugMode) return;
    try {
      if (username != null && username.isNotEmpty) {
        FlutterUxcam.setUserIdentity(username).then((_) {
          appLogger.log(
            message: 'setUserIdentity success',
            level: LogLevel.info,
          );
        });
      } else {
        FlutterUxcam.setUserIdentity('anonymous_user').then((_) {
          appLogger.log(
            message: 'setUserIdentity success',
            level: LogLevel.info,
          );
        });
      }
    } on Exception catch (e, stackTrace) {
      appLogger.handle(e, stackTrace);
    }
  }
}
