/// Константы для API
abstract final class ApiConst {
  // ? ----------------------------- General ----------------------------- ? //
  static const String kBaseUrl = 'API_HOST';

  static const String kLogin = 'API_LOGIN';

  static const String kPassword = 'API_PASSWORD';

  static const String kYandexGeo = 'YANDEX_GEO';

  // ? ------------------------------ Token ------------------------------ ? //
  /// -POST- Запрос на получение токена
  static const String kGetToken = '/get_token_session';

  /// -GET- Запрос на проверку токена
  static const String kCheckToken = '/check_token_session';

  // ? ------------------------------ Auth ------------------------------- ? //
  /// -POST- Запрос на создание кода для авторизации
  static const String kCreateCode = '/code_confirm_create';

  /// -POST- Запрос на проверку кода для авторизации
  static const String kConfirmCode = '/code_confirm_check';

  // ? ----------------------------- Location ----------------------------- ? //
  /// -GET- Запрос на получение списка городов
  static const String kGetCities = '/region';

  /// -GET- Запрос на получение списка локаций
  static const String kGetLocations = '/location';

  // ? ------------------------------- User ------------------------------- ? //
  /// -GET- Запрос на получение профиля
  static const String kGetProfile = '/users';

  /// -PUT- Запрос на обновление профиля
  static const String kUpdateProfile = '/users';
}
