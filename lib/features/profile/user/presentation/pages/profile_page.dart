import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/profile_widget/bonuses_profile_widget.dart';
import 'package:niagara_app/features/profile/user/presentation/widgets/edit_user_data_button.dart';
import 'package:niagara_app/features/profile/user/presentation/widgets/profile_user_data_widget.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        automaticallyImplyLeading: false,
        automaticallyImplyTitle: false,
        body: const ProfileUserDataWidget(),
        actions: [
          const EditUserDataButton(),
          AppConst.kCommon8.horizontalBox,
        ],
      ),
      backgroundColor: context.colors.mainColors.bgCard,
      body: const Column(
        children: [
          BonusesProfileWidget(),
        ],
      ),
    );
  }
}
