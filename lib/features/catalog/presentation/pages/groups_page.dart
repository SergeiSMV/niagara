import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/catalog/presentation/cubit/groups_cubit.dart';

@RoutePage()
class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  void _onRefresh(BuildContext context) =>
      context.read<GroupsCubit>().getGroups();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: BlocBuilder<GroupsCubit, GroupsState>(
        builder: (_, state) => state.when(
          loading: AppCenterLoader.new,
          loaded: (groups) => ListView.separated(
            itemCount: groups.length,
            itemBuilder: (_, index) => ListTile(
              title: Text(
                groups[index].name,
                style: context.textStyle.textTypo.tx1SemiBold
                    .withColor(context.colors.textColors.main),
              ),
              onTap: () {},
            ),
            separatorBuilder: (_, __) => const Divider(),
          ),
          error: () => ErrorRefreshWidget(
            error: t.common.commonError,
            onRefresh: () => _onRefresh(context),
          ),
        ),
      ),
    );
  }
}
