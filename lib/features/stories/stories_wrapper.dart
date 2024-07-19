import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/stories/presentation/bloc/stories_bloc.dart';

@RoutePage()
class StoriesWrapper implements AutoRouteWrapper {
  const StoriesWrapper();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<StoriesBloc>(),
      child: const AutoRouter(),
    );
  }
}
