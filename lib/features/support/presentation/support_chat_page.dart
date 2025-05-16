import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/common/presentation/widgets/errors/error_refresh_widget.dart';
import '../../../core/common/presentation/widgets/loaders/app_center_loader.dart';
import '../../../core/utils/gen/strings.g.dart';
import 'support_cubit.dart';

/// Страница с чатом службы поддержки.
@RoutePage()
class SupportChatPage extends StatefulWidget {
  const SupportChatPage({Key? key}) : super(key: key);

  @override
  State<SupportChatPage> createState() => _SupportChatPageState();
}

class _SupportChatPageState extends State<SupportChatPage> {
  InAppWebViewController? _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(t.profile.appInfo.support),
        ),
        body: BlocBuilder<SupportCubit, SupportChatState>(
          builder: (context, state) {
            final cubit = context.read<SupportCubit>();
            final chatUrl = cubit.chatUrl;

            // Пока кубит загружается (состояния `notInitialized`, `loading` или
            // нет chatUrl), показываем лоадер.
            if (chatUrl == null || !state.isReady) {
              return const AppCenterLoader();
            } else if (state.isError) {
              // Если произошла ошибка, то показываем кнопку для повторной
              // попытки.
              return ErrorRefreshWidget(
                onRefresh: cubit.getUserCredentials,
              );
            }

            return InAppWebView(
              initialUrlRequest: URLRequest(url: chatUrl),
              onWebViewCreated: (controller) async {
                _controller = controller;
                cubit.onControllerReady(controller);
              },
              initialSettings: InAppWebViewSettings(
                mediaPlaybackRequiresUserGesture: false,
                supportZoom: false,
              ),
            );
          },
        ),
      );
}
