import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/groups_cubit/groups_cubit.dart';
import 'package:niagara_app/features/locations/cities/presentation/widgets/list_separator_widget.dart';

@RoutePage()
class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  void _onRefresh(BuildContext context) =>
      context.read<GroupsCubit>().getGroups();

  void _navigateToCategory(
    BuildContext context, {
    required Group group,
  }) =>
      context.navigateTo(
        CategoryWrapperRoute(
          group: group,
          children: const [CategoryRoute()],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(),
          SliverToBoxAdapter(
            child: BlocBuilder<GroupsCubit, GroupsState>(
              builder: (_, state) => state.when(
                loading: AppCenterLoader.new,
                loaded: (groups) => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: groups.length,
                  itemBuilder: (_, index) => ListTile(
                    title: Text(
                      groups[index].name,
                      style: context.textStyle.textTypo.tx1SemiBold
                          .withColor(context.colors.textColors.main),
                    ),
                    trailing: Assets.icons.arrowRight.svg(
                      width: AppSizes.kIconMedium,
                      height: AppSizes.kIconMedium,
                    ),
                    onTap: () => _navigateToCategory(
                      context,
                      group: groups[index],
                    ),
                  ),
                  separatorBuilder: (_, __) => const ListSeparatorWidget(),
                ),
                error: () => ErrorRefreshWidget(
                  onRefresh: () => _onRefresh(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
