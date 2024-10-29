import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/settings_type.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/permissions/open_settings_use_case.dart';
import 'package:niagara_app/features/onboarding/domain/use_case/check_notifications_permission_use_case.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class NotificationPermissionCubit extends Cubit<bool> {
  NotificationPermissionCubit(
    this._notificationsPermissionUseCase,
    this._openSettingsUseCase,
  ) : super(false) {
    _checkPermission();
  }

  final NotificationsPermissionUseCase _notificationsPermissionUseCase;
  final OpenSettingsUseCase _openSettingsUseCase;

  /// Проверяет разрешение на отправку уведомлений.
  Future<bool> _checkPermission() async {
    final bool isGranted = await _notificationsPermissionUseCase.call().fold(
          (failure) => false,
          (status) => status.isGranted,
        );

    emit(isGranted);
    return isGranted;
  }

  /// Открывает настройки приложения, если уведомления не разрешены.
  Future<void> openSettings() async {
    final bool isGranted = await _checkPermission();
    if (isGranted) return;

    await _openSettingsUseCase.call(SettingsType.app);
  }
}
