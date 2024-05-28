import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class ProductFavoriteButton extends StatelessWidget {
  const ProductFavoriteButton({
    super.key,
    required this.product,
    this.size = AppSizes.kIconMedium,
  });

  final Product product;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => debugPrint('Set favorite: $product'),
      child: Padding(
        padding: AppInsets.kAll4,
        child: Assets.icons.like.svg(
          width: size,
          height: size,
        ),
      ),
    );
  }
}
