/// Константы для API
abstract final class ApiConst {
  // ? ----------------------------- General ----------------------------- ? //
  /// Базовый URL
  static const String kBaseUrl = 'API_HOST';

  /// Логин для авторизации
  static const String kLogin = 'API_LOGIN';

  /// Пароль для авторизации
  static const String kPassword = 'API_PASSWORD';

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
}
