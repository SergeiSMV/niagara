import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/location/presentation/adding_address/choice_on_map/cubit/choice_on_map_cubit.dart';
import 'package:niagara_app/features/location/presentation/adding_address/search_address/bloc/search_address_bloc.dart';

@RoutePage()
class AddingAddressWrapperPage extends StatelessWidget
    implements AutoRouteWrapper {
  const AddingAddressWrapperPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<MapCubit>()),
          BlocProvider(create: (_) => getIt<ChoiceOnMapCubit>()),
          BlocProvider(create: (_) => getIt<SearchAddressBloc>()),
        ],
        child: this,
      );

  @override
  Widget build(BuildContext context) => const AutoRouter();
}
