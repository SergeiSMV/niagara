import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/product_widget.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/catalog/domain/model/filter.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/filters_cubit/filters_cubit.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:niagara_app/features/catalog/presentation/widget/category/interaction_category_widget.dart';
import 'package:niagara_app/features/catalog/presentation/widget/groups/groups_buttons_widget.dart';
import 'package:niagara_app/features/catalog/presentation/widget/search/catalog_search_button_widget.dart';

@RoutePage()
class CategoryPage extends HookWidget {
  const CategoryPage({super.key});

  Future<void> _onLoadMore(BuildContext context) async {
    final selectFilters = context.read<FiltersCubit>().state.maybeWhen(
          loaded: (_, selectedFilters) => selectedFilters,
          orElse: () => <FilterProperty>[],
        );
    context
        .read<ProductsBloc>()
        .add(ProductsEvent.loadMore(filters: selectFilters));
  }

  /// Возвращает соотношение сторон для [GridView].
  double _getAspectRatio(BuildContext context) {
    return ((context.screenWidth - AppSizes.kGeneral8) / AppConstants.kCrossAxis2) / 
    (context.screenWidth - AppConstants.kHeightCorrector50);
  }

  @override
  Widget build(BuildContext context) {
    final group = context.watch<ProductsBloc>().group;
    final scrollController = useScrollController();

    useEffect(
      () {
        void onScroll() {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            _onLoadMore(context);
          }
        }

        scrollController.addListener(onScroll);
        return () => scrollController.removeListener(onScroll);
      },
      [scrollController],
    );

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBarWidget(
            title: group.name,
            actions: const [
              CatalogSearchButtonWidget(),
            ],
          ),
          if (!group.temporary)
            SliverAppBar(
              automaticallyImplyLeading: false,
              primary: false,
              expandedHeight: 30,
              titleSpacing: 0,
              title: GroupsButtonsWidget(group: group),
            ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            primary: false,
            pinned: true,
            expandedHeight: 30,
            titleSpacing: 0,
            title: InteractionCategoryWidget(group: group),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<ProductsBloc, ProductsState>(
              buildWhen: (previous, current) => previous != current,
              builder: (ctx, state) => state.maybeWhen(
                loading: AppCenterLoader.new,
                loaded: (products, _) {
                  final hasMore = ctx.read<ProductsBloc>().hasMore;
                  return Padding(
                    padding: AppInsets.kHorizontal16 + AppInsets.kVertical12,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GridView.count(
                          crossAxisCount: AppConstants.kCrossAxis2,
                          shrinkWrap: true,
                          mainAxisSpacing: AppSizes.kGeneral8,
                          crossAxisSpacing: AppSizes.kGeneral8,
                          childAspectRatio: _getAspectRatio(context),
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                            products.length,
                            (index) => ProductWidget(
                              product: products[index],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: hasMore,
                          child: Padding(
                            padding: AppInsets.kAll16,
                            child: Center(
                              child: Assets.lottie.loadCircle.lottie(
                                width: AppSizes.kLoaderBig,
                                height: AppSizes.kLoaderBig,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                orElse: () => const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
