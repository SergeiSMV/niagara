import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../../core/utils/gen/assets.gen.dart';
import '../../../domain/models/user.dart';
import '../../bloc/user_bloc.dart';

/// Виджет с кнопкой редактирования данных пользователя
class EditUserDataButton extends StatelessWidget {
  const EditUserDataButton({super.key, this.size});

  /// Размер иконки
  final double? size;

  @override
  Widget build(BuildContext context) => BlocBuilder<UserBloc, UserState>(
        builder: (_, state) => state.maybeWhen(
          orElse: SizedBox.shrink,
          loaded: (user) => _EditButton(user, size),
        ),
      );
}

/// Виджет кнопки редактирования данных пользователя
class _EditButton extends StatelessWidget {
  const _EditButton(this.user, [this.size]);

  /// Данные пользователя
  final User user;

  /// Размер иконки
  final double? size;

  /// Переходит на страницу редактирования данных пользователя
  Future<void> _goToEditPage(BuildContext context, User user) async {
    await context.navigateTo(
      EditProfileRoute(user: user),
    );
  }

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => _goToEditPage(context, user),
        icon: SizedBox(
          width: size ?? AppSizes.kGeneral48,
          height: size ?? AppSizes.kGeneral48,
          child: Assets.icons.pen.svg(
            width: AppSizes.kIconMedium,
            height: AppSizes.kIconMedium,
            fit: BoxFit.none,
          ),
        ),
      );
}
