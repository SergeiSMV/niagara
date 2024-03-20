import 'dart:ui';

/// Основные цвета приложения, используемые в макетах
abstract class MainColors {
  /// Конструктор для основных цветов
  const MainColors({
    required this.primary,
    required this.accent,
    required this.light,
    required this.bgCard,
    required this.white,
  });

  /// Основной цвет
  final Color primary;

  /// Акцентный цвет
  final Color accent;

  /// Светлый цвет
  final Color light;

  /// Цвет под основы карточек / альтернатива белого бэка
  final Color bgCard;

  /// Основной цвет бэка / основа карточек
  final Color white;
}
