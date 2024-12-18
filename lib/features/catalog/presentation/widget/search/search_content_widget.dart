import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/product_widget.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/catalog_search_bloc/catalog_search_bloc.dart';
import 'package:niagara_app/features/catalog/presentation/widget/search/search_empty_content_widget.dart';

class SearchContentWidget extends StatelessWidget {
  const SearchContentWidget({super.key});

  void _onRefresh(BuildContext context) => context
      .read<CatalogSearchBloc>()
      .add(const CatalogSearchEvent.search(text: '', isForceUpdate: true));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical12,
      child: BlocBuilder<CatalogSearchBloc, CatalogSearchState>(
        buildWhen: (previous, current) => previous != current,
        builder: (ctx, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: AppCenterLoader.new,
          loaded: (products, _) {
            final hasMore = ctx.read<CatalogSearchBloc>().hasMore;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (products.isNotEmpty)
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    mainAxisSpacing: AppSizes.kGeneral8,
                    crossAxisSpacing: AppSizes.kGeneral8,
                    childAspectRatio:
                        context.screenWidth / context.screenHeight / .85,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      products.length,
                      (index) => ProductWidget(product: products[index]),
                    ),
                  )
                else
                  const SearchEmptyContentWidget(),
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
            );
          },
          error: () => ErrorRefreshWidget(onRefresh: () => _onRefresh(context)),
        ),
      ),
    );
  }
}
