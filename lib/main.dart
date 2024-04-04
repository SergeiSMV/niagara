import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:niagara_app/app.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.dart';
import 'package:niagara_app/core/common/presentation/theme/app_theme.dart';
import 'package:niagara_app/core/dependencies/di.dart' as di;
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/core/utils/logger/logger.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async {
  /// Инициализация Flutter.
  /// Проверка на инициализацию FlutterBinding.
  WidgetsFlutterBinding.ensureInitialized();

  /// Загрузка переменных окружения.
  await dotenv.load();

  /// Инициализация зависимостей.
  await di.setupDependencies();

  /// Инициализация [TalkerBlocObserver] для логирования событий и состояний.
  Bloc.observer = di.getIt<TalkerBlocObserver>();

  /// Инициализация локализации.
  LocaleSettings.useDeviceLocale();

  /// Запрет на горизонтальное вращение экрана.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  di.getIt<IAppLogger>().info('Application started');

  /// Запуск приложения.
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
