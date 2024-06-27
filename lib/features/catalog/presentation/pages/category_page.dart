import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_widget.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:niagara_app/features/catalog/presentation/widget/category/interaction_category_widget.dart';
import 'package:niagara_app/features/catalog/presentation/widget/groups/groups_buttons_widget.dart';

@RoutePage()
class CategoryPage extends HookWidget implements AutoRouteWrapper {
  const CategoryPage({
    super.key,
    required this.group,
  });

  final Group group;

  Future<void> _onLoadMore(BuildContext context) async =>
      context.read<ProductsBloc>().add(const ProductsEvent.loadMore());

  @override
  Widget build(BuildContext context) {
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
          SliverAppBarWidget(title: group.name),
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
                loaded: (products) {
                  final hasMore = ctx.read<ProductsBloc>().hasMore;
                  return Padding(
                    padding: AppInsets.kHorizontal16 + AppInsets.kVertical12,
                    child: Column(
                      children: [
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          mainAxisSpacing: AppSizes.kGeneral8,
                          crossAxisSpacing: AppSizes.kGeneral8,
                          childAspectRatio:
                              context.screenWidth / context.screenHeight / .8,
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

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      key: Key(group.id),
      create: (_) => getIt<ProductsBloc>(param1: group),
      child: this,
    );
  }
}
