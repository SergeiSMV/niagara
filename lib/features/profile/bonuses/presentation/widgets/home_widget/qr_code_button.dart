import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/modal_q_r_code_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeButton extends StatelessWidget {
  const QRCodeButton({
    required this.data,
    super.key,
  });

  final String data;

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
    return InkWell(
      onTap: () => _onTap(context, data: data),
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
