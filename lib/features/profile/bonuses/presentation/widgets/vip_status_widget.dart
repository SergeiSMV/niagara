import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/flex_list.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/modal_q_r_code_widget.dart';

/// Виджет с информацией о текущем `VIP`-статусе.
///
/// Отображается на главной и в профиле у пользователя.
class VipStatusWidget extends StatelessWidget {
  const VipStatusWidget({
    super.key,
    required this.bonuses,
    required this.description,
  });

  final Bonuses bonuses;
  final StatusDescription description;

  Future<void> _onTap(
    BuildContext context, {
    required String data,
  }) async =>
      showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: context.colors.mainColors.white,
        builder: (_) => ModalQRCodeWidget(data: data),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bonuses.level.toLocale,
                style: context.textStyle.headingTypo.h2.withColor(
                  context.colors.textColors.white,
                ),
              ),
              Text(
                t.bonuses.activeTo(date: bonuses.endDateFormated),
                style: context.textStyle.textTypo.tx4Medium.withColor(
                  context.colors.textColors.white,
                ),
              ),
            ],
          ),
          AppBoxes.kHeight12,
          FlexList(
            children: description.benefits
                .map(
                  (benefit) => Container(
                    width: context.screenWidth / 3,
                    decoration: BoxDecoration(
                      color: context.colors.mainColors.white,
                      borderRadius: AppBorders.kCircular8,
                    ),
                    child: Padding(
                      padding: AppInsets.kAll8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                benefit.titleShort ?? '',
                                style: context.textStyle.textTypo.tx2SemiBold
                                    .withColor(
                                  context.colors.textColors.accent,
                                ),
                              ),
                              Assets.images.aboutBonuses.star.image(
                                width: AppSizes.kIconMedium,
                              ),
                            ],
                          ),
                          AppBoxes.kHeight8,
                          Text(
                            benefit.descriptionShort ?? '',
                            style:
                                context.textStyle.textTypo.tx4Medium.withColor(
                              context.colors.textColors.main,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          AppBoxes.kHeight16,
          InkWell(
            onTap: () => _onTap(
              context,
              data: bonuses.cardNumber,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.eye.svg(
                  width: AppSizes.kIconMedium,
                  height: AppSizes.kIconMedium,
                  colorFilter: ColorFilter.mode(
                    context.colors.textColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                AppBoxes.kWidth4,
                Text(
                  t.bonuses.showQRcode,
                  style: context.textStyle.buttonTypo.btn3semiBold.withColor(
                    context.colors.mainColors.white,
                  ),
                ),
                Assets.icons.arrowRight.svg(
                  width: AppSizes.kIconSmall,
                  height: AppSizes.kIconSmall,
                  colorFilter: ColorFilter.mode(
                    context.colors.textColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
