import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:niagara_app/features/auth/presentation/bloc/countdown_timer_cubit/countdown_timer_cubit.dart';

/// Виджет для повторной отправки кода подтверждения.
class ReSendCodeWidget extends StatelessWidget {
  const ReSendCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      minimum: EdgeInsets.only(
        top: AppConst.kGetCodeButtonTopPadding,
        bottom: AppConst.kGetCodeButtonBottomPadding,
      ),
      child: Column(
        children: [
          _ResendCodeButton(),
          _ResendCodeTimer(),
        ],
      ),
    );
  }
}

class _ResendCodeButton extends StatelessWidget {
  const _ResendCodeButton();

  void onResendCode(BuildContext context, {bool isDisabled = false}) {
    if (isDisabled) return;
    final phoneNumber = context.read<AuthBloc>().state.maybeWhen(
          getCode: (phoneNumber) => phoneNumber,
          orElse: () => null,
        );
    context
      ..read<CountdownTimerCubit>().startTimer()
      ..read<AuthBloc>().add(AuthEvent.getCode(phoneNumber: phoneNumber));
  }

  @override
  Widget build(BuildContext context) {
    final time = context.select((CountdownTimerCubit cubit) => cubit.state);
    final isDisabled = time != 0;

    final color = isDisabled
        ? context.colors.textColors.secondary
        : context.colors.textColors.accent;

    return InkWell(
      onTap: () => onResendCode(context, isDisabled: isDisabled),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            t.auth.resendCode,
            style: context.textStyle.textTypo.tx1Medium.withColor(color),
          ),
          Assets.icons.arrowRight.svg(
            width: AppConst.kIconMedium,
            height: AppConst.kIconMedium,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}

class _ResendCodeTimer extends StatelessWidget {
  const _ResendCodeTimer();

  @override
  Widget build(BuildContext context) {
    final time = context.select((CountdownTimerCubit cubit) => cubit.state);

    if (time == 0) return const SizedBox.shrink();

    final minutesStr = ((time / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (time % 60).toString().padLeft(2, '0');

    return Text(
      t.auth.through(time: '$minutesStr:$secondsStr'),
      style: context.textStyle.textTypo.tx1Medium.withColor(
        context.colors.textColors.secondary,
      ),
    ).padding(top: AppConst.kPaddingMid);
  }
}
