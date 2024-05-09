import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/close_modal_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/draggable_pin_widget.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
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
        builder: (ctx) => Column(
          children: [
            const PinWidget(),
            AppConst.kCommon12.verticalBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppConst.kCommon16.horizontalBox,
                Text(
                  t.bonuses.bonusCard,
                  style: context.textStyle.headingTypo.h3
                      .withColor(context.colors.textColors.main),
                ),
                CloseModalButton(onTap: () => ctx.maybePop()),
              ],
            ),
            AppConst.kCommon12.verticalBox,
            Text(
              t.bonuses.showQR,
              style: context.textStyle.textTypo.tx1Medium
                  .withColor(context.colors.textColors.secondary),
              textAlign: TextAlign.center,
            ),
            AppConst.kCommon24.verticalBox,
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.mainColors.bgCard,
                borderRadius: BorderRadius.circular(AppConst.kCommon16),
              ),
              child: QrImageView(
                data: data,
                padding: EdgeInsets.zero,
              ).paddingAll(AppConst.kCommon24),
            ).paddingSymmetric(horizontal: AppConst.kCommon48),
          ],
        ).paddingSymmetric(horizontal: AppConst.kCommon16),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: QrImageView(
        data: data,
        size: AppConst.kCommon64,
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
