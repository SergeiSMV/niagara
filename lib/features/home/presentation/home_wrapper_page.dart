import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/dependencies/di.dart';
import '../../locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';
import '../../prepaid_water/presentation/bloc/balance_cubit/water_balance_cubit.dart';
import '../../profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'cubit/banners_cubit.dart';

/// Обёртка для главной страницы
@RoutePage()
class HomeWrapperPage extends AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<AddressesBloc>()),
          BlocProvider(create: (_) => getIt<BonusesBloc>()),
          BlocProvider(create: (_) => getIt<WaterBalanceCubit>()),
          BlocProvider(create: (_) => getIt<BannersCubit>()),
        ],
        child: const AutoRouter(),
      );
}
