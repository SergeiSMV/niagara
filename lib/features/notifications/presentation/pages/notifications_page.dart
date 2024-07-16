import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/no_internet_connection_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import 'package:niagara_app/features/notifications/presentation/widgets/all_notifications_widget.dart';
import 'package:niagara_app/features/notifications/presentation/widgets/no_notifications_widget.dart';
import 'package:niagara_app/features/notifications/presentation/widgets/notification_type_buttons_widget.dart';
import 'package:niagara_app/features/notifications/presentation/widgets/notification_warning_widget.dart';

/// Страница с уведомлениями
@RoutePage()
class NotificationsPage extends HookWidget {
  const NotificationsPage({super.key});

  void _onLoadMore(BuildContext context) => context
      .read<NotificationsBloc>()
      .add(const NotificationsEvent.loadMore());

  void _onRefresh(BuildContext context) => context
      .read<NotificationsBloc>()
      .add(const NotificationsEvent.loading(isForceUpdate: true));

  @override
  Widget build(BuildContext context) {
    context
        .read<NotificationsBloc>()
        .add(const NotificationsEvent.loading(isForceUpdate: true));

    final scrollController = useScrollController();

    useEffect(
      () {
        void onScroll() {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            _onLoadMore(context);
          }
        }

        scrollController.addListener(onScroll);
        return () => scrollController.removeListener(onScroll);
      },
      [scrollController],
    );

    return Scaffold(
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          final hasMore = context.read<NotificationsBloc>().hasMore;

          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBarWidget(title: t.notifications.notifications),
              const SliverAppBar(
                automaticallyImplyLeading: false,
                primary: false,
                expandedHeight: 30,
                titleSpacing: 0,
                title: NotificationTypeButtons(),
              ),
              const SliverToBoxAdapter(child: NotificationWarningWidget()),
              state.when(
                loading: () => const SliverToBoxAdapter(
                  child: AppCenterLoader(),
                ),
                loaded: (groupedNotifications, unreadNotifications, _) {
                  return groupedNotifications.isNotEmpty ||
                          unreadNotifications.isNotEmpty
                      ? SliverToBoxAdapter(
                          child: AllNotificationsWidget(
                            groupedNotifications: groupedNotifications,
                            unreadNotifications: unreadNotifications,
                          ),
                        )
                      : const SliverToBoxAdapter(
                          child: NoNotificationsWidget(),
                        );
                },
                noInternet: () => SliverToBoxAdapter(
                  child: NoInternetConnectionWidget(
                    onRefresh: () => _onRefresh(context),
                  ),
                ),
                error: () => SliverToBoxAdapter(
                  child: ErrorRefreshWidget(
                    onRefresh: () => _onRefresh(context),
                  ),
                ),
              ),
              state.maybeWhen(
                loaded: (groupedNotifications, unreadNotifications, __) {
                  return SliverToBoxAdapter(
                    child: groupedNotifications.isNotEmpty ||
                            unreadNotifications.isNotEmpty
                        ? Visibility(
                            visible: hasMore,
                            child: Padding(
                              padding: AppInsets.kAll16,
                              child: Center(
                                child: Assets.lottie.loadCircle.lottie(
                                  width: AppSizes.kLoaderBig,
                                  height: AppSizes.kLoaderBig,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  );
                },
                orElse: () => const SliverToBoxAdapter(),
              ),
            ],
          );
        },
      ),
    );
  }
}
