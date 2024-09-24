import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/groups_cubit/groups_cubit.dart';
import 'package:niagara_app/features/catalog/presentation/widget/groups/group_button.dart';

class GroupsButtonsWidget extends StatelessWidget {
  const GroupsButtonsWidget({
    super.key,
    required this.group,
  });

  final Group group;

  void _navigateToAllGroups(BuildContext context) => context.navigateTo(
        CatalogWrapper(
          children: [
            const CatalogRoute(),
            CategoryWrapperRoute(
              group: group,
              children: const [CategoryRoute()],
            ),
            const GroupsRoute(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (_, state) => state.maybeWhen(
        loaded: (groups) => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: AppInsets.kVertical12,
            child: Row(
              children: [
                Padding(
                  padding: AppInsets.kHorizontal4 + AppInsets.kLeft12,
                  child: InkWell(
                    onTap: () => _navigateToAllGroups(context),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: AppBorders.kCircular6,
                        color: context.colors.mainColors.bgCard,
                      ),
                      child: Padding(
                        padding: AppInsets.kHorizontal12 + AppInsets.kVertical4,
                        child: Assets.icons.list.svg(
                          width: AppSizes.kIconLarge,
                          height: AppSizes.kIconLarge,
                          colorFilter: ColorFilter.mode(
                            context.colors.textColors.main,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ...List.generate(groups.length, (index) {
                  final hasCurrentGroup = groups[index].id == group.id;
                  return GroupButton(
                    group: groups[index],
                    isSelected: hasCurrentGroup,
                  );
                }),
                AppBoxes.kWidth12,
              ],
            ),
          ),
        ),
        orElse: SizedBox.shrink,
      ),
    );
  }
}
