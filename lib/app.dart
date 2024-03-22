import 'package:flutter/material.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/router/app_router.dart';
import 'package:niagara_app/core/theme/app_theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Основная точка входа в приложение
class Application extends StatelessWidget {
  /// Конструктор приложения по умолчанию
  const Application({super.key});

  Talker get _talker => getIt<Talker>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter().config(
        navigatorObservers: () => [
          TalkerRouteObserver(_talker),
        ],
      ),
    );
  }
}
