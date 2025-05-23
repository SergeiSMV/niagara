import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../utils/gen/strings.g.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Основной виджет приложения.
class Application extends StatelessWidget {
  const Application({
    required Talker talker,
    required AppRouter router,
    required AppTheme theme,
    super.key,
  })  : _talker = talker,
        _router = router,
        _theme = theme;

  /// Логгер.
  final Talker _talker;

  /// Роутер.
  final AppRouter _router;

  /// Тема.
  final AppTheme _theme;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        theme: _theme.lightTheme,
        routerConfig: _router.config(
          navigatorObservers: () => [
            TalkerRouteObserver(_talker),
          ],
        ),
      );
}
