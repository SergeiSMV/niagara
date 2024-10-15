import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/bottom_shadow_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/editing/presentation/bloc/profile_editing_cubit/profile_editing_cubit.dart';
import 'package:niagara_app/features/profile/editing/presentation/widget/profile_fields/profile_editing_fields.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';

@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({
    super.key,
    required User user,
  }) : _user = user;

  final User _user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileEditingCubit>(param1: _user),
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
}

class _SaveChangesButton extends StatelessWidget {
  const _SaveChangesButton();

  VoidCallback? _onSaveCallback(BuildContext context) {
    final canSave = context.watch<ProfileEditingCubit>().canSave;
    if (!canSave) return null;

    return () {
      final User user = context.read<ProfileEditingCubit>().state;
      context
        ..read<UserBloc>().add(UserEvent.updateUser(user))
        ..maybePop();
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
