import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/groups_cubit/groups_cubit.dart';

class GroupsWidget extends StatelessWidget {
  const GroupsWidget({super.key});

  void _onRefresh(BuildContext context) =>
      context.read<GroupsCubit>().getGroups();

  void _navigateToCategory(
    BuildContext context, {
    required Group group,
  }) =>
      context.navigateTo(
        CatalogWrapper(
          children: [
            const CatalogRoute(),
            CategoryRoute(group: group),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (ctx, state) => state.when(
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
            itemCount: groups.length,
            itemBuilder: (_, index) => InkWell(
              onTap: () => _navigateToCategory(
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
                        CachedNetworkImage(
                          imageUrl: groups[index].image,
                          errorWidget: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      Padding(
                        padding: AppInsets.kHorizontal8 + AppInsets.kTop6,
                        child: Text(
                          groups[index].name,
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
          error: t.common.commonError,
          onRefresh: () => _onRefresh(ctx),
        ),
      ),
    );
  }
}
