[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

# Niagara App
Новая реализация приложения продажи и доставки питьевой воды Niagara

## Установка

### Получение pub&pods
- `sh gpub.sh`

### Запуск build runner
- `sh grun.sh`

### Генерация assets
- впервые
1) `brew install FlutterGen/tap/fluttergen` (works with macOS and Linux)
2) `dart pub global activate flutter_gen` (works with macOS, Linux and Windows)
3) `flutter pub get`
- впоследствии
4) `dart run build_runner build`
5) `fluttergen`

### Генерация локализации
- `dart run slang`

### Генерация всех необходимых файлов
- `sh all_gen.sh`

# Сборка
## Сборка для iOS
- `sh build_ios.sh`

## Сборка с возможностью открытия страницы с логами (на примере Android)

Использовать для сборки файл `main_dev.dart`:

- `flutter build apk --dart-define-from-file=.env --release -t lib/main_dev.dart`

## Зависимости:
- Локатор зависимостей: [get_it](https://pub.dev/packages/get_it)
  - Зависимости: [injectable](https://pub.dev/packages/injectable)
  - Генератор: [injectable_generator](https://pub.dev/packages/injectable_generator)
- Навигация: [auto_router](https://pub.dev/packages/auto_router)
  - Генерация: [auto_route_generator](https://pub.dev/packages/auto_route_generator)
- Работа с HTTP: [dio](https://pub.dev/packages/dio)
- Интернационализация: [intl](https://pub.dev/packages/intl)
  - Локализация: [slang](https://pub.dev/packages/slang)
  - Обертка для работы: [slang_flutter](https://pub.dev/packages/slang_flutter)
  - Генератор: [slang_build_runner](https://pub.dev/packages/slang_build_runner)
- State-менеджер: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
  - Управление событиями: [bloc_concurrency](https://pub.dev/packages/bloc_concurrency)
- Генерация кода: [freezed](https://pub.dev/packages/freezed)
  - Аннотации: [freezed_annotation](https://pub.dev/packages/freezed_annotation)
- Аннотации JSON: [json_annotation](https://pub.dev/packages/json_annotation)
  - Генерация: [json_serializable](https://pub.dev/packages/json_serializable)
- Сравнение классов: [equatable](https://pub.dev/packages/equatable)
- Хуки (react): [flutter_hooks](https://pub.dev/packages/flutter_hooks)
- Логи:
  - Для flutter: [talker_flutter](https://pub.dev/packages/talker_flutter)
  - Для bloc: [talker_bloc_logger](https://pub.dev/packages/talker_bloc_logger)
  - Для dio: [talker_dio_logger](https://pub.dev/packages/talker_dio_logger)
- Анализатор: [flutter_lints](https://pub.dev/packages/flutter_lints)
- Сетевые изображения: [cached_network_image](https://pub.dev/packages/cached_network_image)
- SVG-изображения: [flutter_svg](https://pub.dev/packages/flutter_svg)
- Build-генератор: [build_runner](https://pub.dev/packages/build_runner)
- Генерация assets: [flutter_gen](https://pub.dev/packages/flutter_gen)
- Переменные окружения: [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
- Функциональное программирование: [either_dart](https://pub.dev/packages/either_dart)
- База данных:
  - Shared preferences: [shared_preferences](https://pub.dev/packages/shared_preferences)
  - Шифрование: [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
- Файловая система: [path_provider](https://pub.dev/packages/path_provider)
- Ввод OTP: [pinput](https://pub.dev/packages/pinput)
- Мок-данные: [mockito](https://pub.dev/packages/mockito)
- Формы ввода: [mask_text_input_formatter](https://pub.dev/packages/mask_text_input_formatter)
- Анимация Lottie: [lottie](https://pub.dev/packages/lottie)
- ID устройства: [device_info_plus](https://pub.dev/packages/device_info_plus) 
- Карты: [yandex_mapkit_lite](https://pub.dev/packages/yandex_mapkit_lite) 
- Геолокация [geolocator](https://pub.dev/packages/geolocator) 

