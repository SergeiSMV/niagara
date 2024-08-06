import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/base_text_filed_state.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/editing/presentation/bloc/profile_editing_cubit/profile_editing_cubit.dart';
import 'package:niagara_app/features/profile/editing/presentation/widget/profile_fields/birthday_field.dart';
import 'package:niagara_app/features/profile/editing/presentation/widget/profile_fields/email_field.dart';
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
          const EmailField(),
          AppBoxes.kHeight24,
          BirthdayWidget(isBirthdaySet: _isBirthdaySet),
        ],
      ),
    );
  }
}
