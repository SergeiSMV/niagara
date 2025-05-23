/// Статус авторизации пользователя
enum AuthenticatedStatus {
  /// Неизвестный статус.
  unknown,

  /// Неавторизованный пользователь.
  unauthenticated,

  /// Авторизованный пользователь.
  authenticated;

  /// Проверяет, авторизован ли пользователь.
  bool get hasAuth => this == authenticated;

  /// Проверяет, неизвестный ли статус.
  bool get isUnknown => this == unknown;
}
