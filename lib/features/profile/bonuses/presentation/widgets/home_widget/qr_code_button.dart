import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/close_modal_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/draggable_pin_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeButton extends StatelessWidget {
  const QRCodeButton({
    required this.data,
    super.key,
  });

  final String data;

  Future<void> _onTap(BuildContext context) async => showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: context.colors.mainColors.white,
        builder: (ctx) => Padding(
          padding: AppInsets.kSymmetricH16,
          child: Column(
            children: [
              const PinWidget(),
              AppBoxes.kBoxV12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBoxes.kBoxH16,
                  Text(
                    t.bonuses.bonusCard,
                    style: context.textStyle.headingTypo.h3
                        .withColor(context.colors.textColors.main),
                  ),
                  CloseModalButton(onTap: () => ctx.maybePop()),
                ],
              ),
              AppBoxes.kBoxV12,
              Text(
                t.bonuses.showQR,
                style: context.textStyle.textTypo.tx1Medium
                    .withColor(context.colors.textColors.secondary),
                textAlign: TextAlign.center,
              ),
              AppBoxes.kBoxV24,
              Padding(
                padding: AppInsets.kSymmetricH48,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colors.mainColors.bgCard,
                    borderRadius: BorderRadius.circular(AppSizes.kGeneral16),
                  ),
                  child: Padding(
                    padding: AppInsets.kAll24,
                    child: QrImageView(
                      data: data,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: QrImageView(
        data: data,
        size: AppSizes.kGeneral64,
        padding: EdgeInsets.zero,
        eyeStyle: QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: context.colors.mainColors.white,
        ),
        dataModuleStyle: QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: context.colors.mainColors.white,
        ),
      ),
    );
  }
}
