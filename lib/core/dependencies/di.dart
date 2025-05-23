import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

/// Глобальный экземпляр [GetIt] для доступа к зависимостям.
GetIt get getIt => GetIt.instance;

/// Инициализация зависимостей.
/// Вызывается в методе `main` перед запуском приложения.
@InjectableInit()
Future<void> setupDependencies() async => getIt.init();
