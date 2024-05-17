import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:niagara_app/core/common/presentation/widgets/bottom_shadow_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/validate_phone_cubit/validate_phone_cubit.dart';

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
      final phoneNumber = _formKey
          .currentState?.value[AppConstants.kTextFieldPhoneName]
          .toString();
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

    return BottomShadowWidget(
      child: AppTextButton.primary(
        text: !isLoading ? t.auth.getCode : null,
        onTap: isValid ? () => onTapGetCode(context) : null,
      ),
    );
  }
}
