import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/location/presentation/cubit/address_selection_cubit.dart';

@RoutePage()
class LocationsWrapperPage extends AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final mapCubit = getIt<AddressSelectionCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => mapCubit),
      ],
      child: AutoRouter(
        navigatorObservers: () => [],
      ),
    );
  }
}
