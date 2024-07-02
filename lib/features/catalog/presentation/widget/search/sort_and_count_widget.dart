import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/catalog/presentation/widget/category/sort_products_button.dart';

class SortAndCountWidget extends StatelessWidget {
  const SortAndCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical8,
      child: Row(
        children: [
          const SortProductsButton(),
          AppBoxes.kWidth8,
          Text(
            '${t.catalog.foundProducts} ${t.product(n: 222)}',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
