import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
class CategoryPage extends StatelessWidget {
  const CategoryPage({
    super.key,
    required this.group,
  });

  final Group group;

  Future<void> _onLoadMore(BuildContext context) async =>
      context.read<ProductsBloc>().add(const ProductsEvent.loadMore());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: group.name),
      body: Column(
        children: [
          GroupsButtonsWidget(group: group),
          Expanded(
            child: BlocProvider(
              key: Key(group.id),
              create: (_) => getIt<ProductsBloc>(param1: group),
              child: Column(
                children: [
                  const InteractionCategoryWidget(),
                  BlocBuilder<ProductsBloc, ProductsState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (ctx, state) => state.maybeWhen(
                      loading: AppCenterLoader.new,
                      loaded: (products) {
                        final hasMore = ctx.read<ProductsBloc>().hasMore;
                        return Expanded(
                          child: NotificationListener(
                            onNotification: (scrollInfo) {
                              if (scrollInfo is ScrollNotification &&
                                  scrollInfo.metrics.pixels >=
                                      scrollInfo.metrics.maxScrollExtent / 3) {
                                _onLoadMore(ctx);
                              }
                              return true;
                            },
                            child: Padding(
                              padding: AppInsets.kHorizontal16 +
                                  AppInsets.kVertical12,
                              child: CustomScrollView(
                                slivers: [
                                  SliverGrid.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: AppSizes.kGeneral8,
                                      crossAxisSpacing: AppSizes.kGeneral8,
                                      childAspectRatio: context.screenWidth /
                                          context.screenHeight /
                                          .8,
                                    ),
                                    itemCount: products.length,
                                    itemBuilder: (_, index) => ProductWidget(
                                      product: products[index],
                                    ),
                                  ),
                                  SliverToBoxAdapter(
                                    child: hasMore
                                        ? Padding(
                                            padding: AppInsets.kAll16,
                                            child: Center(
                                              child: Assets.lottie.loadCircle
                                                  .lottie(
                                                width: AppSizes.kLoaderBig,
                                                height: AppSizes.kLoaderBig,
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      orElse: () => const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
