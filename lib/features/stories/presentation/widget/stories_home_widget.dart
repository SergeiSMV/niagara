import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/stories/domain/model/story.dart';
import 'package:niagara_app/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:niagara_app/features/stories/presentation/widget/story_preview_widget.dart';

class StoriesHomeWidget extends StatelessWidget {
  const StoriesHomeWidget({super.key});

  void _onTap(BuildContext context, int index, String id) {
    context.pushRoute(StorySlidesWrapper(index: index));
    context.read<StoriesBloc>().add(StoriesEvent.markSeen(id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoriesBloc, StoriesState>(
      builder: (context, state) {
        final List<Story> stories = state.maybeMap(
          loaded: (state) => state.stories,
          orElse: () => const [],
        );

        if (stories.isEmpty) return const SizedBox.shrink();

        return state.map(
          loading: (_) => const SizedBox.shrink(),
          error: (_) => const SizedBox.shrink(),
          loaded: (state) {
            return SizedBox(
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
            );
          },
        );
      },
    );
  }
}
