import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

class ListSeparatorWidget extends StatelessWidget {
  const ListSeparatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: AppSizes.kGeneral2,
      thickness: AppSizes.kGeneral1,
      indent: AppSizes.kGeneral16,
      endIndent: AppSizes.kGeneral16,
      color: context.colors.otherColors.separator30,
    );
  }
}
