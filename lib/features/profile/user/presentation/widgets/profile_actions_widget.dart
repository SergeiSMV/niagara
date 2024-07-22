import 'package:flutter/material.dart';

/// Виджет для отображения списка возможных действий на странице профиля с
/// разделителями.
class ProfileActionsWidget extends StatelessWidget {
  const ProfileActionsWidget({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) => children[index],
      separatorBuilder: (_, __) => const Divider(
        indent: 20,
        endIndent: 20,
      ),
      itemCount: children.length,
      shrinkWrap: true,
    );
  }
}
