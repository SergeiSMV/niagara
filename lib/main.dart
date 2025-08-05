import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'core/common/presentation/app.dart';
import 'core/common/presentation/router/app_router.dart';
import 'core/common/presentation/theme/app_theme.dart';
import 'core/core.dart';
import 'core/dependencies/di.dart' as di;
import 'core/utils/crashlytics/crashlytics_error_filter.dart';
import 'core/utils/gen/strings.g.dart';
import 'core/utils/network/overrides/http_overrides.dart';
import 'core/utils/services/userx_service/userx_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);

  FlutterError.onError = (FlutterErrorDetails err) async {
    if (!CrashlyticsErrorFilter.isErrorFatal(err)) return;

    await FirebaseCrashlytics.instance.recordFlutterFatalError(err);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    unawaited(
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      ),
    );
    return true;
  };

  await di.setupDependencies();

  Bloc.observer = di.getIt<TalkerBlocObserver>();

  LocaleSettings.useDeviceLocale();

  di.getIt<UserXService>().initialize();

  /// Запрет на горизонтальное вращение экрана.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// Переопределение HTTP-запросов.
  HttpOverrides.global = AppHttpOverrides();

  di.getIt<IAppLogger>().log(
        level: LogLevel.verbose,
        message: 'Application started',
      );

  runApp(
    TranslationProvider(
      child: Application(
        talker: di.getIt<Talker>(),
        router: di.getIt<AppRouter>(),
        theme: di.getIt<AppTheme>(),
      ),
    ),
  );
}
