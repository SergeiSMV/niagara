import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/router/app_router.dart';
import 'package:niagara_app/core/theme/app_theme.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Основная точка входа в приложение
class Application extends StatelessWidget {
  /// Конструктор приложения по умолчанию
  const Application({super.key});

  Talker get _talker => getIt<Talker>();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter().config(
          navigatorObservers: () => [
            TalkerRouteObserver(_talker),
          ],
        ),
      );
}
