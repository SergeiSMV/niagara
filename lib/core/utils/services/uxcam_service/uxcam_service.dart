import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:get_it/get_it.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';

/// Сервис для работы с UXCam.
@lazySingleton
class UXCamService {
  const UXCamService({required this.appLogger});
  final IAppLogger appLogger;

  /// Инициализирует UXCam.
  Future<void> initialize() async {
    if (AppConstants.kDebugMode) {
      return;
    }

    final uxcamKey = GetIt.I<String>(instanceName: ApiConst.uxcamAppKey);
    try {
      FlutterUxcam.optIntoSchematicRecordings();

      final config = FlutterUxConfig(
        userAppKey: uxcamKey,
        enableAutomaticScreenNameTagging: false,
      );

      await FlutterUxcam.startWithConfiguration(config);
    } on Exception catch (e, stackTrace) {
      appLogger.handle(e, stackTrace);
    }
  }

  /// Применяет маску UXCam для страницы.
  void applyOcclusion() {
    if (AppConstants.kDebugMode) {
      return;
    }
    final blur = FlutterUXBlur();
    FlutterUxcam.applyOcclusion(blur);
  }

  /// Удаляет маску UXCam со страницы.
  void removeOcclusion() {
    if (AppConstants.kDebugMode) {
      return;
    }
    final blur = FlutterUXBlur();
    FlutterUxcam.removeOcclusion(blur);
  }
}
