import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет заголовка страницы ввода кода подтверждения.
class OTPTitleWidget extends StatelessWidget {
  const OTPTitleWidget({
    required String phoneNumber,
    super.key,
  }) : _phoneNumber = phoneNumber;

  final String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kAll16,
      child: Column(
        children: [
          Padding(
            padding: AppInsets.kBottom12,
            child: Text(
              t.auth.enterCode,
              style: context.textStyle.headingTypo.h3,
            ),
          ),
          Padding(
            padding: AppInsets.kHorizontal32,
            child: Text(
              t.auth.weSentCode(phoneNumber: _phoneNumber),
              style: context.textStyle.textTypo.tx1Medium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
