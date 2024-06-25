import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/draggable_pin_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/modal_background_widget.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_history_cubit/bonuses_history_cubit.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/history/bonus_history_tile.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/history/modal_static_header.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/history/no_bonuses_widget.dart';

class BonusesHistoryWidget extends HookWidget {
  const BonusesHistoryWidget({super.key});

  void _loadMore(BuildContext context) =>
      context.read<BonusesHistoryCubit>().loadMore();

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(
      () {
        void onScroll() {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            _loadMore(context);
          }
        }

        scrollController.addListener(onScroll);

        return () => scrollController.removeListener(onScroll);
      },
      [scrollController],
    );

    return BlocProvider(
      create: (_) => getIt<BonusesHistoryCubit>(),
      child: BlocConsumer<BonusesHistoryCubit, BonusesHistoryState>(
        listener: (_, state) => state.maybeWhen(
          orElse: () => null,
          error: () => context.maybePop(),
        ),
        builder: (_, state) => state.maybeWhen(
          loading: AppCenterLoader.new,
          loaded: (bonusesHistory, hasMore) => ModalBackgroundWidget(
            child: Column(
              children: [
                const PinWidget(),
                const ModalStaticHeader(),
                if (bonusesHistory.isNotEmpty)
                  Column(
                    children: [
                      Flexible(
                        child: ListView.separated(
                          controller: scrollController,
                          itemCount: bonusesHistory.length,
                          itemBuilder: (_, index) => BonusHistoryTile(
                            title: bonusesHistory[index].info,
                            date: bonusesHistory[index].date,
                            count: bonusesHistory[index].value,
                            isTemp: bonusesHistory[index].isTemp,
                          ),
                          separatorBuilder: (_, __) => Divider(
                            height: 0,
                            color: context.colors.otherColors.separator30,
                            thickness: AppSizes.kGeneral1,
                          ),
                        ),
                      ),
                      if (hasMore)
                        Assets.lottie.loadCircle.lottie(
                          width: AppSizes.kGeneral32,
                          height: AppSizes.kGeneral32,
                          repeat: true,
                        ),
                    ],
                  )
                else
                  const NoBonusesWidget(),
              ],
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
