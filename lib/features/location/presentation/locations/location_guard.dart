import 'package:auto_route/auto_route.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/features/auth/domain/usecases/check_auth_status.dart';
import 'package:niagara_app/features/location/domain/usecases/locations/has_locations_use_case.dart';

/// Гард для проверки наличия адреса доставки.
@injectable
class LocationGuard extends AutoRouteGuard {
  LocationGuard({
    required CheckAuthStatusUseCase checkAuthStatusUseCase,
    required HasLocationsUseCase hasLocationsUseCase,
  })  : _checkAuthStatusUseCase = checkAuthStatusUseCase,
        _hasLocationsUseCase = hasLocationsUseCase;

  final CheckAuthStatusUseCase _checkAuthStatusUseCase;
  final HasLocationsUseCase _hasLocationsUseCase;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    // Проверка на авторизацию
    final hasAuth = await _checkAuthStatusUseCase
        .call()
        .fold((_) => false, (authState) => authState.hasAuth);

    // Если авторизован, то...
    if (hasAuth) {
      // ... проверяем на наличие хотя бы одного адреса доставки
      final hasLocations = await _hasLocationsUseCase.call().isRight;

      // Если адреса есть, то продолжаем
      if (hasLocations) {
        resolver.next();
      } else {
        // Если отсутствует, то переходим на страницу поиска адреса
        await resolver.redirect(
          const AddingAddressWrapperRoute(
            children: [ChoiceOnMapRoute()],
          ),
        );
      }
    }
  }
}
