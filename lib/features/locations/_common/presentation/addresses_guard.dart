import 'package:auto_route/auto_route.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/features/authorization/phone_auth/domain/use_cases/auth/check_auth_status_use_case.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/has_addresses_use_case.dart';

/// Гард для проверки наличия адреса доставки.
@injectable
class AddressesGuard extends AutoRouteGuard {
  AddressesGuard(
    this._checkAuthStatus,
    this._hasAddresses,
  );

  final CheckAuthStatusUseCase _checkAuthStatus;
  final HasAddressesUseCase _hasAddresses;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    // Проверка на авторизацию
    final hasAuth = await _checkAuthStatus
        .call()
        .fold((_) => false, (authState) => authState.hasAuth);

    // Если не авторизован, то продолжаем без проверки на адреса
    if (!hasAuth) return resolver.next();

    // Иначе проверяем на наличие хотя бы одного адреса доставки
    final hasLocations = await _hasAddresses.call().isRight;

    // Если адреса есть, то продолжаем
    if (hasLocations) {
      return resolver.next();
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
