import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/enums/base_text_filed_state.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/features/auth/presentation/bloc/auth_bloc.dart';

/// Поле для ввода номера телефона.
class PhoneNumberField extends StatelessWidget {
  /// Создает экземпляр [PhoneNumberField].
  /// - [formKey] - обязательный ключ формы для валидации номера телефона.
  const PhoneNumberField({
    required this.formKey,
    super.key,
  });

  /// Ключ формы для валидации номера телефона.
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (_, state) => state.maybeWhen(
          phoneValid: () => const _PhoneField(isPhoneValid: true),
          orElse: () => const _PhoneField(),
        ),
      ).paddingAll(16),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({
    this.isPhoneValid = false,
  });

  final bool isPhoneValid;

  @override
  Widget build(BuildContext context) {
    void onChangedPhoneInput(String? phone) =>
        context.read<AuthBloc>().add(AuthEvent.phoneValidation(phone));

    return AppTextField.phone(
      onChanged: onChangedPhoneInput,
      state: isPhoneValid ? BaseTextFieldState.success : null,
    );
  }
}
