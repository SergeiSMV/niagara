import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/auth/presentation/bloc/countdown_timer_cubit/countdown_timer_cubit.dart';

/// Виджет для повторной отправки кода подтверждения.
class ReSendCodeWidget extends StatelessWidget {
  /// Конструктор виджета для повторной отправки кода подтверждения.
  const ReSendCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(
        top: AppConst.kGetCodeButtonTopPadding,
        bottom: AppConst.kGetCodeButtonBottomPadding,
      ),
      child: Column(
        children: [
          const _ResendCodeButton(),
          AppConst.kPaddingMid.height,
          const _ResendCodeTimer(),
        ],
      ),
    );
  }
}

class _ResendCodeButton extends StatelessWidget {
  const _ResendCodeButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => debugPrint('Resend code'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            t.auth.resendCode,
            style: context.textStyle.textTypo.tx1Medium.withColor(
              context.colors.textColors.accent,
            ),
          ),
          Assets.icons.arrowRight.svg(
            width: AppConst.kIconMedium,
            height: AppConst.kIconMedium,
            colorFilter: ColorFilter.mode(
              context.colors.textColors.accent,
              BlendMode.srcIn,
            ),
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
    final minutesStr = ((time / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (time % 60).toString().padLeft(2, '0');

    return Text(
      t.auth.through(time: '$minutesStr:$secondsStr'),
      style: context.textStyle.textTypo.tx1Medium.withColor(
        context.colors.textColors.secondary,
      ),
    );
  }
}
