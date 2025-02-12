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
import 'package:niagara_app/features/catalog/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:niagara_app/features/catalog/presentation/widget/groups/group_button.dart';

class GroupsButtonsWidget extends StatefulWidget {
  const GroupsButtonsWidget({
    super.key,
    required this.group,
  });

  final Group group;

  @override
  State<GroupsButtonsWidget> createState() => _GroupsButtonsWidgetState();
}

class _GroupsButtonsWidgetState extends State<GroupsButtonsWidget> {
  late final ScrollController _scrollController;
  bool firstScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToInitalGroup(List<Group> groups) {
    firstScrolled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedIndex = groups.indexWhere((g) => g.id == widget.group.id);
      if (selectedIndex != -1 && _scrollController.hasClients) {
        if (selectedIndex == groups.length - 1) {
          /// Если последняя позиция, красивее будет сразу отмотать на максимум.
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          return;
        }

        const itemWidth = 80.0;
        const itemSpacing = 8.0;
        const leadingPadding = 16.0;
        final offset =
            leadingPadding + selectedIndex * (itemWidth + itemSpacing);
        _scrollController.jumpTo(
          offset.clamp(0, _scrollController.position.maxScrollExtent),
        );
      }
    });
  }

  void _navigateToAllGroups(BuildContext context) => context.navigateTo(
        CatalogWrapper(
          children: [
            const CatalogRoute(),
            CategoryWrapperRoute(
              group: widget.group,
              children: const [CategoryRoute()],
            ),
            const GroupsRoute(),
          ],
        ),
      );

  void _navigateToCategory(
    BuildContext context, {
    required Group group,
  }) =>
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
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (_, state) => state.maybeWhen(
        loaded: (groups) {
          /// Если текущая группа совпадает с выбранной изначально, то
          /// произойдет первый и последний скролл до неё (примерный рассчёт
          /// позиции).
          final current = context.read<ProductsBloc>().group;
          if (current.id == widget.group.id && !firstScrolled) {
            _scrollToInitalGroup(groups);
          }

          return SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: AppInsets.kVertical12,
              child: Row(
                children: [
              
                  /// категории то списком
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
                          padding:
                              AppInsets.kHorizontal12 + AppInsets.kVertical4,
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
              
                  /// категории товаров кнопками
                  ...List.generate(groups.length, (index) {
                    final hasCurrentGroup = groups[index].id == widget.group.id;
                    return GroupButton(
                        group: groups[index],
                        isSelected: hasCurrentGroup,
                        onTap: () => _navigateToCategory(context, group: groups[index]),
                      );
                  }),
                  AppBoxes.kWidth12,
                ],
              ),
            ),
          );
        },
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}
