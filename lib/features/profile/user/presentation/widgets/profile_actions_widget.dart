import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

/// Виджет для отображения списка возможных действий на странице профиля с
/// разделителями.
class ProfileActionsWidget extends StatelessWidget {
  const ProfileActionsWidget({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: children.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (_, index) => children[index],
      separatorBuilder: (_, __) =>
          Divider(color: context.colors.otherColors.separator30),
    );
  }
}
