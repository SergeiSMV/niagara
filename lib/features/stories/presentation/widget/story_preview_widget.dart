import 'package:flutter/material.dart';

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
    return Stack(
      children: [
        SizedBox(
          width: 92,
          height: 92,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(width: 2, color: Colors.red),
            ),
            child: Center(
              child: SizedBox(
                width: 90,
                height: 90,
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
                  child: imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
