// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:niagara_app/features/splash/presentation/pages/splash_page.dart';

class MockSplashCubit extends Mock implements SplashCubit {
  @override
  bool get state => false;
}

void main() {
  group('SplashPage', () {
    // Тест для проверки корректного отображения SplashPage
    testWidgets('test load ui elements', (WidgetTester tester) async {
      // Создаем мок SplashCubit
      final splashCubit = MockSplashCubit();

      // Строим виджет SplashPage, обернутый моком SplashCubit
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SplashCubit>.value(
            value: splashCubit,
            child: const SplashPage(),
          ),
        ),
      );

      // Ожидаем, что найдено два виджета Lottie
      expect(find.byType(Lottie), findsNWidgets(2));
      // Ожидаем, что найдено два виджета AnimatedOpacity
      expect(find.byType(AnimatedOpacity), findsNWidgets(2));
      // Ожидаем, что найден один виджет Positioned
      expect(find.byType(Positioned), findsOneWidget);
    });
  });

  testWidgets('test SplashPage opacity animation handling',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SplashCubit>(
          create: (context) => MockSplashCubit(),
          child: const SplashPage(),
        ),
      ),
    );

    // Инициализация со значением 0
    expect(find.byType(AnimatedOpacity), findsWidgets);
    final AnimatedOpacity animatedOpacity =
        tester.widget(find.byType(AnimatedOpacity).first);
    expect(animatedOpacity.opacity, 0);

    // После анимации значение 1
    await tester.pump(AppConst.kSplashLogoDuration);
    final AnimatedOpacity animatedOpacityAfter =
        tester.widget(find.byType(AnimatedOpacity).first);
    expect(animatedOpacityAfter.opacity, 1);
  });

  test('initial state is false', () {
    final splashCubit = SplashCubit();
    expect(splashCubit.state, false);
  });

  test('readyToNavigate changes state to true', () {
    final splashCubit = SplashCubit()..readyToNavigate();
    expect(splashCubit.state, true);
  });
}
