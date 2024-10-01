import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/profile_widget/bonuses_profile_widget.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';
import 'package:niagara_app/features/profile/user/presentation/widgets/account/edit_user_data_button.dart';
import 'package:niagara_app/features/profile/user/presentation/widgets/account/profile_account_actions_widget.dart';
import 'package:niagara_app/features/profile/user/presentation/widgets/account/profile_user_data_widget.dart';
import 'package:niagara_app/features/profile/user/presentation/widgets/app_info_widget.dart';
import 'package:niagara_app/features/profile/user/presentation/widgets/banners_widget.dart';
import 'package:niagara_app/features/profile/user/presentation/widgets/profile_info/profile_info_widget.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.mainColors.bgCard,
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(
            automaticallyImplyLeading: false,
            automaticallyImplyTitle: false,
            body: ProfileUserDataWidget(),
            actions: [
              EditUserDataButton(),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const BonusesProfileWidget(),
              BlocBuilder<UserBloc, UserState>(
                builder: (_, state) => state.maybeWhen(
                  loaded: (_) => const Column(
                    children: [
                      ProfileInfoWidget(),
                      BannersWidget(),
                      AppInfoWidget(),
                      ProfileAccountActionsWidget(),
                      // TODO: Версия приложения на данный момент захардкожена
                      // AppVersionWidget(),
                    ],
                  ),
                  unauthorized: (_) => const Column(
                    children: [
                      BannersWidget(),
                      AppInfoWidget(),
                      ProfileAccountActionsWidget(),
                      AppBoxes.kHeight16,
                      // TODO: Версия приложения на данный момент захардкожена
                      // AppVersionWidget(),
                    ],
                  ),
                  orElse: SizedBox.shrink,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
