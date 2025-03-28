import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'loaders/app_center_loader.dart';

/// Виджет для отображения изображения из сети.
class AppNetworkImageWidget extends StatelessWidget {
  const AppNetworkImageWidget({
    required this.url,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.whiteLoader = false,
    super.key,
  });

  /// URL изображения.
  final String url;

  /// Тип масштабирования изображения.
  final BoxFit fit;

  /// Высота изображения.
  final double? height;

  /// Ширина изображения.
  final double? width;

  /// Флаг для отображения белого лоадера.
  final bool whiteLoader;

  @override
  Widget build(BuildContext context) => ExtendedImage.network(
        url,
        fit: fit,
        height: height,
        width: width,
        loadStateChanged: (state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return AppCenterLoader(isWhite: whiteLoader);
            case LoadState.completed:
              return state.completedWidget;
            case LoadState.failed:
              return const Center(
                child: Icon(Icons.error_outline),
              );
          }
        },
      );
}
