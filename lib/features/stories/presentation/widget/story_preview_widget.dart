import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

/// Виджет для отображения квадратного закрулённого блока-превью сториз.
class StoryPreviewWidget extends StatelessWidget {
  const StoryPreviewWidget({
    super.key,
    this.imageUrl,
    required this.title,
    required this.seen,
  });

  /// Ссылка на превью-изображение.
  final String? imageUrl;

  /// Заголовок сториз.
  final String title;

  /// Индикатор просмотра сториз.
  final bool seen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 94,
      height: 94,
      child: Stack(
        children: [
          // Image with the background linear gradient.
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: seen
                    ? context.colors.fieldBordersColors.focus
                    : context.colors.mainColors.accent,
              ),
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF52B0CE),
                    Color(0xFF00348F),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: SizedBox.expand(
                child: imageUrl?.isNotEmpty ?? false
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: ExtendedImage.network(
                          // TODO: убрать это!
                          imageUrl!.replaceAll('stpries', 'stories'),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
          // Title of the story.
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Text(
              title,
              style: context.textStyle.textTypo.tx4Medium
                  .withColor(context.colors.textColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
