import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/enums/base_text_filed_state.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/features/auth/presentation/bloc/validate_phone_cubit/validate_phone_cubit.dart';

/// Поле для ввода номера телефона.
class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    required GlobalKey<FormBuilderState> formKey,
    super.key,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;

  void onChangedPhoneInput(BuildContext context, {String? phone}) =>
      context.read<ValidatePhoneCubit>().validatePhone(phone);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: BlocBuilder<ValidatePhoneCubit, bool>(
        builder: (context, isValid) => AppTextField.phone(
          onChanged: (value) => onChangedPhoneInput(context, phone: value),
          state: isValid ? BaseTextFieldState.success : null,
        ),
      ).paddingAll(16),
    );
  }
}
