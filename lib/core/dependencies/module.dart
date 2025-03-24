part of '../core.dart';

@module
abstract class AppModule {
  @lazySingleton
  Talker get talker => TalkerFlutter.init(
        observer: const CrashlyticsTalkerObserver(),
      );

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
        ),
      );

  @Named(ApiConst.kBaseUrl)
  String get baseUrl => const String.fromEnvironment(ApiConst.kBaseUrl);

  @Named(ApiConst.kLogin)
  String get basicLogin => const String.fromEnvironment(ApiConst.kLogin);

  @Named(ApiConst.kPassword)
  String get basicPassword => const String.fromEnvironment(ApiConst.kPassword);

  @Named(ApiConst.kYandexGeo)
  String get yandexGeoKey => const String.fromEnvironment(ApiConst.kYandexGeo);

  @Named(ApiConst.uxcamAppKey)
  String get uxcamAppKey => const String.fromEnvironment(ApiConst.uxcamAppKey);

  @lazySingleton
  Dio dio(
    @Named(ApiConst.kBaseUrl) String url,
    ErrorInterceptor errorInterceptor,
    AuthInterceptor authInterceptor,
  ) =>
      Dio(
        BaseOptions(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 360), // было 30
          receiveTimeout: const Duration(seconds: 360), // было 60
          contentType: Headers.jsonContentType,
        ),
      )
        ..interceptors.add(errorInterceptor)
        ..interceptors.add(authInterceptor)
        ..interceptors.add(talkerDioLogger);

  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );

  @lazySingleton
  YandexGeocoder yandexGeocoder(
    @Named(ApiConst.kYandexGeo) String yandexGeoKey,
  ) =>
      YandexGeocoder(apiKey: yandexGeoKey);

  @lazySingleton
  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker();

  @lazySingleton
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  @lazySingleton
  Stream<AuthenticatedStatus> get authStatusStream =>
      getIt<IAuthRepository>().authStatusStream;
}
