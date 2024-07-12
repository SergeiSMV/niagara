import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';

@RoutePage()
class OneOrderPage extends StatelessWidget {
  const OneOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(
            title: 'Заказ №24345',
            actions: [
              Container(
                height: 20,
                width: 20,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
