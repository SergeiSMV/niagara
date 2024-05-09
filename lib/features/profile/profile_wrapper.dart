import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc.dart';

@RoutePage()
class ProfileWrapper implements AutoRouteWrapper {
  const ProfileWrapper();

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<BonusesBloc>()),
        ],
        child: const AutoRouter(),
      );
}
