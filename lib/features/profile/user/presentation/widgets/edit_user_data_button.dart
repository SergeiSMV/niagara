import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';

class EditUserDataButton extends StatelessWidget {
  const EditUserDataButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, state) => state.maybeWhen(
        orElse: SizedBox.shrink,
        loaded: (user) => InkWell(
          onTap: () {},
          child: Assets.icons.pen.svg(
            width: AppConst.kIconMedium,
            height: AppConst.kIconMedium,
          ),
        ),
      ),
    );
  }
}
