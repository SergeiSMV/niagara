import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/select_city/cubit/select_city_cubit.dart';
import 'package:niagara_app/features/location/presentation/select_city/widgets/cities_list_widget.dart';
import 'package:niagara_app/features/location/presentation/select_city/widgets/select_city_header_widget.dart';

@RoutePage()
class CitiesPage extends StatelessWidget {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: t.cities.yourCity,
      ),
      body: BlocProvider(
        create: (_) => getIt<SelectCityCubit>()..getCities(),
        child: BlocBuilder<SelectCityCubit, SelectCityState>(
          builder: (_, state) {
            return Column(
              children: [
                AppConst.kCommon16.height,
                const SelectCityHeaderWidget(),
                const CitiesListWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
