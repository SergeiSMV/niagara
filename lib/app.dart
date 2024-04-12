import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.dart';
import 'package:niagara_app/core/common/presentation/theme/app_theme.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Основная точка входа в приложение
class Application extends StatelessWidget {
  const Application({
    required Talker talker,
    required AppRouter router,
    required AppTheme theme,
    super.key,
  })  : _talker = talker,
        _router = router,
        _theme = theme;

  final Talker _talker;
  final AppRouter _router;
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
