/// Константы для API
abstract final class ApiConst {
  // ? ----------------------------- General ----------------------------- ? //
  /// Базовый URL
  static const String kBaseUrl = 'API_HOST';

  /// Логин для авторизации
  static const String kLogin = 'API_LOGIN';

  /// Пароль для авторизации
  static const String kPassword = 'API_PASSWORD';

  // ? ------------------------------- Keys ------------------------------ ? //
  /// Ключ для токена
  static const String kToken = 'TOKEN_KEY';

  /// Ключ для идентификатора устройства
  static const String kDeviceId = 'DEVICE_ID_KEY';

  // ? ------------------------------ Token ------------------------------ ? //
  /// -POST- Запрос на получение токена
  static const String kGetToken = '/token_session';

  /// -GET- Запрос на проверку токена
  static const String kCheckToken = '/token_session';
}
