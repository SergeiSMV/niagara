import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../../core/common/presentation/widgets/bottom_shadow_widget.dart';
import '../../../../../core/common/presentation/widgets/buttons/app_text_button.dart';
import '../../../../../core/dependencies/di.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../../../user/domain/models/user.dart';
import '../../../user/presentation/bloc/user_bloc.dart';
import '../bloc/profile_editing_cubit/profile_editing_cubit.dart';
import '../bloc/profile_validator_cubit/profile_validator_cubit.dart';
import '../widget/profile_fields/profile_editing_fields.dart';

/// Страница редактирования профиля пользователя
@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({
    required User user,
    super.key,
  }) : _user = user;

  final User _user;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<ProfileEditingCubit>(param1: _user),
          ),
          BlocProvider(
            create: (_) => getIt<ProfileValidatorCubit>(),
          ),
        ],
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              const SliverAppBarWidget(),
              SliverToBoxAdapter(
                child: ProfileEditingFieldsWidget(user: _user),
              ),
            ],
          ),
          bottomNavigationBar: const _SaveChangesButton(),
        ),
      );
}

class _SaveChangesButton extends StatelessWidget {
  const _SaveChangesButton();

  VoidCallback? _onSaveCallback(BuildContext context) {
    final canSave = context.watch<ProfileEditingCubit>().canSave;
    final validData = context.watch<ProfileValidatorCubit>().state;
    if (!canSave ||
        validData.nameError != null ||
        validData.surnameError != null) {
      return null;
    }

    return () async {
      final User user = context.read<ProfileEditingCubit>().state;
      context.read<UserBloc>().add(UserEvent.updateUser(user));
      await context.maybePop();
    };
  }

  @override
  Widget build(BuildContext context) => BottomShadowWidget(
        child: AppTextButton.accent(
          text: t.common.save,
          onTap: _onSaveCallback(context),
        ),
      );
}
