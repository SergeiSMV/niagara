import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/app.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.dart';
import 'package:niagara_app/core/common/presentation/theme/app_theme.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/dependencies/di.dart' as di;
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/firebase_options.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await di.setupDependencies();

  Bloc.observer = di.getIt<TalkerBlocObserver>();

  LocaleSettings.useDeviceLocale();

  /// Запрет на горизонтальное вращение экрана.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
