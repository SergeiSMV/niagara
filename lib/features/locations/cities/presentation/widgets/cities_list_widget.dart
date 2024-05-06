import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';
import 'package:niagara_app/features/locations/cities/domain/models/city.dart';
import 'package:niagara_app/features/locations/cities/presentation/cubit/cities_cubit.dart';
import 'package:niagara_app/features/locations/cities/presentation/widgets/list_separator_widget.dart';

class CitiesListWidget extends StatelessWidget {
  const CitiesListWidget({super.key});

  void _onSelectCity(BuildContext context, {required City city}) =>
      context.read<CitiesCubit>().selectCity(city);

  void _navigateToMain(BuildContext context) => context
    ..replaceRoute(const NavigationRoute())
    ..read<AddressesBloc>().add(const AddressesEvent.initial());

  void _onRefresh(BuildContext context) =>
      context.read<CitiesCubit>().getCities();

  Widget get _loader => const AppCenterLoader();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocConsumer<CitiesCubit, CitiesState>(
        listener: (context, state) => state.maybeWhen(
          selected: (_) => _navigateToMain(context),
          orElse: () => null,
        ),
        builder: (_, state) => state.when(
          initial: SizedBox.shrink,
          loading: () => _loader,
          loaded: (cities) => ListView.separated(
            itemCount: cities.length,
            itemBuilder: (_, index) {
              final city = cities[index];
              return ListTile(
                title: Text(
                  city.name,
                  style: context.textStyle.textTypo.tx1SemiBold
                      .withColor(context.colors.textColors.main),
                ),
                onTap: () => _onSelectCity(context, city: city),
              );
            },
            separatorBuilder: (_, __) => const ListSeparatorWidget(),
          ),
          selected: (_) => _loader,
          error: () => ErrorRefreshWidget(
            error: t.cities.errorLoad,
            onRefresh: () => _onRefresh(context),
          ),
        ),
      ),
    );
  }
}
