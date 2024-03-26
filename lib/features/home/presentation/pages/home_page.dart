import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/features/home/presentation/widgets/home_app_bar.dart';

/// Главная страница приложения.
@RoutePage()
class HomePage extends StatelessWidget {
  /// Создает виджет главной страницы.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          HomeAppBar(),
        ],
      ),
    );
  }
}
