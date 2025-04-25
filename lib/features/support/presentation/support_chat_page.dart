import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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

  // TODO: Убрать тестовые данные
  // final String userToken = 'user_12345';
  // final String userToken =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Imt2Ynlrb3YifQ.ojMIihEf548oJ_t0LRYx8Tdm8rDaNATPWwIrC2mrawY';
  // final String userName = 'Холдер Токена';
  // final String userEmail = 'ivan@example.com';
  // final String userPhone = '+12345678901';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(t.profile.appInfo.support),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.refresh),
          //     onPressed: () async {
          //       await _controller?.reload();
          //     },
          //   ),
          //   IconButton(
          //     icon: const Icon(Icons.cancel),
          //     onPressed: () async {
          //       if (_controller != null) {
          //         await Future.wait([
          //           _controller!.webStorage.sessionStorage.clear(),
          //           _controller!.webStorage.localStorage.clear(),
          //         ]);
          //       }

          //       await _controller?.reload();

          // TODO: Убрать тестовые код

//                 await Future.delayed(const Duration(seconds: 1));

//                 final a = await _controller!.evaluateJavascript(
//                   source: '''
//               if (typeof jivo_api !== 'undefined') {
//                  jivo_api.setUserToken("$userToken");
//               }
//             ''',
//                 );

//                 print(a);

//                 await Future.delayed(const Duration(seconds: 2));

//                 final b = await _controller?.evaluateJavascript(
//                   source: '''
//             if (typeof jivo_api !== 'undefined') {
//               jivo_api.setContactInfo({
//                 name: "$userName",
//                 email: "$userEmail",
//                 phone: "$userPhone"
//               });

//               // jivo_api.setClientAttributes({
//               //   'city': 'Белград кастом',
//               //   'last_order_id': '1234567890',
//               //   'app_version': '6.0.28+651',
//               //   'bonus_count': 1234
//               // });
//             }
//           ''',
//                 );

//                 print(b);

//                 // await Future.delayed(const Duration(seconds: 2));

//                 // await _controller?.reload();

//                 final c = await _controller?.evaluateJavascript(
//                   source: '''
// let count = jivo_api.getUnreadMessagesCount();
// console.log('Unread messages count:', count);
// ''',
//                 );

//                 print(c);
          //     },
          //   ),
          // ],
        ),
        body: BlocBuilder<SupportCubit, SupportChatState>(
          builder: (context, state) {
            final cubit = context.read<SupportCubit>();
            final chatUrl = cubit.chatUrl;

            if (chatUrl == null) {
              return const AppCenterLoader();
            }

            return InAppWebView(
              initialUrlRequest: URLRequest(url: chatUrl),
              onWebViewCreated: (controller) {
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
