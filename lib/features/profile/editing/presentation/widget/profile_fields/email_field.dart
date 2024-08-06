import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/editing/presentation/bloc/profile_editing_cubit/profile_editing_cubit.dart';
import 'package:niagara_app/features/profile/editing/presentation/widget/email/email_confirmation_widget.dart';

/// Поле для отображения текущего email и его редактирования.
///
/// При нажатии показывает модальное окно для подтверждения email.
class EmailField extends StatelessWidget {
  const EmailField();

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
          initialEmail: email,
          profileEditingCubit: cubit,
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
