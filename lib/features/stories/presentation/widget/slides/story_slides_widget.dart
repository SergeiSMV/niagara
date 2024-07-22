import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/features/stories/domain/model/story.dart';
import 'package:niagara_app/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:niagara_app/features/stories/presentation/widget/slides/story_slide_widget.dart';
import 'package:story/story.dart';

class StorySlidesWidget extends StatelessWidget {
  const StorySlidesWidget({super.key, required this.initialIndex});

  final int initialIndex;

  void _onPageChanged(String id, BuildContext context) {
    context.read<StoriesBloc>().add(StoriesEvent.markSeen(id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoriesBloc, StoriesState>(
      builder: (_, state) => state.map(
        loading: (_) => const SizedBox.shrink(),
        error: (_) => const SizedBox.shrink(),
        loaded: (state) {
          final List<Story> stories = state.stories;

          return Scaffold(
            body: StoryPageView(
              initialPage: initialIndex,
              indicatorDuration: const Duration(seconds: 15),
              onPageLimitReached: context.router.maybePop,
              onPageChanged: (index) =>
                  _onPageChanged(stories[index].id, context),
              indicatorPadding: AppInsets.kTop48 + AppInsets.kHorizontal16,
              storyLength: (index) => stories[index].slides.length,
              pageLength: stories.length,
              itemBuilder: (context, pageIndex, storyIndex) {
                return StorySlideWidget(
                  slide: stories[pageIndex].slides[storyIndex],
                );
              },
              // Создаёт кнопку для закрытия истории отдельным слоем.
              //
              // Кнопка вынесена сюда, т.к. весь [StorySlideWidget] будет
              // завёрнут в [GestureDetector], перехватывающий все нажатия для
              // перехода между слайдам и паузой.
              gestureItemBuilder: (context, pageIndex, storyIndex) {
                // TODO: Кнопка с действием внизу слайда и описание к ней тоже
                // должны быть в этом слое, т.к. им тоже нужно считывать нажатие
                //
                // Нужно рассчитывать размеры кнопки с описанием и делать отступ
                // от низа экрана в [StorySlideWidget].
                return const StoryGestureOverlay();
              },
            ),
          );
        },
      ),
    );
  }
}

/// Виджет, создающий все требующие обработки жестов элементы сториз.
class StoryGestureOverlay extends StatelessWidget {
  const StoryGestureOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: AppInsets.kTop48 + AppInsets.kTop8,
        child: IconButton(
          padding: EdgeInsets.zero,
          color: context.colors.mainColors.white,
          icon: const Icon(
            Icons.close,
            size: AppSizes.kGeneral24,
          ),
          onPressed: context.router.maybePop,
        ),
      ),
    );
  }
}
