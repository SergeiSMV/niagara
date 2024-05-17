import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/base_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/enums/base_text_filed_state.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Текстовое поле приложения [AppTextField]. Поддерживает различные состояния
/// и валидацию.
class AppTextField extends BaseTextField {
  const AppTextField._({
    required super.name,
    super.key,
    super.initialText,
    super.label,
    super.hint,
    super.prefixWidget,
    super.keyboardType,
    super.state,
    super.isRequired,
    super.maxLength,
    super.mask,
    super.onChanged,
  });

  /// Текстовое поле для ввода номера телефона
  factory AppTextField.phone({
    Key? key,
    String? initialText,
    void Function(String?)? onChanged,
    BaseTextFieldState? state,
  }) {
    const mask = AppConstants.kPhoneMask;
    return AppTextField._(
      name: AppConstants.kTextFieldPhoneName,
      key: key,
      initialText: initialText,
      prefixWidget: const _PrefixPhoneWidget(),
      hint: AppConstants.kPhoneHint,
      keyboardType: TextInputType.phone,
      state: state ?? BaseTextFieldState.idle,
      isRequired: true,
      maxLength: mask.length,
      mask: mask,
      onChanged: onChanged,
    );
  }

  factory AppTextField.text({
    Key? key,
    String? initialText,
    void Function(String?)? onChanged,
    BaseTextFieldState? state,
    String? label,
    String? hint,
    bool isRequired = false,
    int? maxLength,
  }) {
    return AppTextField._(
      name: AppConstants.kTextFieldTextName,
      key: key,
      initialText: initialText,
      label: label,
      hint: hint,
      keyboardType: TextInputType.text,
      state: state ?? BaseTextFieldState.idle,
      isRequired: isRequired,
      maxLength: maxLength,
      onChanged: onChanged,
    );
  }

  factory AppTextField.number({
    Key? key,
    String? initialText,
    void Function(String?)? onChanged,
    BaseTextFieldState? state,
    String? label,
    String? hint,
    bool isRequired = false,
    int? maxLength,
  }) {
    return AppTextField._(
      name: AppConstants.kNumberTextFieldName,
      key: key,
      initialText: initialText,
      label: label,
      hint: hint,
      keyboardType: TextInputType.number,
      state: state ?? BaseTextFieldState.idle,
      isRequired: isRequired,
      maxLength: maxLength,
      onChanged: onChanged,
    );
  }

  factory AppTextField.search({
    Key? key,
    String? initialText,
    void Function(String?)? onChanged,
    BaseTextFieldState? state,
    String? label,
    String? hint,
    int? maxLength,
  }) {
    return AppTextField._(
      name: AppConstants.kTextFieldTextName,
      key: key,
      initialText: initialText,
      label: label,
      hint: hint,
      keyboardType: TextInputType.text,
      state: state ?? BaseTextFieldState.idle,
      maxLength: maxLength,
      onChanged: onChanged,
    );
  }
}

/// Префикс для номера телефона
class _PrefixPhoneWidget extends StatelessWidget {
  const _PrefixPhoneWidget();

  @override
  Widget build(BuildContext context) {
    return Text(
      t.auth.ruPhoneCode,
      style: context.textStyle.textTypo.tx1Medium,
    );
  }
}
