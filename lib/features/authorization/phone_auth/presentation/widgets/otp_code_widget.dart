import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:pinput/pinput.dart';

/// Виджет для ввода кода подтверждения
class OTPCodeWidget extends StatelessWidget {
  const OTPCodeWidget({super.key});

  void onCodeChanged(BuildContext context) =>
      context.read<AuthBloc>().add(const AuthEvent.otpChanged());

  void onCodeEntered(BuildContext context, String code) {
    FocusScope.of(context).unfocus();
    context.read<AuthBloc>().add(AuthEvent.authNow(otp: code));
  }

  PinTheme _buildPinTheme(BuildContext context) => PinTheme(
        height: AppSizes.kGeneral72,
        width: AppSizes.kGeneral64,
        decoration: BoxDecoration(
          borderRadius: AppBorders.kCircular12,
          border: Border.all(
            color: context.colors.fieldBordersColors.main,
          ),
        ),
        textStyle: context.textStyle.headingTypo.h1,
      );

  Widget _buildCursor(Color color) => Container(
        height: AppSizes.kGeneral4,
        width: AppSizes.kGeneral4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final pinTheme = _buildPinTheme(context);

    final errorOTP = context.watch<AuthBloc>().state.maybeWhen(
          otpError: () => true,
          otpChangeError: () => true,
          orElse: () => false,
        );

    final errorOTPText = context.watch<AuthBloc>().state.maybeWhen(
          otpError: () => t.auth.incorrectCode,
          otpChangeError: () => t.auth.limitSendCode,
          orElse: () => '',
        );

    return Padding(
      padding: AppInsets.kAll8,
      child: Pinput(
        crossAxisAlignment: CrossAxisAlignment.center,
        defaultPinTheme: pinTheme,
        focusedPinTheme: pinTheme.copyBorderWith(
          border: Border.all(
            color: context.colors.fieldBordersColors.accent,
          ),
        ),
        errorPinTheme: pinTheme.copyBorderWith(
          border: Border.all(
            color: context.colors.fieldBordersColors.negative,
          ),
        ),
        preFilledWidget: _buildCursor(context.colors.fieldBordersColors.main),
        cursor: _buildCursor(context.colors.fieldBordersColors.accent),
        errorText: errorOTPText,
        errorTextStyle: context.textStyle.textTypo.tx3Medium
            .withColor(context.colors.textColors.error),
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        autofocus: true,
        onChanged: (_) => onCodeChanged(context),
        onCompleted: (value) => onCodeEntered(context, value),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        forceErrorState: errorOTP,
      ),
    );
  }
}
