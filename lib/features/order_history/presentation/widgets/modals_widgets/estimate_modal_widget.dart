import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/close_modal_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/draggable_pin_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/modals_widgets/proposal_item_wIdget.dart';

class EstimateModalWidget extends StatelessWidget {
  const EstimateModalWidget({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  Future<void> _onCloseModal(BuildContext context) async => context.maybePop();

  @override
  Widget build(BuildContext context) {
    final List<String> proposals = [
      'Грубый персонал',
      'Нет сдачи',
      'Место расположения',
      'Нет грузчика',
      'Нет места на парковке',
      'Качество товара',
    ];

    return Padding(
      padding: AppInsets.kHorizontal16 +
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PinWidget(),
            AppBoxes.kHeight12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.recentOrders.rateOrder,
                  style: context.textStyle.headingTypo.h3
                      .withColor(context.colors.textColors.main),
                ),
                CloseModalButton(onTap: () => _onCloseModal(context)),
              ],
            ),
            AppBoxes.kHeight8,
            Text(
              t.recentOrders.generalAssessment,
              style: context.textStyle.textTypo.tx1SemiBold
                  .withColor(context.colors.textColors.main),
            ),
            AppBoxes.kHeight12,
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              itemSize: 32,
              itemPadding: AppInsets.kHorizontal6,
              itemBuilder: (context, _) =>
                  Assets.images.ratingStarFilled.image(),
              onRatingUpdate: (rating) {},
            ),
            AppBoxes.kHeight24,
            Text(
              t.recentOrders.whatWouldYouLikeToImprove,
              style: context.textStyle.textTypo.tx1SemiBold
                  .withColor(context.colors.textColors.main),
            ),
            AppBoxes.kHeight12,
            Wrap(
              children:
                  proposals.map((e) => ProposalItemWidget(text: e)).toList(),
            ),
            AppBoxes.kHeight24,
            Text(
              t.recentOrders.generalImpressions,
              style: context.textStyle.textTypo.tx1SemiBold
                  .withColor(context.colors.textColors.main),
            ),
            AppBoxes.kHeight12,
            AppTextField.text(
              expandable: true,
              label: t.recentOrders.yourComment,
              onChanged: (val) {},
            ),
            AppBoxes.kHeight24,
            AppTextButton.primary(
              text: t.recentOrders.send,
              onTap: () => _onCloseModal(context).then((_) => onTap()),
            ),
            AppBoxes.kHeight32,
          ],
        ),
      ),
    );
  }
}
