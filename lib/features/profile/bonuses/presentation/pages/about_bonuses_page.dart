import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/modal_background_widget.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/about_bonus_program/bonuses_program_header_widget.dart';

@RoutePage()
class AboutBonusesPage extends StatelessWidget {
  const AboutBonusesPage({super.key});

  static final _sheetKey = GlobalKey();
  static final _controller = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    final modalSize = context.select(
      (BonusesBloc bloc) => bloc.state.maybeWhen(
        unauthorized: () => 0.45,
        orElse: () => .7,
      ),
    );
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Stack(
        children: [
          const BonusesProgramHeaderWidget(),
          DraggableScrollableSheet(
            key: _sheetKey,
            controller: _controller,
            initialChildSize: modalSize,
            minChildSize: modalSize,
            builder: (_, scrollCtrl) => SingleChildScrollView(
              controller: scrollCtrl,
              physics: const ClampingScrollPhysics(),
              child: ModalBackgroundWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppConst.kCommon24.verticalBox,
                    Text(
                      t.bonuses.aboutBonusesProgram.whatBonusProgramGives,
                      style: context.textStyle.headingTypo.h3.withColor(
                        context.colors.textColors.main,
                      ),
                    ),
                    AppConst.kCommon48.verticalBox,
                  ],
                ).paddingSymmetric(horizontal: AppConst.kCommon16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
