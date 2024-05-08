extension StringExtension on String {
  String spaceSeparateNumbers() {
    final result = replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]} ',
    );
    return result;
  }

  String formatCardNumber() {
    // Удаляем все символы, кроме цифр
    final digitsOnly = replaceAll(RegExp(r'\D+'), '');

    // Разбиваем строку на блоки по 4 цифры
    final blocks = <String>[];
    for (var i = 0; i < digitsOnly.length; i += 4) {
      var endIndex = i + 4;
      if (endIndex > digitsOnly.length) {
        endIndex = digitsOnly.length;
      }
      final block = digitsOnly.substring(i, endIndex);
      blocks.add(block);
    }

    // Соединяем блоки с пробелами между ними
    final formatted = blocks.join(' ');

    return formatted;
  }

  String capitalizeFirst() {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
