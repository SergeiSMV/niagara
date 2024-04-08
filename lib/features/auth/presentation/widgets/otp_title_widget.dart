import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет заголовка страницы ввода кода подтверждения.
class OTPTitleWidget extends StatelessWidget {
  const OTPTitleWidget({
    required String phoneNumber,
    super.key,
  }) : _phoneNumber = phoneNumber;

  /// Номер телефона
  final String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          t.auth.enterCode,
          style: context.textStyle.headingTypo.h3,
        ).padding(bottom: AppConst.kPaddingMid + AppConst.kPaddingMin),
        Text(
          t.auth.weSentCode(phoneNumber: _phoneNumber),
          style: context.textStyle.textTypo.tx1Medium,
          textAlign: TextAlign.center,
        ).paddingSymmetric(
          horizontal: AppConst.kPaddingMax * 2,
        ),
      ],
    ).paddingAll(AppConst.kPaddingMax);
  }
}
