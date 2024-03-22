import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:niagara_app/app.dart';
import 'package:niagara_app/core/dependencies/di.dart' as di;
import 'package:niagara_app/core/utils/logger/logger.dart';

void main() async {
  /// Инициализация Flutter.
  /// Проверка на инициализацию FlutterBinding.
  WidgetsFlutterBinding.ensureInitialized();

  /// Загрузка переменных окружения из файла `.env`.
  await dotenv.load();

  /// Инициализация зависимостей.
  di.setupDependencies();

  /// Запрет на горизонтальное вращение экрана.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  di.getIt<AppLogger>().verbose('Application started');

  /// Запуск приложения.
  runApp(const Application());
}
