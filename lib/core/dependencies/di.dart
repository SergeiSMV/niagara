import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/dependencies/di.config.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';

/// Глобальный экземпляр [GetIt] для доступа к зависимостям.
GetIt get getIt => GetIt.instance;

/// Инициализация зависимостей.
/// Вызывается в методе `main` перед запуском приложения.
@InjectableInit()
Future<void> setupDependencies() async {
  /// Инициализация [GetIt] и [Injectable] для работы с зависимостями.
  await getIt.init();

  /// Инициализация [TalkerBlocObserver] для логирования событий и состояний.
  Bloc.observer = getIt<TalkerBlocObserver>();
}
