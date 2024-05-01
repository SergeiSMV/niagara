import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/location/presentation/locations/bloc/locations_bloc.dart';
import 'package:niagara_app/features/location/presentation/shops/bloc/shops_bloc.dart';

@RoutePage()
class LocationsWrapperPage implements AutoRouteWrapper {
  const LocationsWrapperPage();

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<MapCubit>()),
          BlocProvider(create: (_) => getIt<ShopsBloc>()),
          BlocProvider.value(value: getIt<LocationsBloc>()),
        ],
        child: const AutoRouter(),
      );
}
