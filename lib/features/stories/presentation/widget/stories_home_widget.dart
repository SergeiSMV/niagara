import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/stories/domain/model/story.dart';
import 'package:niagara_app/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:niagara_app/features/stories/presentation/widget/story_preview_widget.dart';

class StoriesHomeWidget extends StatelessWidget {
  const StoriesHomeWidget({super.key});

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
                  padding: AppInsets.kLeft16,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final Story story = stories[index];
                      return InkWell(
                        onTap: () {},
                        child: StoryPreviewWidget(
                          title: story.title,
                          seen: story.open,
                          imageUrl: story.image,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount: stories.length,
                  ),
                ),
              );
            });
      },
    );
  }
}
