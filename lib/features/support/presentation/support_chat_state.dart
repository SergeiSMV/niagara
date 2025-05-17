/// Состояние чата службы поддержки.
enum SupportChatState {
  /// До начала всех операций.
  notInitialized,

  /// Загрузка данных пользователя.
  loading,

  /// Контроллер инициализирован, данные загружены.
  initialized,

  /// Ошибка при загрузке данных.
  error;

  /// Готово для использования.
  bool get isReady => this == initialized;

  /// Ошибка при загрузке данных.
  bool get isError => this == error;
}
