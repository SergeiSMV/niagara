import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

void main() {
  group('i18n', () {
    test('Should compile', () {
      // Проверка, что файлы локализации скомпилировались без ошибок
      expect(AppLocale.en.build().routes.home, 'Home');
    });

    test('All locales should be supported by Flutter', () {
      // Проверка, что все локали поддерживаются Flutter
      for (final locale in AppLocale.values) {
        expect(kMaterialSupportedLanguages, contains(locale.languageCode));
      }
    });
  });
}
