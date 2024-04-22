import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/select_city/cubit/select_city_cubit.dart';

@RoutePage()
class CitiesPage extends StatelessWidget {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: t.cities.yourCity,
      ),
      body: BlocBuilder<SelectCityCubit, SelectCityState>(
        builder: (context, state) {
          return Column(
            children: [
              AppConst.kCommon16.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.cities.selectCity,
                    style: context.textStyle.headingTypo.h3
                        .withColor(context.colors.textColors.main),
                  ),
                  AppConst.kCommon12.height,
                  Text(
                    t.cities.description,
                    style: context.textStyle.textTypo.tx1Medium
                        .withColor(context.colors.textColors.secondary),
                  ),
                ],
              ).paddingAll(AppConst.kCommon16),
              Flexible(
                child: BlocBuilder<SelectCityCubit, SelectCityState>(
                  builder: (_, state) => state.when(
                    initial: SizedBox.shrink,
                    loading: () => Center(
                      heightFactor: AppConst.kCommon4,
                      child: Assets.lottie.loadCircle.lottie(
                        width: AppConst.kLoaderBig,
                        height: AppConst.kLoaderBig,
                      ),
                    ),
                    loaded: (cities) => ListView.separated(
                      itemCount: cities.length,
                      itemBuilder: (_, index) => ListTile(
                        title: Text(
                          cities[index].name,
                          style: context.textStyle.textTypo.tx1SemiBold
                              .withColor(context.colors.textColors.main),
                        ),
                        onTap: () {},
                      ),
                      separatorBuilder: (_, __) => Divider(
                        height: AppConst.kCommon2,
                        thickness: AppConst.kCommon1,
                        indent: AppConst.kCommon16,
                        endIndent: AppConst.kCommon16,
                        color: context.colors.otherColors.separator30,
                      ),
                    ),
                    error: () => ErrorRefreshWidget(
                      error: t.cities.errorLoad,
                      onRefresh: () =>
                          context.read<SelectCityCubit>().getCities(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
