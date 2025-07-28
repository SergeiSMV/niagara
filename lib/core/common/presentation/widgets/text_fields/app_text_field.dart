import 'package:flutter/material.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/app_insets.dart';
import '../../../../utils/constants/app_sizes.dart';
import '../../../../utils/enums/base_text_filed_state.dart';
import '../../../../utils/extensions/build_context_ext.dart';
import '../../../../utils/extensions/text_style_ext.dart';
import '../../../../utils/gen/assets.gen.dart';
import '../../../../utils/gen/strings.g.dart';
import 'base_text_field.dart';

/// Текстовое поле приложения [AppTextField]. Поддерживает различные состояния
/// и валидацию.
class AppTextField extends BaseTextField {
  const AppTextField._({
    required super.name,
    super.key,
    super.expandable,
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
    super.showCounter = false,
    super.suffixWidget,
    super.maxValue,
  });

  factory AppTextField.email({
    Key? key,
    String? initialText,
    void Function(String?)? onChanged,
    BaseTextFieldState? state,
  }) =>
      AppTextField._(
        name: AppConstants.kEmailTextFieldName,
        key: key,
        initialText: initialText,
        label: t.profile.edit.email,
        hint: t.profile.edit.email,
        keyboardType: TextInputType.emailAddress,
        state: state ?? BaseTextFieldState.idle,
        isRequired: true,
        onChanged: onChanged,
      );

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
      prefixWidget: _PrefixPhoneWidget(state ?? BaseTextFieldState.idle),
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
    bool showCounter = false,
    bool expandable = false,
  }) =>
      AppTextField._(
        name: AppConstants.kTextFieldTextName,
        key: key,
        expandable: expandable,
        initialText: initialText,
        label: label,
        hint: hint,
        keyboardType: TextInputType.text,
        state: state ?? BaseTextFieldState.idle,
        isRequired: isRequired,
        maxLength: maxLength,
        showCounter: showCounter,
        onChanged: onChanged,
      );

  factory AppTextField.number({
    Key? key,
    String? initialText,
    void Function(String?)? onChanged,
    BaseTextFieldState? state,
    String? label,
    String? hint,
    bool isRequired = false,
    int? maxLength,
    int? maxValue,
    bool showCounter = false,
  }) =>
      AppTextField._(
        name: AppConstants.kNumberTextFieldName,
        key: key,
        initialText: initialText,
        label: label,
        hint: hint,
        keyboardType: TextInputType.number,
        state: state ?? BaseTextFieldState.idle,
        isRequired: isRequired,
        maxLength: maxLength,
        maxValue: maxValue,
        showCounter: showCounter,
        onChanged: onChanged,
      );

  factory AppTextField.bonuses({
    Key? key,
    void Function(String?)? onChanged,
    String? initial,
    BaseTextFieldState? state,
    String? label,
    int? maxValue,
    VoidCallback? onApplied,
    bool loading = false,
  }) =>
      AppTextField._(
        name: AppConstants.kBonusesTextFieldName,
        key: key,
        initialText: initial,
        label: label,
        keyboardType: TextInputType.number,
        state: state ?? BaseTextFieldState.idle,
        maxValue: maxValue,
        onChanged: onChanged,
        suffixWidget: loading ? _loader : _ApplyButton(onApplied),
      );

  factory AppTextField.promocode({
    Key? key,
    void Function(String?)? onChanged,
    BaseTextFieldState? state,
    String? label,
    int? maxLength,
    VoidCallback? onTap,
    String? initialText,
    bool loading = false,
  }) =>
      AppTextField._(
        name: AppConstants.kPromocodeTextFieldName,
        key: key,
        label: label,
        keyboardType: TextInputType.text,
        state: state ?? BaseTextFieldState.idle,
        maxLength: maxLength,
        onChanged: onChanged,
        suffixWidget: loading ? _loader : _ApplyButton(onTap),
        initialText: initialText,
      );
  // TODO: Надо изменить [BaseTextFieldState] для отрисовки этого виджета, а не
  // прокидывать [bool loading] в тектовые поля.
  /// Индикатор загрузки.
  static final _loader = Assets.lottie.loadCircle.lottie(
    width: AppSizes.kGeneral48,
    height: AppSizes.kGeneral48,
  );
}

/// Префикс для номера телефона
class _PrefixPhoneWidget extends StatelessWidget {
  const _PrefixPhoneWidget(this.state);

  /// Нужно для соответствия цвета префикса цвету текста в поле.
  final BaseTextFieldState state;

  @override
  Widget build(BuildContext context) {
    final typo = context.textStyle.textTypo.tx1Medium;
    return Text(
      t.auth.ruPhoneCode,
      style: state == BaseTextFieldState.disabled
          ? typo.withColor(context.colors.textColors.secondary)
          : typo,
    );
  }
}

/// Кнопка "Применить"
class _ApplyButton extends StatelessWidget {
  const _ApplyButton(this.onTap);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = onTap != null
        ? context.colors.buttonColors.primary
        : context.colors.buttonColors.inactive;
    return Padding(
      padding: AppInsets.kHorizontal12,
      child: InkWell(
        onTap: onTap,
        child: Text(
          t.common.apply,
          style: context.textStyle.textTypo.tx2SemiBold.withColor(color),
        ),
      ),
    );
  }
}
