import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/make_order_by_phone_widget.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({
    super.key,
    this.error,
    required this.onRefresh,
    this.showPhone = false,
  });
  final String? error;
  final VoidCallback onRefresh;
  final bool showPhone;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * .7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(flex: 2),
          Padding(
            padding: AppInsets.kHorizontal72,
            child: Assets.images.noInternetConnection.image(),
          ),
          Text(
            t.common.noInternetConnection,
            style: context.textStyle.headingTypo.h3.withColor(
              context.colors.textColors.main,
            ),
          ),
          Text(
            t.common.checkYourNetwork,
            style: context.textStyle.textTypo.tx1Medium.withColor(
              context.colors.textColors.secondary,
            ),
          ),
          const Spacer(flex: 3),
          if (showPhone) const MakeOrderByPhoneWidget(),
          Padding(
            padding: AppInsets.kAll16 + AppInsets.kBottom24,
            child: AppTextButton.primary(
              text: t.common.refresh,
              onTap: onRefresh,
            ),
          ),
        ],
      ),
    );
  }
}
