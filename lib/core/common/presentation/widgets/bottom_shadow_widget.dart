import 'package:flutter/widgets.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';

class BottomShadowWidget extends StatelessWidget {
  const BottomShadowWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainColors.white,
          boxShadow: [
            BoxShadow(
              color: context.colors.textColors.main
                  .withOpacity(AppConst.kShadowOpacity),
              offset: AppConst.kShadowOffset,
              blurRadius: AppConst.kShadowBlur,
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          maintainBottomViewPadding: true,
          child: child,
        ).paddingSymmetric(
          horizontal: AppConst.kCommon16,
          vertical: AppConst.kCommon12,
        ),
      );
}
