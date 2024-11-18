import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/catalog_search_bloc/catalog_search_bloc.dart';
import 'package:niagara_app/features/catalog/presentation/widget/search/sort_search_button_widget.dart';

class SortAndCountWidget extends StatelessWidget {
  const SortAndCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogSearchBloc, CatalogSearchState>(
      builder: (_, state) => state.maybeWhen(
        loaded: (products, totalCount) => Padding(
          padding: AppInsets.kHorizontal16 + AppInsets.kVertical8,
          child: Row(
            children: [
              const SortSearchButtonWidget(),
              AppBoxes.kWidth8,
              Expanded(
                child: Text(
                  '${t.catalog.foundProducts} ${t.product(n: totalCount)}',
                  style: context.textStyle.textTypo.tx2Medium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}
