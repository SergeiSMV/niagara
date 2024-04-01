part of '../core.dart';

/// Модуль зависимостей приложения.
@module
abstract class AppModule {
  /// Экземпляр [Talker] для работы с логированием.
  @lazySingleton
  Talker get talker => TalkerFlutter.init();

  /// Экземпляр [TalkerBlocObserver] для логирования событий и состояний.
  @lazySingleton
  TalkerBlocObserver get talkerBlocObserver => TalkerBlocObserver(
        talker: talker,
        settings: const TalkerBlocLoggerSettings(
          printChanges: true,
          printStateFullData: false,
        ),
      );

  /// Экземпляр [AppLogger] для работы с логированием.
  @lazySingleton
  AppLogger get appLogger => AppTalkerLogger(talker: talker);

  /// Экземпляр [Dio] для работы с HTTP-запросами.
  @lazySingleton
  Dio get dio => Dio()
    ..interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
      ),
    );

  /// Экземпляр [SharedPreferences] для работы с хранилищем данных.
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
      // ..then((value) => value.clear());
}
