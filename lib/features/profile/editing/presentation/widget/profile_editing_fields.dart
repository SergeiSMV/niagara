import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/base_text_filed_state.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/editing/presentation/bloc/profile_editing_cubit/profile_editing_cubit.dart';
import 'package:niagara_app/features/profile/editing/presentation/widget/email_confirmation_widget.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';

/// Виджет, содержащий формы для редактирования данных профиля (имя, фамилия,
/// отчество, дата рождения и email).
class ProfileEditingFieldsWidget extends StatelessWidget {
  const ProfileEditingFieldsWidget({
    super.key,
    required User user,
  }) : _user = user;

  /// Пользователь, данные которого редактируются.
  ///
  /// Данные, получение из этого [User], можно считать сохранёнными, в отличие
  /// от тех, что получены из [ProfileEditingCubit] до нажатия кнопки
  /// "Сохранить".
  final User _user;

  /// Индикатор того, была ли дата рождения установлена до начала редактирования
  /// профиля.
  ///
  /// Нужен, т.к. измненить дату рождения можно только один раз.
  bool get _isBirthdaySet => _user.formattedBirthday != null;

  /// Обновляет данные [User] в [ProfileEditingCubit].
  ///
  /// Обновления не сохраняются до нажатия кнопки "Сохранить" и сбросятся, если
  /// покинуть страницу.
  void _onUpdate(
    BuildContext context, {
    String? name,
    String? surname,
    String? patronymic,
    DateTime? birthday,
    String? email,
  }) =>
      context.read<ProfileEditingCubit>().updateUserData(
            name: name,
            surname: surname,
            patronymic: patronymic,
            email: email,
            birthday: birthday,
          );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16,
      child: Column(
        children: [
          AppBoxes.kHeight24,
          AppTextField.text(
            hint: t.profile.edit.name,
            label: t.profile.edit.name,
            initialText: _user.name,
            isRequired: true,
            onChanged: (name) => _onUpdate(context, name: name),
          ),
          AppBoxes.kHeight12,
          AppTextField.text(
            hint: t.profile.edit.surname,
            initialText: _user.surname,
            label: t.profile.edit.surname,
            isRequired: true,
            onChanged: (surname) => _onUpdate(context, surname: surname),
          ),
          AppBoxes.kHeight12,
          AppTextField.text(
            hint: t.profile.edit.paternalName,
            label: t.profile.edit.paternalName,
            initialText: _user.patronymic,
            onChanged: (patronymic) =>
                _onUpdate(context, patronymic: patronymic),
          ),
          AppBoxes.kHeight12,
          AppTextField.phone(
            initialText: _user.phone.substring(1),
            state: BaseTextFieldState.disabled,
          ),
          AppBoxes.kHeight12,
          const _EmailField(),
          AppBoxes.kHeight24,
          _BirthdayField(isBirthdaySet: _isBirthdaySet),
        ],
      ),
    );
  }
}

class _BirthdayField extends StatelessWidget {
  const _BirthdayField({
    required bool isBirthdaySet,
  }) : _isBirthdaySet = isBirthdaySet;

  final bool _isBirthdaySet;

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        context.read<ProfileEditingCubit>().updateUserData(birthday: value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProfileEditingCubit>();
    final String? birthday = cubit.state.formattedBirthday;

    final color = birthday == null
        ? context.colors.textColors.secondary
        : context.colors.textColors.main;

    final style = (birthday == null
            ? context.textStyle.descriptionTypo.des1
            : context.textStyle.textTypo.tx1Medium)
        .withColor(color);

    return InkWell(
      onTap: () => _isBirthdaySet ? null : _showDatePicker(context),
      // [_isBithdaySet] определяет, установлена ли дата рождения на момент
      // перехода на экран редактирования профиля. [birthday] - значение даты в
      // текущей сессии редактирования.
      child: _isBirthdaySet
          ? birthday != null
              ? AppTextField.email(
                  initialText: birthday,
                  state: BaseTextFieldState.disabled,
                )
              : DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.colors.fieldBordersColors.main,
                    ),
                    borderRadius: AppBorders.kCircular12,
                  ),
                  child: Padding(
                    padding: AppInsets.kHorizontal16 + AppInsets.kVertical16,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        birthday ?? t.profile.edit.birthday,
                        style: style,
                      ),
                    ),
                  ),
                )
          : const _BirthdayPreview(),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProfileEditingCubit>();
    final String email = cubit.state.email;

    final color = email.isEmpty
        ? context.colors.textColors.secondary
        : context.colors.textColors.main;

    final style = (email.isEmpty
            ? context.textStyle.descriptionTypo.des1
            : context.textStyle.textTypo.tx1Medium)
        .withColor(color);

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        // Предотвращает перекрытие контента клавиатрой.
        isScrollControlled: true,
        // Предотвращает случайное закрытие модального окна во время
        // редактирования.
        isDismissible: false,
        builder: (_) => EmailConfirmationWidget(
          initialEmail: context.watch<ProfileEditingCubit>().state.email,
          editCubit: cubit,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colors.fieldBordersColors.main,
          ),
          borderRadius: AppBorders.kCircular12,
        ),
        child: Padding(
          padding: AppInsets.kHorizontal16 + AppInsets.kVertical16,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              email.isEmpty ? t.profile.edit.email : email,
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}

class _BirthdayPreview extends StatelessWidget {
  const _BirthdayPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.profile.edit.birthday,
              style: context.textStyle.textTypo.tx1Medium,
            ),
            Assets.icons.arrowRight.svg(),
          ],
        ),
        AppBoxes.kHeight16,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.gift.image(
              width: AppSizes.kGeneral48,
              height: AppSizes.kGeneral40,
            ),
            AppBoxes.kWidth12,
            Expanded(
              child: Text(
                t.profile.edit.birthdayDescription,
                style: context.textStyle.textTypo.tx2Medium.withColor(
                  context.colors.textColors.secondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
