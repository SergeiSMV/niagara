import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_slidable_button_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/cart/favorites/presentation/bloc/favorites_bloc.dart';

class SlideButtonsWidget extends StatelessWidget {
  const SlideButtonsWidget({
    super.key,
    required this.product,
    required this.onActionCompleted,
    required this.onRemove,
  });

  final Product product;
  final VoidCallback onActionCompleted;
  final VoidCallback onRemove;

  void _addToFavorites(BuildContext context) =>
      context.read<FavoritesBloc>().add(FavoritesEvent.addFavorite(product));

  void _removeFromFavorites(BuildContext context) =>
      context.read<FavoritesBloc>().add(FavoritesEvent.removeFavorite(product));

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: AppInsets.kVertical4 + AppInsets.kLeft4,
        child: Column(
          children: [
            BlocBuilder<FavoritesBloc, FavoritesState>(
              buildWhen: (previous, current) => previous != current,
              builder: (_, state) => state.maybeWhen(
                loaded: (favorites) {
                  final bool isFavorite = favorites.any(
                    (element) => element.id == product.id,
                  );

                  final favIcon =
                      isFavorite ? Assets.icons.likeFill : Assets.icons.like;

                  return ProductSlidableButtonWidget(
                    buttonColor: context.colors.buttonColors.secondary,
                    icon: favIcon,
                    iconColor: context.colors.mapColors.borderEnabled,
                    onTap: () {
                      isFavorite
                          ? _removeFromFavorites(context)
                          : _addToFavorites(context);
                      onActionCompleted();
                    },
                  );
                },
                orElse: () => const SizedBox.shrink(),
              ),
            ),
            AppBoxes.kHeight4,
            ProductSlidableButtonWidget(
              buttonColor: context.colors.infoColors.bgRed,
              icon: Assets.icons.delete,
              iconColor: context.colors.mapColors.borderDisabled,
              onTap: () {
                onRemove();
                onActionCompleted();
              },
            ),
          ],
        ),
      ),
    );
  }
}
