import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';

class EditUserDataButton extends StatelessWidget {
  const EditUserDataButton({super.key});

  void _goToEditPage(BuildContext context) {
    context.navigateTo(
      const EditProfileRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, state) => state.maybeWhen(
        orElse: SizedBox.shrink,
        loaded: (user) => InkWell(
          onTap: () => _goToEditPage(context),
          child: SizedBox(
            width: AppSizes.kGeneral48,
            height: AppSizes.kGeneral48,
            child: Assets.icons.pen.svg(
              width: AppSizes.kIconMedium,
              height: AppSizes.kIconMedium,
              fit: BoxFit.none,
            ),
          ),
        ),
      ),
    );
  }
}
