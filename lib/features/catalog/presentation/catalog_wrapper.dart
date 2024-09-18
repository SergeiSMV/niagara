import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/bloc/prepaid_water_buying_cubit.dart/water_balance_buying_cubit.dart';

@RoutePage()
class CatalogWrapper implements AutoRouteWrapper {
  const CatalogWrapper();

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => OrderWaterAmountCubit()),
        ],
        child: const AutoRouter(),
      );
}
