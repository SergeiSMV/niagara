import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/cart/favorites/presentation/bloc/favorites_bloc.dart';

class ProductFavoriteButton extends StatelessWidget {
  const ProductFavoriteButton({
    super.key,
    required this.product,
    this.size = AppSizes.kIconMedium,
  });

  final Product product;
  final double size;

  void _addToFavorites(BuildContext context) =>
      context.read<FavoritesBloc>().add(FavoritesEvent.addFavorite(product));

  void _removeFromFavorites(BuildContext context) =>
      context.read<FavoritesBloc>().add(FavoritesEvent.removeFavorite(product));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: (previous, current) => previous != current,
      builder: (_, state) => state.maybeWhen(
        loaded: (favorites) {
          final bool isFavorite = favorites.any(
            (element) => element.id == product.id,
          ); 

          final favIcon =
              isFavorite ? Assets.icons.likeFill : Assets.icons.like;

          

          return InkWell(
            onTap: () => isFavorite
                ? _removeFromFavorites(context)
                : _addToFavorites(context),
            child: Padding(
              padding: AppInsets.kAll4,
              child: favIcon.svg(
                width: size,
                height: size,
              ),
            ),
          );
        },
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}
