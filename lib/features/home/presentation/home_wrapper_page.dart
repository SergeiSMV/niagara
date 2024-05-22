import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/promotions/presentation/cubit/promotions_cubit.dart';

@RoutePage()
class HomeWrapperPage extends AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AddressesBloc>()),
        BlocProvider(create: (_) => getIt<BonusesBloc>()),
        BlocProvider(create: (_) => getIt<PromotionsCubit>()),
      ],
      child: const AutoRouter(),
    );
  }
}
