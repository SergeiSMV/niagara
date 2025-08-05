import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/presentation/widgets/bottom_shadow_widget.dart';
import '../../../../core/common/presentation/widgets/buttons/app_text_button.dart';
import '../../../../core/dependencies/di.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/gen/assets.gen.dart';
import '../../../../core/utils/gen/strings.g.dart';
import '../../../profile/user/presentation/bloc/user_bloc.dart';

/// Страница с результатом оформления заказа.
@RoutePage()
class OrderResultPage extends StatelessWidget {
  const OrderResultPage({required this.isSuccessful, super.key});

  /// Результат оформления заказа.
  final bool isSuccessful;

  @override
  Widget build(BuildContext context) {
    final String text = isSuccessful
        ? t.orderPlacing.orderingSuccess
        : t.orderPlacing.orderingError;

    final AssetGenImage image =
        isSuccessful ? Assets.images.greenCheck : Assets.images.a3DError;

    final textStyle = context.textStyle.headingTypo.h3;
    return BlocProvider.value(
      value: getIt<UserBloc>(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              image.image(
                height: AppSizes.kImageSize170,
                width: AppSizes.kImageSize170,
              ),
              AppBoxes.kHeight16,
              Text(text, style: textStyle),
            ],
          ),
        ),
        bottomNavigationBar: _OkButton(isSuccessful),
      ),
    );
  }
}

class _OkButton extends StatelessWidget {
  const _OkButton(this.isSuccessful);

  final bool isSuccessful;

  @override
  Widget build(BuildContext context) => BottomShadowWidget(
        child: AppTextButton.accent(
          text: isSuccessful
              ? t.orderPlacing.continueShopping
              : t.orderPlacing.retry,
          onTap: isSuccessful
              ? () async {
                  await context.maybePop();
                  context.tabsRouter.setActiveIndex(0);
                }
              : () => context.maybePop(),
        ),
      );
}
