import 'package:flutter/material.dart' hide OutlineInputBorder;
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/base_text_filed_state.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Абстрактный класс базового текстового поля [BaseTextField]. Поддерживает
/// различные состояния и валидацию.
abstract class BaseTextField extends HookWidget {
  const BaseTextField({
    required this.name,
    super.key,
    this.expandable = false,
    this.initialText,
    this.label,
    this.hint,
    this.prefix,
    this.prefixWidget,
    this.keyboardType,
    this.state = BaseTextFieldState.idle,
    this.isRequired = false,
    this.maxLength,
    this.maxValue,
    this.mask,
    this.onChanged,
    this.showCounter = false,
    this.suffixWidget,
  });

  /// Название поля
  final String name;

  final bool expandable;

  /// Текст при инициализации
  final String? initialText;

  /// Заголовок поля
  final String? label;

  /// Подсказка поля
  final String? hint;

  /// Префикс (иконка и т.д.)
  final Widget? prefixWidget;

  /// Префикс (текст)
  final String? prefix;

  /// Тип клавиатуры
  final TextInputType? keyboardType;

  /// Состояние кнопки и поля
  final BaseTextFieldState state;

  /// Флаг, указывающий на то, что поле обязательно для заполнения
  final bool isRequired;

  /// Максимальная длина поля
  final int? maxLength;

  /// Максимальное числовое значение поля
  final int? maxValue;

  /// Маска для поля
  final String? mask;

  /// Функция, которая будет вызвана при изменении значения в поле
  final void Function(String?)? onChanged;

  /// Показывать счетчик числа символов
  final bool showCounter;

  /// Виджет справа
  final Widget? suffixWidget;

  /// Проверка на то, что в поле можно вводить только цифры
  bool get _isNumbers => keyboardType == TextInputType.number;

  /// Проверка на то, что в поле можно вводить только номер телефона
  bool get _isPhoneNumber => keyboardType == TextInputType.phone;

  /// Проверка на то, что в поле можно вводить только email
  bool get _isEmail => keyboardType == TextInputType.emailAddress;

  /// Проверка на то, что в поле можно вводить только цифры
  bool get _isOnlyDigits => _isPhoneNumber || _isNumbers;

  /// Форматтер для маски
  TextInputFormatter? get maskFormatter => mask != null
      ? MaskTextInputFormatter(
          mask: mask,
          filter: _isOnlyDigits ? {'#': RegExp('[0-9]')} : null,
        )
      : null;

  /// Маскированный текст
  String? get maskedText => maskFormatter
      ?.formatEditUpdate(
        TextEditingValue.empty,
        TextEditingValue(text: initialText ?? ''),
      )
      .text;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);
    return FormBuilderTextField(
      key: formKey,
      name: name,
      maxLines: expandable ? null : 1,
      initialValue: mask != null ? maskedText : initialText,
      enabled: !state.isDisabled,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixWidget != null
            ? Padding(
                padding: AppInsets.kLeft8 + AppInsets.kRight4,
                child: prefixWidget,
              )
            : null,
        prefixText: prefix,
        prefixIconConstraints: const BoxConstraints(),
        suffixIcon: !state.isIdle && !state.isNotSuccess
            ? _IconWidget(state: state)
            : suffixWidget,
        suffixIconConstraints: const BoxConstraints(),
        isDense: true,
        contentPadding: label != null
            ? AppInsets.kHorizontal16 + AppInsets.kVertical8
            : AppInsets.kAll16,
        focusedBorder:
            context.theme.inputDecorationTheme.focusedBorder?.copyWith(
          borderSide: BorderSide(
            color: state.color(context) ??
                context.colors.fieldBordersColors.accent,
          ),
        ),
        enabledBorder: context.theme.inputDecorationTheme.border?.copyWith(
          borderSide: BorderSide(
            color:
                state.color(context) ?? context.colors.fieldBordersColors.main,
          ),
        ),
        counter: showCounter ? null : const SizedBox.shrink(),
      ),
      inputFormatters: [
        if (_isOnlyDigits) FilteringTextInputFormatter.digitsOnly,
        if (maskFormatter != null) maskFormatter!,
      ],
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose(
        [
          if (isRequired) FormBuilderValidators.required(),
          if (maxLength != null)
            FormBuilderValidators.maxLength(
              maxLength!,
              errorText: t.common.lengthExceeded,
            ),
          if (_isNumbers) FormBuilderValidators.numeric(),
          if (_isEmail) FormBuilderValidators.email(),
          if (mask != null)
            FormBuilderValidators.minLength(
              mask!.length,
              errorText: _isPhoneNumber ? t.auth.incorrectNumberFormat : null,
            ),
          if (_isOnlyDigits && maxValue != null)
            FormBuilderValidators.max(
              maxLength!,
              errorText: t.cart.exceededLimit,
            ),
        ],
      ),
      style: context.textStyle.textTypo.tx1Medium,
      textAlignVertical: TextAlignVertical.center,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: context.colors.textColors.accent,
      onChanged: onChanged,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}

class _IconWidget extends StatelessWidget {
  const _IconWidget({required this.state});

  final BaseTextFieldState state;
  @override
  Widget build(BuildContext context) {
    final icon = state.iconWithColor(context)?.$1;
    final color = state.iconWithColor(context)?.$2;
    if (icon == null || color == null) return const SizedBox.shrink();
    return Padding(
      padding: AppInsets.kRight8,
      child: icon.svg(
        width: AppSizes.kIconLarge,
        height: AppSizes.kIconLarge,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
