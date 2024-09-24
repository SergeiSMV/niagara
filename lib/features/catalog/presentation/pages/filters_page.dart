import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/catalog/domain/model/filter.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/filters_cubit/filters_cubit.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:niagara_app/features/catalog/presentation/widget/category/show_filtered_catalog_button.dart';
import 'package:niagara_app/features/locations/cities/presentation/widgets/list_separator_widget.dart';

@RoutePage()
class FiltersPage extends StatelessWidget {
  const FiltersPage({super.key});

  void _onToggleFilter(BuildContext context, FilterProperty property) {
    // Меняем состояние фильтра
    context.read<FiltersCubit>().onToggleFilter(property);

    // Получаем выбранные фильтры
    final selectFilters = context.read<FiltersCubit>().state.maybeWhen(
          loaded: (_, selectedFilters) => selectedFilters,
          orElse: () => <FilterProperty>[],
        );

    // Перезагружаем список товаров с учетом выбранных фильтров
    context.read<ProductsBloc>().add(
          ProductsEvent.loading(
            isForceUpdate: true,
            filters: selectFilters,
          ),
        );
  }

  void _onClearFilters(BuildContext context) => context
    ..read<FiltersCubit>().onClearFilters()
    ..read<ProductsBloc>().add(
      const ProductsEvent.loading(
        isForceUpdate: true,
        filters: [],
      ),
    );

  @override
  Widget build(BuildContext context) {
    final filters = context.select<FiltersCubit, List<Filter>>(
      (cubit) => cubit.state.maybeWhen(
        loaded: (filters, _) => filters,
        orElse: () => const [],
      ),
    );

    final selectedFilters = context.select<FiltersCubit, List<FilterProperty>>(
      (cubit) => cubit.state.maybeWhen(
        loaded: (_, selectedFilters) => selectedFilters,
        orElse: () => const [],
      ),
    );

    final hasSelectedFilters = selectedFilters.isNotEmpty;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(
            actions: [
              InkWell(
                onTap: () =>
                    hasSelectedFilters ? _onClearFilters(context) : null,
                child: Text(
                  t.common.clear,
                  style: context.textStyle.textTypo.tx2Medium.withColor(
                    hasSelectedFilters
                        ? context.colors.textColors.accent
                        : context.colors.textColors.secondary,
                  ),
                ),
              ),
              AppBoxes.kWidth12,
            ],
          ),
          SliverToBoxAdapter(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: filters.length,
              itemBuilder: (_, index) => Container(
                padding: AppInsets.kAll16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      filters[index].name,
                      style: context.textStyle.textTypo.tx1SemiBold
                          .withColor(context.colors.textColors.main),
                    ),
                    AppBoxes.kHeight12,
                    Wrap(
                      spacing: AppSizes.kGeneral12,
                      runSpacing: AppSizes.kGeneral12,
                      children: filters[index].properties.map(
                        (filter) {
                          final isSelected = selectedFilters.contains(filter);
                          return InkWell(
                            onTap: () => _onToggleFilter(context, filter),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: AppBorders.kCircular6,
                                color: isSelected
                                    ? context.colors.buttonColors.primary
                                    : context.colors.mainColors.bgCard,
                              ),
                              child: Padding(
                                padding: AppInsets.kHorizontal12 +
                                    AppInsets.kVertical8,
                                child: Text(
                                  filter.name,
                                  style: context.textStyle.textTypo.tx2Medium
                                      .withColor(
                                    isSelected
                                        ? context.colors.textColors.white
                                        : context.colors.textColors.main,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (_, __) => const ListSeparatorWidget(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ShowFilteredCatalogButton(),
    );
  }
}
