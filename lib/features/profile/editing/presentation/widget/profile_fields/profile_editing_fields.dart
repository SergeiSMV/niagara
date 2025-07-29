import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/common/presentation/widgets/text_fields/app_text_field.dart';
import '../../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../../core/utils/constants/app_insets.dart';
import '../../../../../../core/utils/enums/base_text_filed_state.dart';
import '../../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../../core/utils/gen/strings.g.dart';
import '../../../../user/domain/models/user.dart';
import '../../bloc/profile_editing_cubit/profile_editing_cubit.dart';
import '../../bloc/profile_validator_cubit/profile_validator_cubit.dart';
import 'birthday_field.dart';
import 'email_field.dart';

/// Виджет, содержащий формы для редактирования данных профиля (имя, фамилия,
/// отчество, дата рождения и email).
class ProfileEditingFieldsWidget extends StatelessWidget {
  const ProfileEditingFieldsWidget({
    required User user,
    super.key,
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
  Future<void> _onUpdate(
    BuildContext context, {
    String? name,
    String? surname,
    String? patronymic,
    DateTime? birthday,
    String? email,
  }) async {
    await context.read<ProfileEditingCubit>().updateUserData(
          name: name,
          surname: surname,
          patronymic: patronymic,
          email: email,
          birthday: birthday,
        );

    // Валидируем только измененные поля
    if (name != null) {
      context.read<ProfileValidatorCubit>().validateName(name);
    }
    if (surname != null) {
      context.read<ProfileValidatorCubit>().validateSurname(surname);
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: AppInsets.kHorizontal16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBoxes.kHeight24,
            AppTextField.text(
              hint: t.profile.edit.name,
              label: t.profile.edit.name,
              initialText: _user.name,
              isRequired: true,
              onChanged: (name) => _onUpdate(context, name: name),
            ),
            BlocBuilder<ProfileValidatorCubit, ProfileValidatorState>(
              buildWhen: (previous, current) =>
                  previous.nameError != current.nameError,
              builder: (context, state) => state.nameError != null
                  ? Text(
                      state.nameError!,
                      style: context.textStyle.descriptionTypo.des4.copyWith(
                        color: context.colors.textColors.error,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            AppBoxes.kHeight12,
            AppTextField.text(
              hint: t.profile.edit.surname,
              initialText: _user.surname,
              label: t.profile.edit.surname,
              onChanged: (surname) => _onUpdate(context, surname: surname),
            ),
            BlocBuilder<ProfileValidatorCubit, ProfileValidatorState>(
              buildWhen: (previous, current) =>
                  previous.surnameError != current.surnameError,
              builder: (context, state) => state.surnameError != null
                  ? Text(
                      state.surnameError!,
                      style: context.textStyle.descriptionTypo.des4.copyWith(
                        color: context.colors.textColors.error,
                      ),
                    )
                  : const SizedBox.shrink(),
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
              initialText:
                  _user.phone.isNotEmpty ? _user.phone.substring(1) : null,
              state: BaseTextFieldState.disabled,
            ),
            AppBoxes.kHeight12,
            const EmailField(),
            AppBoxes.kHeight24,
            BirthdayWidget(isBirthdaySet: _isBirthdaySet),
          ],
        ),
      );
}
