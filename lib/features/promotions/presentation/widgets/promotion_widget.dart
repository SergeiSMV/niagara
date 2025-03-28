import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/common/presentation/widgets/buttons/app_text_button.dart';
import '../../../../core/common/presentation/widgets/modals/draggable_pin_widget.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../core/utils/gen/assets.gen.dart';
import '../../../../core/utils/gen/strings.g.dart';
import '../../../catalog/domain/model/group.dart';
import '../../domain/models/promotion.dart';
import 'promotion_image_widget.dart';

class PromotionWidget extends StatelessWidget {
  const PromotionWidget({
    required Promotion promotion,
    super.key,
    this.withTitle = false,
  }) : _promotion = promotion;

  /// Акция.
  final Promotion _promotion;

  /// Флаг для отображения заголовка.
  final bool withTitle;

  Future<void> _goToPromotionSubject(BuildContext context) async {
    // Закрываем модалку.
    context.maybePop();

    // Если есть група у данной акции, навигация пойдет туда (redirectRoute)
    PageRouteInfo? redirectRoute;
    final group = Group.fromPromotion(_promotion);
    if (group != null) {
      redirectRoute = CatalogWrapper(
        children: [
          CategoryWrapperRoute(
            group: group,
            children: const [CategoryRoute()],
          ),
        ],
      );
    }

    if (redirectRoute != null) {
      context.navigateTo(redirectRoute);
    } else {
      context.navigateTo(
        const CatalogWrapper(
          children: [
            CatalogRoute(),
          ],
        ),
      );
    }
  }

  Future<void> _showPromotionDetails(
    BuildContext context,
    Promotion promotion,
  ) async =>
      showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: context.colors.mainColors.white,
        builder: (ctx) => Column(
          children: [
            const PinWidget(),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PromotionImageWidget(imageUrl: promotion.image),
                    AppBoxes.kHeight24,
                    Padding(
                      padding: AppInsets.kHorizontal16,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              promotion.title,
                              style: context.textStyle.headingTypo.h3
                                  .withColor(context.colors.textColors.main),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppBoxes.kHeight24,
                    Padding(
                      padding: AppInsets.kHorizontal16,
                      child: Text(
                        promotion.description,
                        style: context.textStyle.descriptionTypo.des1
                            .withColor(context.colors.textColors.main),
                      ),
                    ),
                    Padding(
                      padding: AppInsets.kAll16,
                      child: AppTextButton.primary(
                        text: t.common.goShopping,
                        onTap: () => _goToPromotionSubject(ctx),
                      ),
                    ),
                    AppBoxes.kHeight24,
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () async => _showPromotionDetails(context, _promotion),
        child: withTitle
            ? Column(
                children: [
                  PromotionImageWidget(imageUrl: _promotion.image),
                  Padding(
                    padding: AppInsets.kHorizontal16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            _promotion.title,
                            style: context.textStyle.textTypo.tx1SemiBold
                                .withColor(
                              context.colors.textColors.main,
                            ),
                          ),
                        ),
                        AppBoxes.kWidth8,
                        Row(
                          children: [
                            Text(
                              t.promos.more,
                              style: context.textStyle.textTypo.tx3SemiBold
                                  .withColor(
                                context.colors.mainColors.primary,
                              ),
                            ),
                            Assets.icons.arrowRight.svg(
                              width: AppSizes.kIconSmall,
                              height: AppSizes.kIconSmall,
                              colorFilter: ColorFilter.mode(
                                context.colors.mainColors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : PromotionImageWidget(imageUrl: _promotion.image),
      );
}
