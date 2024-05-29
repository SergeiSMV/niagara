import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class ProductFavoriteButton extends HookWidget {
  const ProductFavoriteButton({
    super.key,
    required this.product,
    this.size = AppSizes.kIconMedium,
  });

  final Product product;
  final double size;

  @override
  Widget build(BuildContext context) {
    final isFavorite = useState(false);
    final favIcon =
        isFavorite.value ? Assets.icons.likeFill : Assets.icons.like;

    return InkWell(
      onTap: () => isFavorite.value = !isFavorite.value,
      child: Padding(
        padding: AppInsets.kAll4,
        child: favIcon.svg(
          width: size,
          height: size,
        ),
      ),
    );
  }
}
