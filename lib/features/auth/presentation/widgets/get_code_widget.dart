import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:niagara_app/features/auth/presentation/bloc/countdown_timer_cubit/countdown_timer_cubit.dart';
import 'package:niagara_app/features/auth/presentation/bloc/validate_phone_cubit/validate_phone_cubit.dart';

/// Кнопка "Получить код" для отправки кода подтверждения на номер телефона.
class GetCodeWidget extends StatelessWidget {
  /// Создает экземпляр [GetCodeWidget].
  const GetCodeWidget({
    required this.formKey,
    super.key,
  });

  /// Ключ формы для валидации номера телефона.
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    void onTapGetCode() {
      if (formKey.currentState?.saveAndValidate() ?? false) {
        final phoneNumber = formKey
            .currentState?.value[AppConst.kTextFieldPhoneName]
            .toString();
        if (phoneNumber == null || phoneNumber.isEmpty) return;
        context
          ..read<AuthBloc>().add(AuthEvent.getCode(phoneNumber: phoneNumber))
          ..read<CountdownTimerCubit>().startTimer()
          ..pushRoute(OTPRoute(phoneNumber: phoneNumber));
      }
    }

    final isValid = context.select((ValidatePhoneCubit cubit) => cubit.state);

    return Container(
      padding: AppConst.kPaddingMax.horizontal,
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        boxShadow: [
          BoxShadow(
            color: context.colors.textColors.main
                .withOpacity(AppConst.kShadowOpacity),
            offset: AppConst.kShadowOffset,
            blurRadius: AppConst.kShadowBlur,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(
          top: AppConst.kGetCodeButtonTopPadding,
          bottom: AppConst.kGetCodeButtonBottomPadding,
        ),
        maintainBottomViewPadding: true,
        child: AppTextButton.primary(
          text: t.auth.getCode,
          onTap: isValid ? onTapGetCode : null,
        ),
      ),
    );
  }
}
