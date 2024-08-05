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
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/countdown_timer_cubit/countdown_timer_cubit.dart';
import 'package:niagara_app/features/profile/editing/presentation/bloc/email_confirmation_bloc/email_confirmation_bloc.dart';
import 'package:pinput/pinput.dart';

class EmailCodeForm extends StatefulWidget {
  const EmailCodeForm({required this.email});

  final String email;

  @override
  State<EmailCodeForm> createState() => _EmailCodeFormState();
}

class _EmailCodeFormState extends State<EmailCodeForm> {
  /// Коллбек, вызываемый при завершении ввода кода подтверждения.
  void _onCodeEntered(BuildContext context, String code) {
    FocusScope.of(context).unfocus();
    context
        .read<EmailConfirmationBloc>()
        .add(EmailConfirmationEvent.confirmCode(code: code));
  }

  @override
  Widget build(BuildContext context) {
    final PinTheme pinTheme = _buildPinTheme(context);

    final bool isError = context.watch<EmailConfirmationBloc>().state.maybeWhen(
          codeError: (_) => true,
          resendCodeError: (_) => true,
          orElse: () => false,
        );

    final String? errorText =
        context.watch<EmailConfirmationBloc>().state.maybeWhen(
              codeError: (error) => t.profile.edit.codeError,
              resendCodeError: (error) => t.profile.edit.resendCodeError,
              orElse: () => null,
            );

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
            errorText: errorText,
            errorTextStyle: context.textStyle.textTypo.tx3Medium
                .withColor(context.colors.textColors.error),
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            autofocus: true,
            onCompleted: (value) => _onCodeEntered(context, value),
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            forceErrorState: isError,
          ),
        ),
        AppBoxes.kHeight32,
        const _ResendCodeButton(),
        const _ResendCodeTimer(),
      ],
    );
  }
}

class _ResendCodeButton extends StatelessWidget {
  const _ResendCodeButton();

  void _resendCode(BuildContext context) {
    context.read<EmailConfirmationBloc>().add(
          const EmailConfirmationEvent.resendCode(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CountdownTimerCubit, int, bool>(
      selector: (time) => time == 0,
      builder: (context, isFinished) {
        final Color color = isFinished
            ? context.colors.textColors.accent
            : context.colors.textColors.secondary;

        return InkWell(
          onTap: isFinished ? () => _resendCode(context) : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                t.auth.resendCode,
                style: context.textStyle.textTypo.tx1Medium.withColor(color),
              ),
              Assets.icons.arrowRight.svg(
                width: AppSizes.kIconMedium,
                height: AppSizes.kIconMedium,
                colorFilter: ColorFilter.mode(
                  color,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ResendCodeTimer extends StatelessWidget {
  const _ResendCodeTimer();

  @override
  Widget build(BuildContext context) {
    final time = context.select<CountdownTimerCubit, int>(
      (cubit) => cubit.state,
    );

    if (time == 0) return const SizedBox.shrink();

    final minutesStr = ((time / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (time % 60).toString().padLeft(2, '0');

    return Padding(
      padding: AppInsets.kTop8,
      child: Text(
        t.auth.through(time: '$minutesStr:$secondsStr'),
        style: context.textStyle.textTypo.tx1Medium.withColor(
          context.colors.textColors.secondary,
        ),
      ),
    );
  }
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
