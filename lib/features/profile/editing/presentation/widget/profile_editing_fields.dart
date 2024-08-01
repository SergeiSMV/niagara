import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
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

class ProfileEditingFieldsWidget extends StatelessWidget {
  const ProfileEditingFieldsWidget({
    super.key,
    required User user,
  }) : _user = user;

  final User _user;

  /// Эти геттеры нужны для того, чтобы запретить редактировать поле даты
  /// рождения после нажатия кнопки "Сохранить".
  bool get _isBirthdaySet => _user.birthday.isNotEmpty;

  void _onUpdate(
    BuildContext context, {
    String? name,
    String? surname,
    String? patronymic,
    String? birthday,
    String? email,
  }) =>
      context.read<ProfileEditingCubit>().updateUserData(
            name: name,
            surname: surname,
            patronymic: patronymic,
            email: email,
            birthday: birthday,
          );

  // TODO: Поменять на наш календарь
  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        final birthday = '${value.day}.${value.month}.${value.year}';
        _onUpdate(context, birthday: birthday);
      }
    });
  }

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
          BlocBuilder<ProfileEditingCubit, User>(
            builder: (_, user) => GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (_) => EmailConfirmationWidget(
                  initialEmail: user.email,
                  editCubit: context.read<ProfileEditingCubit>(),
                ),
              ),
              child: AbsorbPointer(
                child: AppTextField.email(
                  initialText: user.email,
                ),
              ),
            ),
          ),
          AppBoxes.kHeight24,
          BlocBuilder<ProfileEditingCubit, User>(
            // TODO: Нормальная валидация даты
            builder: (_, state) => state.birthday.replaceAll('"', '').isEmpty
                ? InkWell(
                    onTap: () => _showDatePicker(context),
                    child: const _BirthdayPreview(),
                  )
                : AppTextField.text(
                    hint: t.profile.edit.birthday,
                    initialText: state.birthday,
                    state: _isBirthdaySet ? BaseTextFieldState.disabled : null,
                    onChanged: (birthday) =>
                        _onUpdate(context, birthday: birthday),
                  ),
          ),
        ],
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
