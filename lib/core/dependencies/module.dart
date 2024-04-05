// ignore_for_file: invalid_annotation_target

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
          printStateFullData: false,
        ),
      );

  // ? ------------------------------- Dio ------------------------------- ? //
  /// Экземпляр [Dio] для работы с HTTP-запросами.
  @lazySingleton
  Dio get dio => Dio(baseOptions)
    ..interceptors.add(talkerDioLogger)
    ..interceptors.add(exceptionWrapper);

  /// Базовый URL для API.
  @Named(ApiConst.kBaseUrl)
  String provideBaseUrl() =>
      dotenv.get(ApiConst.kBaseUrl, fallback: 'NO_CONFIGURATION');

  /// Экземпляр [BaseOptions] для настройки HTTP-запросов.
  @lazySingleton
  BaseOptions get baseOptions => BaseOptions(
        baseUrl: provideBaseUrl(),
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': _basicAuth,
        },
      );

  /// Экземпляр [TalkerDioLogger] для логирования HTTP-запросов.
  @lazySingleton
  TalkerDioLogger get talkerDioLogger => TalkerDioLogger(talker: talker);

  /// Экземпляр [InterceptorsWrapper] для обработки ошибок HTTP-запросов
  /// и повтора запроса при необходимости.
  @lazySingleton
  InterceptorsWrapper get exceptionWrapper => InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          talker.handle(e, e.stackTrace);
          return handler.next(e);
        },
      );

  /// Логин для авторизации.
  @Named('login')
  String get _login => dotenv.get(ApiConst.kLogin, fallback: 'NO_LOGIN');

  /// Пароль для авторизации.
  @Named('password')
  String get _password =>
      dotenv.get(ApiConst.kPassword, fallback: 'NO_PASSWORD');

  /// Строка авторизации.
  @Named('basicAuth')
  String get _basicAuth => 'Basic ${base64Encode(
        utf8.encode('$_login:$_password'),
      )}';

  // ? ----------------------------- Storage ----------------------------- ? //
  /// Экземпляр [SharedPreferences] для работы с хранилищем данных.
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  // ..then((value) => value.clear());

  /// Экземпляр [FlutterSecureStorage] для работы с безопасным хранилищем данных
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );

  // ? ------------------------------- Uuid ------------------------------ ? //
  /// Экземпляр [Uuid] для генерации UUID.
  @lazySingleton
  Uuid get uuid => const Uuid();
}
