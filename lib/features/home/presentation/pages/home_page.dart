import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.mainColors.bgCard,
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.router.push(const Home2Route()),
          child: Text('data'),
        ),
      ),
    );
  }
}

@RoutePage()
class Home2Page extends StatelessWidget {
  const Home2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen 1'),
      ),
      body: const Center(
        child: Text('Home Screen 1'),
      ),
    );
  }
}
