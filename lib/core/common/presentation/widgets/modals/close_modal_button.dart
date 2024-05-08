import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class CloseModalButton extends StatelessWidget {
  const CloseModalButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: AppConst.kIconLarge,
        height: AppConst.kIconLarge,
        padding: AppConst.kCommon2.horizontal,
        decoration: BoxDecoration(
          color: context.colors.buttonColors.secondary,
          borderRadius: BorderRadius.circular(AppConst.kCommon6),
        ),
        child: Assets.icons.close.svg(
          colorFilter: ColorFilter.mode(
            context.colors.textColors.main,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
