import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/core.dart';
import '../../../../core/dependencies/di.config.dart';
import '../../../../core/dependencies/di.dart';
import '../../../../core/utils/enums/auth_status.dart';
import 'navigation_page.dart';

/// Виджет-обертка для [NavigationPage], который обрабатывает изменения
/// статуса авторизации.
///
/// При выходе из аккаунта или авторизации после ее изначального пропуска
/// вызывает перезапуск приложения:
/// - Перенаправляет пользователя на [SplashRoute],
/// - Вызывает [GetIt.reset] и [GetIt.init] для перезагрузки зависимостей.
class AuthCheckWrapper extends StatefulWidget {
  const AuthCheckWrapper({required this.child, super.key});

  /// Дочерний виджет.
  final Widget child;

  @override
  State<AuthCheckWrapper> createState() => _AuthCheckWrapperState();
}

class _AuthCheckWrapperState extends State<AuthCheckWrapper> {
  /// Последний статус авторизации.
  ///
  /// Нужен для проверки, изменился ли статус авторизации.
  AuthenticatedStatus? _lastAuthStatus;

  /// Подписка на изменения статуса авторизации.
  StreamSubscription<AuthenticatedStatus>? _authStatusSubscription;

  void _log(String message) {
    getIt<IAppLogger>().log(
      level: LogLevel.info,
      message: message,
    );
  }

  @override
  void initState() {
    super.initState();
    _log('[AuthCheckWrapper] initState');

    _authStatusSubscription = getIt<Stream<AuthenticatedStatus>>()
        .distinct()
        .listen(_onAuthStatusChanged);
  }

  Future<void> _onAuthStatusChanged(AuthenticatedStatus status) async {
    _log('[AuthCheckWrapper] _onAuthStatusChanged: $status');

    /// Проверка первый вход в приложение, когда авторизация еще не произошла,
    /// но и не была пропущена.
    ///
    /// Это дополнительная мера защиты, этот виджет еще не существует, пока
    /// пользователь не решил пропустить авторизаци или пройти ее.
    if (status.isUnknown) return;

// Если статус авторизации изменился, то перезагружаем приложение.
    if (_lastAuthStatus != status) {
      // Обновляем последний статус авторизации.
      _lastAuthStatus = status;

      // Перезагружаем приложение.
      _log('[AuthCheckWrapper] replaceAll called');
      await getIt.reset();
      await getIt.init();

      // Перенаправляем пользователя на [SplashRoute].
      context.router.replaceAll([const SplashRoute()]);
    }
  }

  @override
  Future<void> dispose() async {
    _authStatusSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
