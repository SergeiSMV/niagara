import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/filters_cubit/filters_cubit.dart';
import 'package:niagara_app/features/catalog/presentation/widget/category/filters_category_widget.dart';
import 'package:niagara_app/features/catalog/presentation/widget/category/sort_products_button.dart';

class InteractionCategoryWidget extends StatelessWidget {
  const InteractionCategoryWidget({
    super.key,
    required this.group,
  });

  final Group group;

  @override
  Widget build(BuildContext context) {
    final hasFilters = context.select<FiltersCubit, bool>(
      (cubit) => cubit.state.maybeWhen(
        loaded: (filters, _) => filters.isNotEmpty,
        orElse: () => false,
      ),
    );

    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SortProductsButton(),
          AppBoxes.kWidth8,
          Expanded(
            child: hasFilters
                ? FiltersCategoryWidget(group: group)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
