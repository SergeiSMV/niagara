import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';

enum NipPosition { left, right, top, bottom }

class AppTooltip extends StatelessWidget {
  const AppTooltip({
    required this.child,
    this.radius = AppSizes.kGeneral8,
    this.offset = AppSizes.kGeneral16,
    this.nipSize = AppSizes.kGeneral6,
    this.nipPosition = NipPosition.right,
    super.key,
  });

  final Widget child;

  final double radius;
  final double nipSize;
  final double offset;
  final NipPosition nipPosition;

  Color get _color => const Color(0xFF2F3036); // кастомный цвет

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      clipper: _ChatBubbleClipper(
        radius: radius,
        offset: offset,
        nipSize: nipSize,
        nipPosition: nipPosition,
      ),
      color: _color,
      child: Container(
        padding: _getPadding(),
        margin: AppInsets.kAll12,
        color: _color,
        child: child,
      ),
    );
  }

  EdgeInsets _getPadding() => switch (nipPosition) {
        NipPosition.left => EdgeInsets.only(left: nipSize),
        NipPosition.top => EdgeInsets.only(top: nipSize),
        NipPosition.right => EdgeInsets.only(right: nipSize),
        NipPosition.bottom => EdgeInsets.only(bottom: nipSize),
      };
}

class _ChatBubbleClipper extends CustomClipper<Path> {
  _ChatBubbleClipper({
    required this.nipPosition,
    required this.radius,
    required this.offset,
    required this.nipSize,
  });

  final double radius;
  final double nipSize;
  final double offset;
  final NipPosition nipPosition;

  @override
  Path getClip(Size size) {
    final path = Path();
    final radius = Radius.circular(this.radius);

    switch (nipPosition) {
      case NipPosition.left:
        path.addRRect(
          RRect.fromLTRBR(nipSize, 0, size.width, size.height, radius),
        );
        final path2 = Path()
          ..moveTo(nipSize, size.height / AppSizes.kGeneral2 - nipSize)
          ..lineTo(0, size.height / AppSizes.kGeneral2)
          ..lineTo(nipSize, size.height / AppSizes.kGeneral2 + nipSize)
          ..close();
        path.addPath(path2, Offset.zero);

      case NipPosition.right:
        path.addRRect(
          RRect.fromLTRBR(0, 0, size.width - nipSize, size.height, radius),
        );
        final path2 = Path()
          ..moveTo(
            size.width - nipSize,
            size.height / AppSizes.kGeneral2 - nipSize,
          )
          ..lineTo(size.width, size.height / AppSizes.kGeneral2)
          ..lineTo(
            size.width - nipSize,
            size.height / AppSizes.kGeneral2 + nipSize,
          )
          ..close();
        path.addPath(path2, Offset.zero);

      case NipPosition.top:
        path.addRRect(
          RRect.fromLTRBR(0, nipSize, size.width, size.height, radius),
        );
        final path2 = Path()
          ..moveTo(size.width / AppSizes.kGeneral2 - nipSize, nipSize)
          ..lineTo(size.width / AppSizes.kGeneral2, 0)
          ..lineTo(size.width / AppSizes.kGeneral2 + nipSize, nipSize)
          ..close();
        path.addPath(path2, Offset.zero);

      case NipPosition.bottom:
        path.addRRect(
          RRect.fromLTRBR(0, 0, size.width, size.height - nipSize, radius),
        );
        final path2 = Path()
          ..moveTo(
            size.width / AppSizes.kGeneral2 - nipSize,
            size.height - nipSize,
          )
          ..lineTo(size.width / AppSizes.kGeneral2, size.height)
          ..lineTo(
            size.width / AppSizes.kGeneral2 + nipSize,
            size.height - nipSize,
          )
          ..close();
        path.addPath(path2, Offset.zero);
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    if (oldClipper is! _ChatBubbleClipper) return true;
    return oldClipper.nipPosition != nipPosition ||
        oldClipper.radius != radius ||
        oldClipper.nipSize != nipSize ||
        oldClipper.offset != offset;
  }
}
