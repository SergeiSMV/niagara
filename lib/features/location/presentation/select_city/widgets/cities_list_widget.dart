import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';
import 'package:niagara_app/features/location/presentation/select_city/cubit/select_city_cubit.dart';
import 'package:niagara_app/features/location/presentation/select_city/widgets/list_separator_widget.dart';

class CitiesListWidget extends StatelessWidget {
  const CitiesListWidget({super.key});

  void _onSelectCity(BuildContext context, {required City city}) {
    context.read<SelectCityCubit>().selectCity(city);
  }

  void _onNavigateToNavigation(BuildContext context) {
    context.router.replace(const NavigationRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocConsumer<SelectCityCubit, SelectCityState>(
        listener: (context, state) => state.maybeWhen(
          selected: (_) => _onNavigateToNavigation(context),
          orElse: () => null,
        ),
        builder: (_, state) => state.maybeWhen(
          loading: () => Center(
            heightFactor: AppConst.kCommon4,
            child: Assets.lottie.loadCircle.lottie(
              width: AppConst.kLoaderBig,
              height: AppConst.kLoaderBig,
            ),
          ),
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
          orElse: () => ErrorRefreshWidget(
            error: t.cities.errorLoad,
            onRefresh: () => context.read<SelectCityCubit>().getCities(),
          ),
        ),
      ),
    );
  }
}
