import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_widget.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/new_products/presentation/bloc/new_products_bloc.dart';

class NewProductsHomeWidget extends StatelessWidget {
  const NewProductsHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Специально для Вас'),
        BlocBuilder<NewProductsBloc, NewProductsState>(
          builder: (context, state) {
            return state.map(
              loading: (_) => Center(
                child: Padding(
                  padding: AppInsets.kVertical64 + AppInsets.kVertical2,
                  child: Assets.lottie.loadCircle.lottie(
                    width: AppSizes.kGeneral64,
                    height: AppSizes.kGeneral64,
                    repeat: true,
                  ),
                ),
              ),
              loaded: (state) {
                final List<Product> products = state.products;
                final List<Widget> children = products
                    .map(
                      (product) => ProductWidget(product: product),
                    )
                    .toList();
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => AspectRatio(
                      aspectRatio: .5,
                      child: ProductWidget(product: products[index]),
                    ),
                    itemCount: children.length,
                  ),
                );
              },
              error: (_) => const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }
}
