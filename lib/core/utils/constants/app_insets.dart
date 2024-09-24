import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/widgets.dart';

abstract final class AppInsets {
  static const EdgeInsets kAll1 = EdgeInsets.all(1);
  static const EdgeInsets kAll2 = EdgeInsets.all(2);
  static const EdgeInsets kAll4 = EdgeInsets.all(4);
  static const EdgeInsets kAll6 = EdgeInsets.all(6);
  static const EdgeInsets kAll8 = EdgeInsets.all(8);
  static const EdgeInsets kAll12 = EdgeInsets.all(12);
  static const EdgeInsets kAll16 = EdgeInsets.all(16);
  static const EdgeInsets kAll24 = EdgeInsets.all(24);
  static const EdgeInsets kAll32 = EdgeInsets.all(32);
  static const EdgeInsets kAll48 = EdgeInsets.all(48);
  static const EdgeInsets kAll64 = EdgeInsets.all(64);
  static const EdgeInsets kAll72 = EdgeInsets.all(72);

  static const EdgeInsets kHorizontal1 = EdgeInsets.symmetric(horizontal: 1);
  static const EdgeInsets kHorizontal2 = EdgeInsets.symmetric(horizontal: 2);
  static const EdgeInsets kHorizontal4 = EdgeInsets.symmetric(horizontal: 4);
  static const EdgeInsets kHorizontal6 = EdgeInsets.symmetric(horizontal: 6);
  static const EdgeInsets kHorizontal8 = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets kHorizontal10 = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets kHorizontal12 = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets kHorizontal14 = EdgeInsets.symmetric(horizontal: 14);
  static const EdgeInsets kHorizontal16 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets kHorizontal21 = EdgeInsets.symmetric(horizontal: 21);
  static const EdgeInsets kHorizontal24 = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets kHorizontal32 = EdgeInsets.symmetric(horizontal: 32);
  static const EdgeInsets kHorizontal48 = EdgeInsets.symmetric(horizontal: 48);
  static const EdgeInsets kHorizontal64 = EdgeInsets.symmetric(horizontal: 64);
  static const EdgeInsets kHorizontal72 = EdgeInsets.symmetric(horizontal: 72);

  static const EdgeInsets kVertical1 = EdgeInsets.symmetric(vertical: 1);
  static const EdgeInsets kVertical2 = EdgeInsets.symmetric(vertical: 2);
  static const EdgeInsets kVertical3 = EdgeInsets.symmetric(vertical: 3);
  static const EdgeInsets kVertical4 = EdgeInsets.symmetric(vertical: 4);
  static const EdgeInsets kVertical6 = EdgeInsets.symmetric(vertical: 6);
  static const EdgeInsets kVertical8 = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets kVertical10 = EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets kVertical12 = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets kVertical16 = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets kVertical20 = EdgeInsets.symmetric(vertical: 20);
  static const EdgeInsets kVertical24 = EdgeInsets.symmetric(vertical: 24);
  static const EdgeInsets kVertical32 = EdgeInsets.symmetric(vertical: 32);
  static const EdgeInsets kVertical48 = EdgeInsets.symmetric(vertical: 48);
  static const EdgeInsets kVertical64 = EdgeInsets.symmetric(vertical: 64);
  static const EdgeInsets kVertical72 = EdgeInsets.symmetric(vertical: 72);

  static const EdgeInsets kTop1 = EdgeInsets.only(top: 1);
  static const EdgeInsets kTop2 = EdgeInsets.only(top: 2);
  static const EdgeInsets kTop4 = EdgeInsets.only(top: 4);
  static const EdgeInsets kTop6 = EdgeInsets.only(top: 6);
  static const EdgeInsets kTop8 = EdgeInsets.only(top: 8);
  static const EdgeInsets kTop12 = EdgeInsets.only(top: 12);
  static const EdgeInsets kTop16 = EdgeInsets.only(top: 16);
  static const EdgeInsets kTop24 = EdgeInsets.only(top: 24);
  static const EdgeInsets kTop32 = EdgeInsets.only(top: 32);
  static const EdgeInsets kTop48 = EdgeInsets.only(top: 48);
  static const EdgeInsets kTop64 = EdgeInsets.only(top: 64);
  static const EdgeInsets kTop72 = EdgeInsets.only(top: 72);

  static const EdgeInsets kBottom1 = EdgeInsets.only(bottom: 1);
  static const EdgeInsets kBottom2 = EdgeInsets.only(bottom: 2);
  static const EdgeInsets kBottom4 = EdgeInsets.only(bottom: 4);
  static const EdgeInsets kBottom6 = EdgeInsets.only(bottom: 6);
  static const EdgeInsets kBottom8 = EdgeInsets.only(bottom: 8);
  static const EdgeInsets kBottom12 = EdgeInsets.only(bottom: 12);
  static const EdgeInsets kBottom16 = EdgeInsets.only(bottom: 16);
  static const EdgeInsets kBottom24 = EdgeInsets.only(bottom: 24);
  static const EdgeInsets kBottom32 = EdgeInsets.only(bottom: 32);
  static const EdgeInsets kBottom44 = EdgeInsets.only(bottom: 44);
  static const EdgeInsets kBottom48 = EdgeInsets.only(bottom: 48);
  static const EdgeInsets kBottom64 = EdgeInsets.only(bottom: 64);
  static const EdgeInsets kBottom72 = EdgeInsets.only(bottom: 72);

  static const EdgeInsets kLeft1 = EdgeInsets.only(left: 1);
  static const EdgeInsets kLeft2 = EdgeInsets.only(left: 2);
  static const EdgeInsets kLeft4 = EdgeInsets.only(left: 4);
  static const EdgeInsets kLeft6 = EdgeInsets.only(left: 6);
  static const EdgeInsets kLeft8 = EdgeInsets.only(left: 8);
  static const EdgeInsets kLeft12 = EdgeInsets.only(left: 12);
  static const EdgeInsets kLeft16 = EdgeInsets.only(left: 16);
  static const EdgeInsets kLeft24 = EdgeInsets.only(left: 24);
  static const EdgeInsets kLeft22 = EdgeInsets.only(left: 22);
  static const EdgeInsets kLeft32 = EdgeInsets.only(left: 32);
  static const EdgeInsets kLeft48 = EdgeInsets.only(left: 48);
  static const EdgeInsets kLeft64 = EdgeInsets.only(left: 64);
  static const EdgeInsets kLeft72 = EdgeInsets.only(left: 72);

  static const EdgeInsets kRight1 = EdgeInsets.only(right: 1);
  static const EdgeInsets kRight2 = EdgeInsets.only(right: 2);
  static const EdgeInsets kRight4 = EdgeInsets.only(right: 4);
  static const EdgeInsets kRight6 = EdgeInsets.only(right: 6);
  static const EdgeInsets kRight8 = EdgeInsets.only(right: 8);
  static const EdgeInsets kRight12 = EdgeInsets.only(right: 12);
  static const EdgeInsets kRight16 = EdgeInsets.only(right: 16);
  static const EdgeInsets kRight24 = EdgeInsets.only(right: 24);
  static const EdgeInsets kRight32 = EdgeInsets.only(right: 32);
  static const EdgeInsets kRight48 = EdgeInsets.only(right: 48);
  static const EdgeInsets kRight64 = EdgeInsets.only(right: 64);
  static const EdgeInsets kRight72 = EdgeInsets.only(right: 72);

  static const MobilePositionSettings snakBarPadding =
      MobilePositionSettings(left: 16, right: 16);
}
