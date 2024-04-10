part of '../core.dart';

/// Модуль зависимостей приложения.
@module
abstract class AppModule {
  // ? ------------------------------ Talker ----------------------------- ? //
  /// Экземпляр [Talker] для работы с логированием.
  @lazySingleton
  Talker get talker => TalkerFlutter.init();

  /// Экземпляр [TalkerBlocObserver] для логирования событий и состояний.
  @lazySingleton
  TalkerBlocObserver get talkerBlocObserver => TalkerBlocObserver(
        talker: talker,
        settings: const TalkerBlocLoggerSettings(
          printChanges: true,
          printCreations: true,
          printClosings: true,
        ),
      );

  // ? ------------------------------- Dio ------------------------------- ? //

  /// Базовый URL для API.
  @Named('BaseUrl')
  String get baseUrl =>
      dotenv.get(ApiConst.kBaseUrl, fallback: 'NO_CONFIGURATION');

  /// Экземпляр [Dio] для работы с HTTP-запросами.
  @lazySingleton
  Dio dio(
    @Named('BaseUrl') String url,
    ErrorInterceptor errorInterceptor,
    AuthInterceptor authInterceptor,
  ) =>
      Dio(
        BaseOptions(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 10),
        ),
      )
        ..interceptors.add(errorInterceptor)
        ..interceptors.add(authInterceptor)
        ..interceptors.add(talkerDioLogger);

  /// Экземпляр [TalkerDioLogger] для логирования HTTP-запросов.
  @lazySingleton
  TalkerDioLogger get talkerDioLogger => TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
      );

  // ? ----------------------------- Storage ----------------------------- ? //
  /// Экземпляр [SharedPreferences] для работы с хранилищем данных.
  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();
  //.then((value) => value..clear());

  /// Экземпляр [FlutterSecureStorage] для работы с безопасным хранилищем данных
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );

  // ? ------------------------- DeviceInfoPlugin ------------------------ ? //
  /// Экземпляр [DeviceInfoPlugin] для генерации ID.
  @lazySingleton
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();
}
