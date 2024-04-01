import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/auth/presentation/bloc/auth_bloc.dart';

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
        context.read<AuthBloc>().add(AuthEvent.getCode(phoneNumber));
      }
    }

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
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (_, state) => state.maybeWhen(
            phoneValid: () => _GetCodeButton(onTap: onTapGetCode),
            orElse: () => const _GetCodeButton(),
          ),
        ),
      ),
    );
  }
}

class _GetCodeButton extends StatelessWidget {
  const _GetCodeButton({
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppTextButton.primary(
      text: t.auth.getCode,
      onTap: onTap,
    );
  }
}
