import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/utils/constants/app_borders.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/privacy_check_cubit/privacy_check_cubit.dart';

/// Виджет для ввода кода подтверждения
class OTPCodeWidget extends StatelessWidget {
  const OTPCodeWidget({super.key});

  /// Обработчик изменения кода
  void onCodeChanged(BuildContext context) =>
      context.read<AuthBloc>().add(const AuthEvent.otpChanged());

  /// Обработчик ввода кода
  void onCodeEntered(BuildContext context, String code) {
    final userAgreement = context.read<PrivacyCheckCubit>().state;
    FocusScope.of(context).unfocus();
    context.read<AuthBloc>().add(
          AuthEvent.authNow(
            otp: code,
            user: userAgreement.user,
            marketing: userAgreement.marketing,
          ),
        );
  }

  /// Создает тему для пинов кода
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

  /// Создает курсор для пинов кода
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
    /// Тема для пинов кода
    final pinTheme = _buildPinTheme(context);

    /// Проверяем, что код не валиден
    final errorOTP = context.watch<AuthBloc>().state.maybeWhen(
          otpError: () => true,
          otpChangeError: () => true,
          orElse: () => false,
        );

    /// Текст ошибки кода
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
