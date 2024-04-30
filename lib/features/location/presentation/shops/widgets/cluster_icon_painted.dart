import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

/// Класс для отрисовки кластеров на карте
class ClusterIconPainter {
  const ClusterIconPainter(this.clusterSize);

  /// Количество маркеров в кластере
  final int clusterSize;

  /// Метод, который формирует фигуру кластера
  /// и преобразует ее в байтовый формат
  Future<Uint8List> getClusterIconBytes(BuildContext context) async {
    const size = Size(150, 150);
    final recorder = PictureRecorder();

    // отрисовка маркера
    _paintTextCountPlacemarks(
      context,
      text: clusterSize.toString(),
      size: size,
      canvas: _paintCirclePlacemark(
        context,
        size: size,
        recorder: recorder,
      ),
    );

    // преобразование в байтовый формат
    final image = await recorder.endRecording().toImage(
          size.width.toInt(),
          size.height.toInt(),
        );
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }

  /// Метод, который отрисовывает фигуру кластера (фон и обводка)
  Canvas _paintCirclePlacemark(
    BuildContext context, {
    required Size size,
    required PictureRecorder recorder,
  }) {
    final canvas = Canvas(recorder);

    final radius = size.height / 2.15;

    // внутренний круг - закрашенная часть маркера
    final fillPaint = Paint()
      ..color = context.colors.mainColors.white
      ..style = PaintingStyle.fill;

    // внешний круг - обводка маркера
    final strokePaint = Paint()
      ..color = context.colors.buttonColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final circleOffset = Offset(size.height / 2, size.width / 2);

    canvas
      ..drawCircle(circleOffset, radius, fillPaint)
      ..drawCircle(circleOffset, radius, strokePaint);
    return canvas;
  }

  /// Метод, который отрисовывает текст,
  /// отображающий количество маркеров в кластере
  void _paintTextCountPlacemarks(
    BuildContext context, {
    required String text,
    required Size size,
    required Canvas canvas,
  }) {
    // внешний вид текста, отображающего количество маркеров в кластере
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: context.textStyle.headingTypo.h1.withColor(
          context.colors.mainColors.primary,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);

    // смещение текста
    // необходимо для размещения текста по центру кластера
    final textOffset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, textOffset);
  }
}
