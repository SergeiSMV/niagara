import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';

class EditUserDataButton extends StatelessWidget {
  const EditUserDataButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, state) => state.maybeWhen(
        orElse: SizedBox.shrink,
        loaded: _EditButton.new,
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton(this.user);

  final User user;

  void _goToEditPage(BuildContext context, User user) {
    context.navigateTo(
      EditProfileRoute(user: user),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _goToEditPage(context, user),
      child: SizedBox(
        width: AppSizes.kGeneral48,
        height: AppSizes.kGeneral48,
        child: Assets.icons.pen.svg(
          width: AppSizes.kIconMedium,
          height: AppSizes.kIconMedium,
          fit: BoxFit.none,
        ),
      ),
    );
  }
}
