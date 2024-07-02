import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class CatalogSearchButtonWidget extends StatelessWidget {
  const CatalogSearchButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kRight16,
      child: InkWell(
        onTap: () => context.navigateTo(const CatalogSearchRoute()),
        child: Assets.icons.search.svg(
          width: AppSizes.kIconMedium,
          height: AppSizes.kIconMedium,
        ),
      ),
    );
  }
}
