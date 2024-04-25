import 'package:auto_route/auto_route.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/features/location/domain/usecases/cities/get_city_use_case.dart';

/// Гард для проверки наличия основного местоположения.
@injectable
class LocationGuard extends AutoRouteGuard {
  LocationGuard({
    required GetCityUseCase getCityUseCase,
  }) : _getCityUseCase = getCityUseCase;

  final GetCityUseCase _getCityUseCase;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    // Проверка на наличие основного местоположения
    final hasPrimary = await _getCityUseCase.call().isRight;

    // Если имеется, то продолжаем
    if (hasPrimary) {
      resolver.next();
    } else {
      // Если не авторизован, то переходим на страницу выбора города
      await resolver.redirect(const CitiesRoute());
    }
  }
}
