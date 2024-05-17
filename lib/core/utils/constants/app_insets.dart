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

  static const EdgeInsets kSymmetricH1 = EdgeInsets.symmetric(horizontal: 1);
  static const EdgeInsets kSymmetricH2 = EdgeInsets.symmetric(horizontal: 2);
  static const EdgeInsets kSymmetricH4 = EdgeInsets.symmetric(horizontal: 4);
  static const EdgeInsets kSymmetricH6 = EdgeInsets.symmetric(horizontal: 6);
  static const EdgeInsets kSymmetricH8 = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets kSymmetricH12 = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets kSymmetricH16 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets kSymmetricH24 = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets kSymmetricH32 = EdgeInsets.symmetric(horizontal: 32);
  static const EdgeInsets kSymmetricH48 = EdgeInsets.symmetric(horizontal: 48);
  static const EdgeInsets kSymmetricH64 = EdgeInsets.symmetric(horizontal: 64);
  static const EdgeInsets kSymmetricH72 = EdgeInsets.symmetric(horizontal: 72);

  static const EdgeInsets kSymmetricV1 = EdgeInsets.symmetric(vertical: 1);
  static const EdgeInsets kSymmetricV2 = EdgeInsets.symmetric(vertical: 2);
  static const EdgeInsets kSymmetricV4 = EdgeInsets.symmetric(vertical: 4);
  static const EdgeInsets kSymmetricV6 = EdgeInsets.symmetric(vertical: 6);
  static const EdgeInsets kSymmetricV8 = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets kSymmetricV12 = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets kSymmetricV16 = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets kSymmetricV24 = EdgeInsets.symmetric(vertical: 24);
  static const EdgeInsets kSymmetricV32 = EdgeInsets.symmetric(vertical: 32);
  static const EdgeInsets kSymmetricV48 = EdgeInsets.symmetric(vertical: 48);
  static const EdgeInsets kSymmetricV64 = EdgeInsets.symmetric(vertical: 64);
  static const EdgeInsets kSymmetricV72 = EdgeInsets.symmetric(vertical: 72);

  static const EdgeInsets kOnlyTop1 = EdgeInsets.only(top: 1);
  static const EdgeInsets kOnlyTop2 = EdgeInsets.only(top: 2);
  static const EdgeInsets kOnlyTop4 = EdgeInsets.only(top: 4);
  static const EdgeInsets kOnlyTop6 = EdgeInsets.only(top: 6);
  static const EdgeInsets kOnlyTop8 = EdgeInsets.only(top: 8);
  static const EdgeInsets kOnlyTop12 = EdgeInsets.only(top: 12);
  static const EdgeInsets kOnlyTop16 = EdgeInsets.only(top: 16);
  static const EdgeInsets kOnlyTop24 = EdgeInsets.only(top: 24);
  static const EdgeInsets kOnlyTop32 = EdgeInsets.only(top: 32);
  static const EdgeInsets kOnlyTop48 = EdgeInsets.only(top: 48);
  static const EdgeInsets kOnlyTop64 = EdgeInsets.only(top: 64);
  static const EdgeInsets kOnlyTop72 = EdgeInsets.only(top: 72);

  static const EdgeInsets kOnlyBottom1 = EdgeInsets.only(bottom: 1);
  static const EdgeInsets kOnlyBottom2 = EdgeInsets.only(bottom: 2);
  static const EdgeInsets kOnlyBottom4 = EdgeInsets.only(bottom: 4);
  static const EdgeInsets kOnlyBottom6 = EdgeInsets.only(bottom: 6);
  static const EdgeInsets kOnlyBottom8 = EdgeInsets.only(bottom: 8);
  static const EdgeInsets kOnlyBottom12 = EdgeInsets.only(bottom: 12);
  static const EdgeInsets kOnlyBottom16 = EdgeInsets.only(bottom: 16);
  static const EdgeInsets kOnlyBottom24 = EdgeInsets.only(bottom: 24);
  static const EdgeInsets kOnlyBottom32 = EdgeInsets.only(bottom: 32);
  static const EdgeInsets kOnlyBottom48 = EdgeInsets.only(bottom: 48);
  static const EdgeInsets kOnlyBottom64 = EdgeInsets.only(bottom: 64);
  static const EdgeInsets kOnlyBottom72 = EdgeInsets.only(bottom: 72);

  static const EdgeInsets kOnlyLeft1 = EdgeInsets.only(left: 1);
  static const EdgeInsets kOnlyLeft2 = EdgeInsets.only(left: 2);
  static const EdgeInsets kOnlyLeft4 = EdgeInsets.only(left: 4);
  static const EdgeInsets kOnlyLeft6 = EdgeInsets.only(left: 6);
  static const EdgeInsets kOnlyLeft8 = EdgeInsets.only(left: 8);
  static const EdgeInsets kOnlyLeft12 = EdgeInsets.only(left: 12);
  static const EdgeInsets kOnlyLeft16 = EdgeInsets.only(left: 16);
  static const EdgeInsets kOnlyLeft24 = EdgeInsets.only(left: 24);
  static const EdgeInsets kOnlyLeft32 = EdgeInsets.only(left: 32);
  static const EdgeInsets kOnlyLeft48 = EdgeInsets.only(left: 48);
  static const EdgeInsets kOnlyLeft64 = EdgeInsets.only(left: 64);
  static const EdgeInsets kOnlyLeft72 = EdgeInsets.only(left: 72);

  static const EdgeInsets kOnlyRight1 = EdgeInsets.only(right: 1);
  static const EdgeInsets kOnlyRight2 = EdgeInsets.only(right: 2);
  static const EdgeInsets kOnlyRight4 = EdgeInsets.only(right: 4);
  static const EdgeInsets kOnlyRight6 = EdgeInsets.only(right: 6);
  static const EdgeInsets kOnlyRight8 = EdgeInsets.only(right: 8);
  static const EdgeInsets kOnlyRight12 = EdgeInsets.only(right: 12);
  static const EdgeInsets kOnlyRight16 = EdgeInsets.only(right: 16);
  static const EdgeInsets kOnlyRight24 = EdgeInsets.only(right: 24);
  static const EdgeInsets kOnlyRight32 = EdgeInsets.only(right: 32);
  static const EdgeInsets kOnlyRight48 = EdgeInsets.only(right: 48);
  static const EdgeInsets kOnlyRight64 = EdgeInsets.only(right: 64);
  static const EdgeInsets kOnlyRight72 = EdgeInsets.only(right: 72);
}
