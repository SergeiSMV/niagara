import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

class ModalBackgroundWidget extends StatelessWidget {
  const ModalBackgroundWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConst.kCommon24),
          topRight: Radius.circular(AppConst.kCommon24),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.textColors.main.withOpacity(0.08),
            blurRadius: AppConst.kCommon12,
            offset: AppConst.kShadowTop,
          ),
        ],
      ),
      child: child,
    );
  }
}
