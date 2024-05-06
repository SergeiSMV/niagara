import 'package:auto_route/auto_route.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/features/locations/cities/domain/use_cases/get_city_use_case.dart';

/// Гард для проверки выбранного города.
@injectable
class CityGuard extends AutoRouteGuard {
  CityGuard(this._getCityUseCase);

  final GetCityUseCase _getCityUseCase;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    // Проверка на наличие города
    final hasSetted = await _getCityUseCase.call().isRight;

    // Если имеется, то продолжаем
    if (hasSetted) {
      return resolver.next();
    } else {
      // Если не выбран, то переходим на страницу выбора города
      await resolver.redirect(
        const LocationsWrapper(children: [CitiesRoute()]),
      );
    }
  }
}
