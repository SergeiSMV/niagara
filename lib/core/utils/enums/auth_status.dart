/// Статус авторизации пользователя
enum AuthenticatedStatus {
  unknown,

  unauthenticated,

  authenticated;

  bool get hasAuth => this == authenticated;
}
