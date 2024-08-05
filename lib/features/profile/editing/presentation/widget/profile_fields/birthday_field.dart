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

/// Виджет для указания даты рождения пользователя.
///
/// В случае, если дата рождения не установлена, отображает баннер с
/// предложением указать её, иначе - заблокированное текстовое поле.
class BirthdayWidget extends StatelessWidget {
  const BirthdayWidget({
    required bool isBirthdaySet,
  }) : _isBirthdaySet = isBirthdaySet;

  /// Определяет, установлена ли дата рождения на момент перехода на экран
  /// редактирования профиля.
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
          : const _SetBirthdayBanner(),
    );
  }
}

/// Виджет с предложением указать дату рождения.
class _SetBirthdayBanner extends StatelessWidget {
  const _SetBirthdayBanner();

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
