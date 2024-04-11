part of '../core.dart';

@module
abstract class AppModule {
  // ? ------------------------------ Talker ----------------------------- ? //

  @lazySingleton
  Talker get talker => TalkerFlutter.init();

  @lazySingleton
  TalkerBlocObserver get talkerBlocObserver => TalkerBlocObserver(
        talker: talker,
        settings: const TalkerBlocLoggerSettings(
          printChanges: true,
          printCreations: true,
          printClosings: true,
        ),
      );

  @lazySingleton
  TalkerDioLogger get talkerDioLogger => TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
      );

  // ? ------------------------------- Dio ------------------------------- ? //

  @Named(ApiConst.kBaseUrl)
  String get baseUrl => const String.fromEnvironment(ApiConst.kBaseUrl);

  @Named(ApiConst.kLogin)
  String get basicLogin => const String.fromEnvironment(ApiConst.kLogin);

  @Named(ApiConst.kPassword)
  String get basicPassword => const String.fromEnvironment(ApiConst.kPassword);

  @lazySingleton
  Dio dio(
    @Named(ApiConst.kBaseUrl) String url,
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

  // ? ----------------------------- Storage ----------------------------- ? //

  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();
  //.then((value) => value..clear());

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );

  // ? ------------------------- DeviceInfoPlugin ------------------------ ? //

  @lazySingleton
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();
}
