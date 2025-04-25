import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../../core/utils/enums/onboarding_step.dart';
import '../../../locations/addresses/domain/use_cases/permissions/get_user_position_use_case.dart';
import '../../domain/use_case/check_notifications_permission_use_case.dart';
import '../../domain/use_case/set_passed_oboarding_use_case.dart';

/// [Cubit] для управления этапами онбординга.
@injectable
class OnboardingCubit extends Cubit<OnboardingStep> {
  OnboardingCubit(
    this._locationPermissionUseCase,
    this._notificationsPermissionUseCase,
    this._setPassedOnboardingUseCase,
  ) : super(OnboardingStep.greeting);

  /// Кейс запроса разрешения на геопозицию.
  final LocationPermissionUseCase _locationPermissionUseCase;

  /// Кейс запроса разрешения на уведомления.
  final NotificationsPermissionUseCase _notificationsPermissionUseCase;

  final SetPassedOnboardingUseCase _setPassedOnboardingUseCase;

  /// Список этапов онбординга.
  final List<OnboardingStep> _steps = [
    OnboardingStep.greeting,
    // [Android] не требует разрешения на уведомления.
    if (!Platform.isAndroid) OnboardingStep.notification,
    OnboardingStep.geoposition,
    OnboardingStep.finished,
  ];

  /// Индекс текущего этапа.
  int _index = 0;

  /// Текущий этап.
  OnboardingStep get _current => _steps[_index];

  /// Перенаправляет пользователя на следующий этап без каких-либо действий.
  void showNext() {
    if (_index < _steps.length - 1) {
      _index++;
    }

    emit(_current);
  }

  /// Пропускает все оставшиеся этапы.
  void skipAll() {
    _index = _steps.length - 1;
    emit(_current);
  }

  /// Запрашивает у пользователя то или иное разрешение, если это требуется на
  /// текущем этапе, и перенаправляет его на следующий.
  Future<void> showNextWithAction() async {
    switch (_current) {
      case OnboardingStep.notification:
        await _notificationsPermissionUseCase.call();

      case OnboardingStep.geoposition:
        await _locationPermissionUseCase.call();

      default:
        break;
    }

    showNext();
  }

  /// Завершает онбординг и сохраняет информацию о прохождении в хранилище.
  void onFinished() => _setPassedOnboardingUseCase.call();
}
