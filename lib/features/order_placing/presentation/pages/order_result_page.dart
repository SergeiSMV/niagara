import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/bottom_shadow_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';

/// Страница с результатом оформления заказа.
@RoutePage()
class OrderResultPage extends StatelessWidget {
  const OrderResultPage({super.key, required this.isSuccessful});

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
    return BlocProvider(
      create: (_) => getIt<UserBloc>(),
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
              ? () => context
                ..maybePop()
                ..navigateTo(const HomeWrapperRoute())
              : () => context.maybePop(),
        ),
      );
}
