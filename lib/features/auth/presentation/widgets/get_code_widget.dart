import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:niagara_app/features/auth/presentation/bloc/validate_phone_cubit/validate_phone_cubit.dart';

/// Кнопка "Получить код" для отправки кода подтверждения на номер телефона.
class GetCodeWidget extends StatelessWidget {
  const GetCodeWidget({
    required GlobalKey<FormBuilderState> formKey,
    super.key,
  }) : _formKey = formKey;

  // Ключ формы для валидации номера телефона.
  final GlobalKey<FormBuilderState> _formKey;

  void onTapGetCode(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final phoneNumber =
          _formKey.currentState?.value[AppConst.kTextFieldPhoneName].toString();
      if (phoneNumber == null || phoneNumber.isEmpty) return;
      context.read<AuthBloc>().add(AuthEvent.getCode(phoneNumber: phoneNumber));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthBloc>().state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

    final isValid = context.watch<ValidatePhoneCubit>().state;

    return Container(
      padding: AppConst.kCommon16.horizontal,
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
          text: !isLoading ? t.auth.getCode : null,
          onTap: isValid ? () => onTapGetCode(context) : null,
        ),
      ),
    );
  }
}
