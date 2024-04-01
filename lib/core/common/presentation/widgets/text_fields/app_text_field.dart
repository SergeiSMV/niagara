import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/base_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/enums/base_text_filed_state.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

/// Текстовое поле приложения [AppTextField]. Поддерживает различные состояния
/// и валидацию.
class AppTextField extends BaseTextField {
  const AppTextField._({
    required super.name,
    super.key,
    super.initialText,
    super.label,
    super.hint,
    super.prefix,
    super.prefixWidget,
    super.keyboardType,
    super.state,
    super.required,
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
    const mask = AppConst.kPhoneMask;
    return AppTextField._(
      name: AppConst.kTextFieldPhoneName,
      key: key,
      initialText: initialText,
      prefixWidget: const _PrefixPhoneWidget(),
      hint: AppConst.kPhoneHint,
      keyboardType: TextInputType.phone,
      state: state ?? BaseTextFieldState.idle,
      required: true,
      maxLength: mask.length,
      mask: mask,
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
      AppConst.kCountryPhoneCode,
      style: context.textStyle.textTypo.tx1Medium,
    );
  }
}
