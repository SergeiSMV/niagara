import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/package/package_info_cubit.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageDataCubit, PackageData?>(
      builder: (context, state) => state != null
          ? Padding(
              padding: AppInsets.kBottom32,
              child: Column(
                children: [
                  Text(
                    t.profile.appInfo.appVersion(version: state.fullVersion),
                    style: context.textStyle.textTypo.tx3Medium.withColor(
                      context.colors.textColors.secondary,
                    ),
                  ),
                  AppBoxes.kHeight16,
                  Assets.images.companyLogo.image(),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
