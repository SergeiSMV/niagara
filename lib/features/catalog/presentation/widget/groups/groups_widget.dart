import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyphenatorx/widget/texthyphenated.dart';
import '../../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../../core/common/presentation/widgets/app_network_image_widget.dart';
import '../../../../../core/common/presentation/widgets/errors/error_refresh_widget.dart';
import '../../../../../core/common/presentation/widgets/loaders/app_center_loader.dart';
import '../../../../../core/utils/constants/app_borders.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../../../domain/model/group.dart';
import '../../bloc/groups_cubit/groups_cubit.dart';

class GroupsWidget extends StatelessWidget {
  const GroupsWidget({super.key});

  Future<void> _onRefresh(BuildContext context) async =>
      context.read<GroupsCubit>().getGroups();

  Future<void> _navigateToCategory(
    BuildContext context, {
    required Group group,
  }) async =>
      context.navigateTo(
        CatalogWrapper(
          children: [
            const CatalogRoute(),
            CategoryWrapperRoute(
              group: group,
              children: const [CategoryRoute()],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => BlocBuilder<GroupsCubit, GroupsState>(
        builder: (context, state) => state.when(
          loading: AppCenterLoader.new,
          loaded: (groups) => Padding(
            padding: AppInsets.kAll16 + AppInsets.kBottom16,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: AppSizes.kGeneral8,
                crossAxisSpacing: AppSizes.kGeneral8,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: groups.length,
              itemBuilder: (_, index) => InkWell(
                onTap: () async => _navigateToCategory(
                  context,
                  group: groups[index],
                ),
                child: ClipRRect(
                  borderRadius: AppBorders.kCircular8,
                  child: ColoredBox(
                    color: context.colors.mainColors.bgCard,
                    child: Stack(
                      children: [
                        if (groups[index].image.length > AppSizes.kGeneral8)
                          AppNetworkImageWidget(url: groups[index].image),
                        Padding(
                          padding: AppInsets.kHorizontal8 + AppInsets.kTop6,
                          child: TextHyphenated(
                            groups[index].name,
                            LocaleSettings.currentLocale.languageCode,
                            style: context.textStyle.textTypo.tx3SemiBold
                                .withColor(context.colors.textColors.main),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          error: () => ErrorRefreshWidget(
            onRefresh: () async => _onRefresh(context),
          ),
        ),
      );
}
