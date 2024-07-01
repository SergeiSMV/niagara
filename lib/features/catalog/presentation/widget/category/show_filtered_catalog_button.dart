import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/products_bloc/products_bloc.dart';

class ShowFilteredCatalogButton extends StatelessWidget {
  const ShowFilteredCatalogButton({super.key});

  void _navigateToCatalog(BuildContext context) => context.maybePop();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        boxShadow: [
          BoxShadow(
            color: context.colors.textColors.main
                .withOpacity(AppSizes.kShadowOpacity),
            blurRadius: AppSizes.kGeneral12,
            offset: AppConstants.kShadowTop,
          ),
        ],
      ),
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (_, state) {
          final isLoading = state == const ProductsState.loading();
          final items = state.maybeWhen(
            orElse: () => 0,
            loaded: (_, totalItems) => totalItems,
          );
          return Padding(
            padding: AppInsets.kHorizontal16 +
                AppInsets.kVertical12 +
                AppInsets.kBottom12,
            child: AppTextButton.primary(
              text: !isLoading
                  ? '${t.filters.show} ${t.product(n: items)}'
                  : null,
              onTap: () => _navigateToCatalog(context),
            ),
          );
        },
      ),
    );
  }
}
