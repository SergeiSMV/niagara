import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';

enum NipPosition { left, right, top, bottom }

class AppTooltip extends StatelessWidget {
  const AppTooltip({
    required this.child,
    this.radius = AppConst.kCommon8,
    this.offset = AppConst.kCommon16,
    this.nipSize = AppConst.kCommon6,
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
        margin: AppConst.kCommon12.all,
        color: _color,
        child: child,
      ),
    );
  }

  EdgeInsets _getPadding() => switch (nipPosition) {
        NipPosition.left => nipSize.left,
        NipPosition.top => nipSize.top,
        NipPosition.right => nipSize.right,
        NipPosition.bottom => nipSize.bottom,
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
          ..moveTo(nipSize, size.height / AppConst.kCommon2 - nipSize)
          ..lineTo(0, size.height / AppConst.kCommon2)
          ..lineTo(nipSize, size.height / AppConst.kCommon2 + nipSize)
          ..close();
        path.addPath(path2, Offset.zero);

      case NipPosition.right:
        path.addRRect(
          RRect.fromLTRBR(0, 0, size.width - nipSize, size.height, radius),
        );
        final path2 = Path()
          ..moveTo(
            size.width - nipSize,
            size.height / AppConst.kCommon2 - nipSize,
          )
          ..lineTo(size.width, size.height / AppConst.kCommon2)
          ..lineTo(
            size.width - nipSize,
            size.height / AppConst.kCommon2 + nipSize,
          )
          ..close();
        path.addPath(path2, Offset.zero);

      case NipPosition.top:
        path.addRRect(
          RRect.fromLTRBR(0, nipSize, size.width, size.height, radius),
        );
        final path2 = Path()
          ..moveTo(size.width / AppConst.kCommon2 - nipSize, nipSize)
          ..lineTo(size.width / AppConst.kCommon2, 0)
          ..lineTo(size.width / AppConst.kCommon2 + nipSize, nipSize)
          ..close();
        path.addPath(path2, Offset.zero);

      case NipPosition.bottom:
        path.addRRect(
          RRect.fromLTRBR(0, 0, size.width, size.height - nipSize, radius),
        );
        final path2 = Path()
          ..moveTo(
            size.width / AppConst.kCommon2 - nipSize,
            size.height - nipSize,
          )
          ..lineTo(size.width / AppConst.kCommon2, size.height)
          ..lineTo(
            size.width / AppConst.kCommon2 + nipSize,
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
