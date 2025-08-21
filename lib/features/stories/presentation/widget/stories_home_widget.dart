import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../domain/model/story.dart';
import '../bloc/stories_bloc.dart';
import 'story_preview_widget.dart';

/// Виджет для отображения историй на главной странице
class StoriesHomeWidget extends StatelessWidget {
  const StoriesHomeWidget({super.key});

  /// Переход на страницу истории с отметкой о просмотре
  Future<void> _onTap(BuildContext context, int index, String id) async {
    await context.pushRoute(StorySlidesWrapper(index: index));
    context.read<StoriesBloc>().add(StoriesEvent.markSeen(id));
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<StoriesBloc, StoriesState>(
        builder: (context, state) {
          final List<Story> stories = state.maybeMap(
            loaded: (state) => state.stories,
            orElse: () => const [],
          );

          if (stories.isEmpty) return const SizedBox.shrink();

          return state.map(
            loading: (_) => const SizedBox.shrink(),
            error: (_) => const SizedBox.shrink(),
            loaded: (state) => SizedBox(
              width: double.infinity,
              child: Padding(
                padding: AppInsets.kTop32,
                child: SizedBox(
                  height: 98,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: stories.length,
                    padding: AppInsets.kHorizontal16,
                    separatorBuilder: (_, __) => AppBoxes.kWidth8,
                    itemBuilder: (context, index) {
                      final Story story = stories[index];
                      return InkWell(
                        onTap: () => _onTap(context, index, story.id),
                        child: StoryPreviewWidget(
                          title: story.title,
                          seen: story.open,
                          imageUrl: story.image,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      );
}
