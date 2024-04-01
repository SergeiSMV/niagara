import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/enums/base_text_filed_state.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/features/auth/presentation/bloc/validate_phone_cubit/validate_phone_cubit.dart';

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
    void onChangedPhoneInput(String? phone) =>
        context.read<ValidatePhoneCubit>().validatePhone(phone);

    final isValid = context.select((ValidatePhoneCubit cubit) => cubit.state);

    return FormBuilder(
      key: formKey,
      child: AppTextField.phone(
        onChanged: onChangedPhoneInput,
        state: isValid ? BaseTextFieldState.success : null,
      ).paddingAll(16),
    );
  }
}
