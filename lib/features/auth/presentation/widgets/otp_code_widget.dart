import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:pinput/pinput.dart';

/// Виджет для ввода кода подтверждения.
class OTPCodeWidget extends StatelessWidget {
  /// Конструктор виджета для ввода кода подтверждения.
  const OTPCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final pinTheme = PinTheme(
      height: AppConst.kOTPCodeHeight,
      width: AppConst.kOTPCodeWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConst.kOTPCodeRadius),
        border: Border.all(
          color: context.colors.fieldBordersColors.main,
        ),
      ),
      textStyle: context.textStyle.headingTypo.h1,
    );

    return Pinput(
      crossAxisAlignment: CrossAxisAlignment.center,
      defaultPinTheme: pinTheme,
      focusedPinTheme: pinTheme.copyBorderWith(
        border: Border.all(color: context.colors.fieldBordersColors.accent),
      ),
      errorPinTheme: pinTheme.copyBorderWith(
        border: Border.all(color: context.colors.fieldBordersColors.negative),
      ),
      preFilledWidget: _buildCursor(context.colors.fieldBordersColors.main),
      cursor: _buildCursor(context.colors.fieldBordersColors.accent),
      errorText: t.auth.incorrectCode,
      errorTextStyle: context.textStyle.textTypo.tx3Medium
          .withColor(context.colors.textColors.error),
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      autofocus: true,
      onCompleted: (value) => debugPrint(value),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      // forceErrorState: true,
    ).paddingAll(AppConst.kPaddingMid);
  }

  Container _buildCursor(Color color) {
    return Container(
      height: AppConst.kOTPCodePreFilledSize,
      width: AppConst.kOTPCodePreFilledSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
