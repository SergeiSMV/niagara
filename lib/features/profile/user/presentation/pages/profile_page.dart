import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../bonuses/presentation/widgets/profile_widget/bonuses_profile_widget.dart';
import '../bloc/user_bloc.dart';
import '../widgets/account/edit_user_data_button.dart';
import '../widgets/account/profile_account_actions_widget.dart';
import '../widgets/account/profile_user_data_widget.dart';
import '../widgets/app_info_widget.dart';
import '../widgets/app_version_widget.dart';
import '../widgets/banners_widget.dart';
import '../widgets/profile_info/profile_info_widget.dart';

/// Страница профиля пользователя ("Профиль")
@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
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
                        AppVersionWidget(),
                      ],
                    ),
                    unauthorized: (_) => const Column(
                      children: [
                        BannersWidget(),
                        AppInfoWidget(),
                        AppBoxes.kHeight24,
                        AppVersionWidget(),
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
