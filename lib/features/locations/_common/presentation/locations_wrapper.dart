import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/validate_phone_cubit/validate_phone_cubit.dart';
import 'package:niagara_app/features/locations/_common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';
import 'package:niagara_app/features/locations/shops/presentation/bloc/shops_bloc.dart';

@RoutePage()
class LocationsWrapper implements AutoRouteWrapper {
  const LocationsWrapper();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<AddressesBloc>()),
        BlocProvider(create: (_) => getIt<MapCubit>()),
        BlocProvider(create: (_) => getIt<ShopsBloc>()),
        BlocProvider(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<ValidatePhoneCubit>()),
      ],
      child: const AutoRouter(),
    );
  }
}
