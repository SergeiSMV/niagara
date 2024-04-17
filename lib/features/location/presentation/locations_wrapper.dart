import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/location/presentation/address_selection/cubit/address_selection_cubit.dart';
import 'package:niagara_app/features/location/presentation/search_address/bloc/search_address_bloc.dart';

@RoutePage()
class LocationsWrapperPage extends AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AddressSelectionCubit>()),
        BlocProvider(create: (_) => getIt<SearchAddressBloc>()),
      ],
      child: const AutoRouter(),
    );
  }
}
