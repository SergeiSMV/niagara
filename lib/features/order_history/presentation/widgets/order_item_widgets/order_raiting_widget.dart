import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../core/utils/constants/app_borders.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/gen/assets.gen.dart';

/// Виджет для отображения рейтинга заказа
class OrderRaitingWidget extends StatelessWidget {
  const OrderRaitingWidget({
    required this.rating,
    super.key,
  });

  /// Рейтинг заказа
  final int rating;

  @override
  Widget build(BuildContext context) => Container(
        padding: AppInsets.kAll8,
        decoration: BoxDecoration(
          borderRadius: AppBorders.kCircular8,
          color: context.colors.buttonColors.secondary,
        ),
        child: RatingBar.builder(
          ignoreGestures: true,
          initialRating: rating.toDouble(),
          minRating: 1,
          itemSize: 16,
          itemPadding: AppInsets.kHorizontal2,
          itemBuilder: (__, _) => Assets.images.ratingStarFilled.image(),
          onRatingUpdate: (_) {},
        ),
      );
}
