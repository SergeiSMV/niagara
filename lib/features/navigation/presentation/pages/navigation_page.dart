import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/common/presentation/widgets/navigation_bar.dart';
import '../../../../core/dependencies/di.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../authorization/phone_auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import '../../../authorization/phone_auth/presentation/bloc/validate_phone_cubit/validate_phone_cubit.dart';
import '../../../cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import '../../../cart/cart/presentation/bloc/check_promo_code_cubit/check_promo_code_cubit.dart';
import '../../../cart/favorites/presentation/bloc/favorites_bloc.dart';
import '../../../catalog/presentation/bloc/groups_cubit/groups_cubit.dart';
import '../../../equipment/presentation/bloc/equipments_bloc/equipments_bloc.dart';
import '../../../new_products/presentation/bloc/new_products_bloc.dart';
import '../../../notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import '../../../notifications/presentation/bloc/permission_cubit.dart/notification_permission_cubit.dart';
import '../../../order_history/presentation/bloc/orders_bloc/orders_bloc.dart';
import '../../../profile/user/presentation/bloc/user_bloc.dart';
import '../../../promotions/presentation/cubit/promotions_cubit.dart';
import '../../../special_poducts/presentation/bloc/special_products_bloc.dart';
import '../../../stories/presentation/bloc/stories_bloc.dart';
import '../../../support/presentation/bloc/support_chat_cubit/support_chat_cubit.dart';
import '../widgets/notification_state_handler.dart';
import 'auth_check_wrapper.dart';

/// Страница [NavigationPage] для внутренней навигации в приложении.
///
/// Содержит в себе все основные маршруты приложения.
@RoutePage()
class NavigationPage extends StatelessWidget implements AutoRouteWrapper {
  const NavigationPage({super.key});

  static List<PageRouteInfo> get _routes => [
        const HomeRoute(),
        const CatalogRoute(),
        const CartRoute(),
        const EmptyNavigatorRoute(),
        const ProfileRoute(),
      ];

  static Map<int, PageRouteInfo> get _fullScreenTabs => {
        3: const LocationsWrapper(
          children: [
            LocationsTabRoute(children: [ShopsRoute()]),
          ],
        ),
      };

  /// Отображает кнопку с логами.
  Future<void> showLogsButton(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TalkerScreen(
          talker: getIt<Talker>(),
        ),
      ),
    );
  }

  /// Слушает изменения в статусе уведомлений.
  ///
  /// Используется для отловки перехода в приложение через push-уведомление
  void _notificationsListener(BuildContext context, NotificationsState state) =>
      state.whenOrNull(
        openedFromPush: () async => context.navigateTo(
          const NotificationsRoute(),
        ),
        openedProductFromPush: (productId, productName) async {
          await NotificationStateHandler().openedProductFromPushHandler(
            context,
            productId,
            productName,
          );
          return null;
        },
        openedProductGroupFromPush: (groupId) async {
          await NotificationStateHandler().openedProductGroupFromPushHandler(
            context,
            groupId,
          );
          return null;
        },
        openedCallFromPush: (phoneNumber) async {
          await NotificationStateHandler().openedCallFromPushHandler(
            context,
            phoneNumber,
          );
          return null;
        },
        openedGetRatingFromPush: (orderID) async {
          await NotificationStateHandler().openedGetRatingFromPushHandler(
            context,
            orderID,
          );
          return null;
        },
      );

  /// Переводит пользователя на экран ввода кода подтверждения.
  Future<void> _navigateToOTPListener(
    BuildContext context,
    AuthState state,
  ) async {
    state.maybeWhen(
      getCode: (phoneNumber) async {
        final test = ModalRoute.of(context);
        final current = test?.isCurrent ?? false;

        // Если поверх маршрута навигации открыт маршрут авторизации (например,
        // на главной странице виджет авторизации открывает AuthRoute), то не
        // нужно ничего делать.
        if (!current) return;

        context.navigateTo(OTPRoute(phoneNumber: phoneNumber));
      },
      orElse: () => null,
    );
  }

  @override
  Widget build(BuildContext context) => AuthCheckWrapper(
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listener: _navigateToOTPListener,
            ),
            BlocListener<NotificationsBloc, NotificationsState>(
              listener: _notificationsListener,
            ),
          ],
          child: AutoTabsScaffold(
            routes: _routes,
            extendBodyBehindAppBar: true,
            bottomNavigationBuilder: (_, tabsRouter) =>
                BottomNavigationBarWidget(
              tabsRouter: tabsRouter,
              fullScreenTabs: _fullScreenTabs,
            ),
            floatingActionButton: AppConstants.kDebugMode
                ? FloatingActionButton(
                    child: const Icon(Icons.bug_report),
                    onPressed: () async => showLogsButton(context),
                  )
                : null,
          ),
        ),
      );

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<GroupsCubit>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<PromotionsCubit>(param1: false),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<FavoritesBloc>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<NotificationsBloc>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<NotificationPermissionCubit>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<CartBloc>(),
            lazy: false,
          ),
          BlocProvider(
            // ignore: discarded_futures
            create: (_) => getIt<SupportChatCubit>()..getUserCredentials(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<CheckPromoCodeCubit>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<OrdersBloc>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<UserBloc>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<NewProductsBloc>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<SpecialProductsBloc>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<StoriesBloc>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => getIt<EquipmentsBloc>(),
            lazy: false,
          ),
          BlocProvider.value(value: getIt<AuthBloc>()),
          BlocProvider(create: (_) => getIt<ValidatePhoneCubit>()),
        ],
        child: this,
      );
}
