import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';

@RoutePage()
class PolicyPage extends StatelessWidget {
  const PolicyPage({
    super.key,
    required this.pageTitle,
    required this.html,
  });

  final Widget pageTitle;
  final String html;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(
            body: pageTitle,
          ),
          SliverToBoxAdapter(
            child: HtmlWidget(html),
          ),
        ],
      ),
    );
  }
}
