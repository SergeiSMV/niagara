import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';

class PaymentMethodsListWidget extends StatelessWidget {
  const PaymentMethodsListWidget({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: children.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (_, index) => children[index],
      separatorBuilder: (_, __) => AppBoxes.kHeight8,
    );
  }
}
