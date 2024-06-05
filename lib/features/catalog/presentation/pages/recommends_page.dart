import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_widget.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

@RoutePage()
class RecommendsPage extends StatelessWidget {
  const RecommendsPage({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(automaticallyImplyTitle: false),
          SliverToBoxAdapter(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSizes.kGeneral8,
                crossAxisSpacing: AppSizes.kGeneral8,
                childAspectRatio:
                    context.screenWidth / context.screenHeight / .8,
              ),
              padding: AppInsets.kHorizontal16 + AppInsets.kVertical12,
              itemCount: products.length,
              itemBuilder: (_, index) =>
                  ProductWidget(product: products[index]),
            ),
          ),
        ],
      ),
    );
  }
}
