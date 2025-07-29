import '../utils/gen/strings.g.dart';

/// Вспомогательный класс для валидации текста на кириллические символы
class CyrillicValidationHelper {
  /// Проверяет, что текст содержит только кириллические буквы, пробелы и дефисы
  ///
  /// [text] - текст для проверки
  /// Возвращает null если валидация прошла успешно, иначе сообщение об ошибке
  static String? validateCyrillicText(String text) {
    if (text.isEmpty) return null;

    // Регулярное выражение: кириллические буквы + пробелы + дефисы
    if (!RegExp(r'^[а-яёА-ЯЁ\s\-]+$').hasMatch(text)) {
      return t.profile.edit.validate_error;
    }

    return null;
  }
}
