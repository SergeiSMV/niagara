import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/location/presentation/bloc/bloc/address_selection_bloc.dart';

@RoutePage()
class LocationsWrapperPage extends AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AddressSelectionBloc>()),
      ],
      child: AutoRouter(
        navigatorObservers: () => [],
      ),
    );
  }
}
