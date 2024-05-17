import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_program_cubit/bonuses_program_cubit.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/bonuses_program/about_bonuses_description_build_widget.dart';

class WhatBonusProgramGivesWidget extends StatelessWidget {
  const WhatBonusProgramGivesWidget({super.key});

  static final _imagesAboutBonuses = [
    Assets.images.aboutBonuses.aboutFirst,
    Assets.images.aboutBonuses.aboutSecond,
    Assets.images.aboutBonuses.aboutThird,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesProgramCubit, BonusesProgramState>(
      builder: (_, state) => state.maybeWhen(
        loaded: (aboutBonuses) => Padding(
          padding: AppInsets.kSymmetricV24 + AppInsets.kSymmetricH16,
          child: Column(
            children: [
              Text(
                t.bonuses.aboutBonusesProgram.whatBonusProgramGives,
                style: context.textStyle.headingTypo.h3.withColor(
                  context.colors.textColors.main,
                ),
              ),
              AppBoxes.kBoxV4,
              ...List.generate(
                aboutBonuses.aboutBonusProgram.privileges.length,
                (index) => Padding(
                  padding: AppInsets.kSymmetricV12,
                  child: AboutBonusesDescriptionBuildWidget(
                    title:
                        aboutBonuses.aboutBonusProgram.privileges[index].title,
                    description: aboutBonuses
                        .aboutBonusProgram.privileges[index].description,
                    image: _imagesAboutBonuses[index],
                  ),
                ),
              ),
            ],
          ),
        ),
        orElse: SizedBox.shrink,
      ),
    );
  }
}
