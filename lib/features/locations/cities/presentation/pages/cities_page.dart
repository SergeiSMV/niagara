import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/locations/cities/presentation/cubit/cities_cubit.dart';
import 'package:niagara_app/features/locations/cities/presentation/widgets/cities_list_widget.dart';

@RoutePage()
class CitiesPage extends StatelessWidget {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<CitiesCubit>(),
        child: CustomScrollView(
          slivers: [
            const SliverAppBarWidget(),
            SliverPadding(
              padding: AppInsets.kHorizontal16,
              sliver: SliverAppBar(
                primary: false,
                automaticallyImplyLeading: false,
                centerTitle: false,
                pinned: true,
                toolbarHeight: 100,
                titleSpacing: 0,
                title: Text(
                  t.cities.selectCity,
                  style: context.textStyle.headingTypo.h3
                      .withColor(context.colors.textColors.main),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: Text(
                    t.cities.description,
                    style: context.textStyle.textTypo.tx1Medium
                        .withColor(context.colors.textColors.secondary),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  AppBoxes.kHeight24,
                  CitiesListWidget(),
                  AppBoxes.kHeight24,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
