import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';

class ProfileUserDataWidget extends StatelessWidget {
  const ProfileUserDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, state) => state.maybeWhen(
        loaded: (user) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name.isNotEmpty
                  ? t.profile.helloUser(name: user.name)
                  : t.profile.letsGetAcquainted,
              style: context.textStyle.textTypo.tx1Medium
                  .withColor(context.colors.textColors.main),
            ),
            Text(
              user.phone.phoneFormat(),
              style: context.textStyle.textTypo.tx3Medium
                  .withColor(context.colors.textColors.secondary),
            ),
          ],
        ),
        unauthorized: (_) => Center(child: Text(t.routes.profile)),
        orElse: SizedBox.shrink,
      ),
    );
  }
}
