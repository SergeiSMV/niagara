import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/editing/presentation/bloc/email_confirmation_bloc/email_confirmation_bloc.dart';
import 'package:pinput/pinput.dart';

class EmailCodeForm extends StatefulWidget {
  const EmailCodeForm({required this.email});

  final String email;

  @override
  State<EmailCodeForm> createState() => _EmailCodeFormState();
}

class _EmailCodeFormState extends State<EmailCodeForm> {
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

  void _onCodeEntered(BuildContext context, String code) {
    FocusScope.of(context).unfocus();
    context
        .read<EmailConfirmationBloc>()
        .add(EmailConfirmationEvent.confirmCode(code: code));
  }

  @override
  Widget build(BuildContext context) {
    final pinTheme = _buildPinTheme(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.profile.edit.enterCode,
              style: context.textStyle.headingTypo.h3,
            ),
            InkWell(
              onTap: () => context.maybePop(),
              child: Assets.icons.close.svg(
                width: AppSizes.kIconLarge,
                height: AppSizes.kIconLarge,
              ),
            ),
          ],
        ),
        AppBoxes.kHeight24,
        Text(
          t.profile.edit.codeDescription(email: widget.email),
          style: context.textStyle.textTypo.tx1Medium,
        ),
        AppBoxes.kHeight6,
        Padding(
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
            preFilledWidget:
                _buildCursor(context.colors.fieldBordersColors.main),
            cursor: _buildCursor(context.colors.fieldBordersColors.accent),
            // errorText: errorOTPText,
            errorTextStyle: context.textStyle.textTypo.tx3Medium
                .withColor(context.colors.textColors.error),
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            autofocus: true,
            // onChanged: (_) => onCodeChanged(context),
            onCompleted: (value) => _onCodeEntered(context, value),
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            // forceErrorState: errorOTP,
          ),
        ),
      ],
    );
  }
}
