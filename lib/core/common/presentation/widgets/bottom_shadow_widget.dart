import 'package:flutter/widgets.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

class BottomShadowWidget extends StatelessWidget {
  const BottomShadowWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: AppInsets.kHorizontal16 + AppInsets.kVertical12,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.mainColors.white,
            boxShadow: [
              BoxShadow(
                color: context.colors.textColors.main
                    .withOpacity(AppSizes.kShadowOpacity),
                offset: AppConstants.kShadowTop,
                blurRadius: AppSizes.kGeneral12,
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            maintainBottomViewPadding: true,
            child: child,
          ),
        ),
      );
}
