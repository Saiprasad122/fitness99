import 'package:flutter/material.dart';

abstract class AppFontFamily {
  static String get sgproRegular => 'SohoGothicPro-Regular';
  static String get sgproMedium => 'SohoGothicPro-Medium';
  static String get sgproBold => 'SohoGothicPro-Bold';
  static String get sgproLight => 'SohoGothicPro-Light';
}

class FontAppFontSizes {
  static double scale = 0.8;

  static double get f50 => AppFontSizes.size50 * scale;
  static double get f42 => AppFontSizes.size42 * scale;
  static double get f26 => AppFontSizes.size26 * scale;
  static double get f20 => AppFontSizes.size20 * scale;
  static double get f18 => AppFontSizes.size18 * scale;
  static double get f16 => AppFontSizes.size16 * scale;
  static double get f36 => AppFontSizes.size36 * scale;
  static double get f14 => AppFontSizes.size14 * scale;
  static double get f34 => AppFontSizes.size34 * scale;
  static double get f12 => AppFontSizes.size12 * scale;
  static double get f10 => AppFontSizes.size10 * scale;
  static double get f30 => AppFontSizes.size30 * scale;
  static double get f24 => AppFontSizes.size24 * scale;
  static double get f52 => AppFontSizes.size52 * scale;
  static double get f32 => AppFontSizes.size32 * scale;
  static double get f22 => AppFontSizes.size22 * scale;
}

class AppFontSizes {
  static double size10 = 10;
  static double size12 = 12;
  static double size14 = 14;
  static double size16 = 16;
  static double size18 = 18;
  static double size20 = 20;
  static double size26 = 26;
  static double size34 = 34;
  static double size36 = 36;
  static double size42 = 42;
  static double size50 = 50;
  static double size24 = 24;
  static double size30 = 30;
  static double size52 = 52;
  static double size32 = 32;
  static double size22 = 22;

  void init(Size size) {
    size52 = size.height <= 640
        ? 47
        : size.height > 640.0 && size.height <= 740
            ? 49
            : size.height > 740.0 && size.height <= 820
                ? 52
                : size.height > 820.0 && size.height <= 900
                    ? 53
                    : size.height > 900.0 && size.height <= 1040
                        ? 54
                        : 56;
    size50 = size.height <= 640
        ? 39
        : size.height > 640.0 && size.height <= 740
            ? 48
            : size.height > 740.0 && size.height <= 820
                ? 50
                : size.height > 820.0 && size.height <= 900
                    ? 51
                    : size.height > 900.0 && size.height <= 1040
                        ? 52
                        : 56;
    size30 = size.height <= 640
        ? 25
        : size.height > 640.0 && size.height <= 740
            ? 28
            : size.height > 740.0 && size.height <= 820
                ? 30
                : size.height > 820.0 && size.height <= 900
                    ? 31
                    : size.height > 900.0 && size.height <= 1040
                        ? 32
                        : 32;
    size10 = size.height <= 640
        ? 7
        : size.height > 640.0 && size.height <= 740
            ? 8
            : size.height > 740.0 && size.height <= 820
                ? 10
                : size.height > 820.0 && size.height <= 900
                    ? 11
                    : size.height > 900.0 && size.height <= 1040
                        ? 12
                        : 14;
    size12 = size.height <= 640
        ? 9
        : size.height > 640.0 && size.height <= 740
            ? 11
            : size.height > 740.0 && size.height <= 820
                ? 13
                : size.height > 820.0 && size.height <= 900
                    ? 14
                    : size.height > 900.0 && size.height <= 1040
                        ? 15
                        : 16;
    size14 = size.height <= 640
        ? 12
        : size.height > 640.0 && size.height <= 740
            ? 13
            : size.height > 740.0 && size.height <= 820
                ? 14
                : size.height > 820.0 && size.height <= 900
                    ? 15
                    : size.height > 900.0 && size.height <= 1040
                        ? 16
                        : 17;
    size16 = size.height <= 640
        ? 14
        : size.height > 640.0 && size.height <= 740
            ? 15
            : size.height > 740.0 && size.height <= 820
                ? 16
                : size.height > 820.0 && size.height <= 900
                    ? 17
                    : size.height > 900.0 && size.height <= 1040
                        ? 18
                        : 20;
    size18 = size.height <= 640
        ? 15
        : size.height > 640.0 && size.height <= 740
            ? 16
            : size.height > 740.0 && size.height <= 820
                ? 18
                : size.height > 820.0 && size.height <= 900
                    ? 19
                    : size.height > 900.0 && size.height <= 1040
                        ? 20
                        : 21;
    size20 = size.height <= 640
        ? 16
        : size.height > 640.0 && size.height <= 740
            ? 18
            : size.height > 740.0 && size.height <= 820
                ? 20
                : size.height > 820.0 && size.height <= 900
                    ? 21
                    : size.height > 900.0 && size.height <= 1040
                        ? 22
                        : 22;
    size26 = size.height <= 640
        ? 22
        : size.height > 640.0 && size.height <= 740
            ? 24
            : size.height > 740.0 && size.height <= 820
                ? 26
                : size.height > 820.0 && size.height <= 900
                    ? 27
                    : size.height > 900.0 && size.height <= 1040
                        ? 28
                        : 29;
    size34 = size.height <= 640
        ? 28
        : size.height > 640.0 && size.height <= 740
            ? 30
            : size.height > 740.0 && size.height <= 820
                ? 32
                : size.height > 820.0 && size.height <= 900
                    ? 33
                    : size.height > 900.0 && size.height <= 1040
                        ? 34
                        : 36;
    size36 = size.height <= 640
        ? 30
        : size.height > 640.0 && size.height <= 740
            ? 32
            : size.height > 740.0 && size.height <= 820
                ? 34
                : size.height > 820.0 && size.height <= 900
                    ? 35
                    : size.height > 900.0 && size.height <= 1040
                        ? 36
                        : 38;
    size42 = size.height <= 640
        ? 36
        : size.height > 640.0 && size.height <= 740
            ? 38
            : size.height > 740.0 && size.height <= 820
                ? 40
                : size.height > 820.0 && size.height <= 900
                    ? 42
                    : size.height > 900.0 && size.height <= 1040
                        ? 44
                        : 46;
    size24 = size.height <= 640
        ? 18
        : size.height > 640.0 && size.height <= 740
            ? 20
            : size.height > 740.0 && size.height <= 820
                ? 22
                : size.height > 820.0 && size.height <= 900
                    ? 23
                    : size.height > 900.0 && size.height <= 1040
                        ? 24
                        : 26;
    size32 = size.height <= 640
        ? 26
        : size.height > 640.0 && size.height <= 740
            ? 28
            : size.height > 740.0 && size.height <= 820
                ? 30
                : size.height > 820.0 && size.height <= 900
                    ? 32
                    : size.height > 900.0 && size.height <= 1040
                        ? 33
                        : 36;
    size22 = size.height <= 640
        ? 16
        : size.height > 640.0 && size.height <= 740
            ? 18
            : size.height > 740.0 && size.height <= 820
                ? 20
                : size.height > 820.0 && size.height <= 900
                    ? 21
                    : size.height > 900.0 && size.height <= 1040
                        ? 22
                        : 26;
  }
}

abstract class AppColors {
  static Color get accentColor => const Color.fromRGBO(255, 86, 122, 1);
  static Color get primaryColor => const Color.fromRGBO(5, 5, 5, 1);
  static Color get bottomAppBarColor => const Color.fromRGBO(243, 243, 243, 1);
  static Color get textColorBlack => const Color.fromRGBO(17, 20, 25, 1);
  static Color get textColorgrayBlue => const Color.fromRGBO(73, 86, 106, 1);
  static Color get textColorgray => const Color.fromRGBO(145, 150, 157, 1);
  static Color get bgWhite => const Color.fromRGBO(255, 255, 255, 1);
  static Color get bgOffWhite => const Color.fromRGBO(247, 247, 247, 1);
  static Color get boxBorder => const Color.fromRGBO(230, 230, 230, 1);
  static Color get highlighter => const Color.fromRGBO(249, 170, 51, 1);
  static Color get error => const Color.fromRGBO(197, 29, 29, 1);
  static Color get success => const Color.fromRGBO(73, 161, 82, 1);
  static Color get disabledButton => const Color.fromRGBO(83, 96, 99, 1);
  static Color get white78 => const Color(0xC7FFFFFF);
  static Color get scaffoldBgColor => const Color.fromRGBO(242, 242, 242, 1);
  static Color get blueDark => const Color(0xFF007AFF);
  static Color get greyDark => const Color(0xFF454F63);
  static Color get greyMid => const Color(0xFF959DAD);
  static Color get greyLight => const Color(0xFFBFC5D3);
  static Color get greyVeryLight => const Color(0xFFEBEBEB);
}

class TextStyles {
  // static TextStyle get sfproSemiBold => TextStyle(
  //     fontFamily: AppFontFamily.sfproSemiBold, fontWeight: FontWeight.w700);
  // static TextStyle get sfproSemiBoldItalic => TextStyle(
  //       fontFamily: AppFontFamily.sfproSemiBold,
  //       fontStyle: FontStyle.italic,
  //       fontWeight: FontWeight.w700,
  //     );
  static TextStyle get sgproBold => TextStyle(
        fontFamily: AppFontFamily.sgproBold,
        fontWeight: FontWeight.w800,
      );
  static TextStyle get sgproBoldItalic => TextStyle(
        fontFamily: AppFontFamily.sgproBold,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w800,
      );
  static TextStyle get sgproLight => TextStyle(
      fontFamily: AppFontFamily.sgproLight, fontWeight: FontWeight.w300);
  static TextStyle get sgproLightItalic => TextStyle(
      fontFamily: AppFontFamily.sgproLight,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300);
  static TextStyle get sgproRegular => TextStyle(
      fontFamily: AppFontFamily.sgproRegular, fontWeight: FontWeight.w500);
  static TextStyle get sgproRegularItalic => TextStyle(
      fontFamily: AppFontFamily.sgproRegular,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500);
  static TextStyle get sgproMedium => TextStyle(
      fontFamily: AppFontFamily.sgproMedium, fontWeight: FontWeight.w600);
  static TextStyle get sgproMediumItalic => TextStyle(
      fontFamily: AppFontFamily.sgproMedium,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600);
}

extension TextStyleHelpers on TextStyle {
  TextStyle get f50 => copyWith(fontSize: FontAppFontSizes.f50);
  TextStyle get f42 => copyWith(fontSize: FontAppFontSizes.f42);
  TextStyle get f24 => copyWith(fontSize: FontAppFontSizes.f24);
  TextStyle get f26 => copyWith(fontSize: FontAppFontSizes.f26);
  TextStyle get f20 => copyWith(fontSize: FontAppFontSizes.f20);
  TextStyle get f18 => copyWith(fontSize: FontAppFontSizes.f18);
  TextStyle get f34 => copyWith(fontSize: FontAppFontSizes.f34);
  TextStyle get f16 => copyWith(fontSize: FontAppFontSizes.f16);
  TextStyle get f14 => copyWith(fontSize: FontAppFontSizes.f14);
  TextStyle get f12 => copyWith(fontSize: FontAppFontSizes.f12);
  TextStyle get f36 => copyWith(fontSize: FontAppFontSizes.f36);
  TextStyle get f10 => copyWith(fontSize: FontAppFontSizes.f10);
  TextStyle get f30 => copyWith(fontSize: FontAppFontSizes.f30);
  TextStyle get f52 => copyWith(fontSize: FontAppFontSizes.f52);
  TextStyle get f32 => copyWith(fontSize: FontAppFontSizes.f32);
  TextStyle get f22 => copyWith(fontSize: FontAppFontSizes.f22);
  TextStyle get const50 => copyWith(fontSize: 50);
  TextStyle get const42 => copyWith(fontSize: 42);
  TextStyle get const24 => copyWith(fontSize: 24);
  TextStyle get const26 => copyWith(fontSize: 26);
  TextStyle get const20 => copyWith(fontSize: 20);
  TextStyle get const18 => copyWith(fontSize: 18);
  TextStyle get const34 => copyWith(fontSize: 34);
  TextStyle get const16 => copyWith(fontSize: 16);
  TextStyle get const14 => copyWith(fontSize: 14);
  TextStyle get const12 => copyWith(fontSize: 12);
  TextStyle get const36 => copyWith(fontSize: 36);
  TextStyle get const10 => copyWith(fontSize: 10);
  TextStyle get const30 => copyWith(fontSize: 30);
  TextStyle get const52 => copyWith(fontSize: 52);
  TextStyle get const32 => copyWith(fontSize: 32);
  TextStyle get const22 => copyWith(fontSize: 22);

  ///#DE1692
  TextStyle get primaryColor => copyWith(color: AppColors.primaryColor);

  ///#FFFFFF
  TextStyle get white => copyWith(color: Colors.white);

  ///#C7FFFF
  TextStyle get white78 => copyWith(color: AppColors.white78);

  ///#000000
  TextStyle get black => copyWith(color: Colors.black);

  ///#454F63
  TextStyle get greyDark => copyWith(color: AppColors.greyDark);

  ///#007AFF
  TextStyle get blueDark => copyWith(color: AppColors.blueDark);

  ///#959DAD
  TextStyle get greyMid => copyWith(color: AppColors.greyMid);

  ///#BFC5D3
  TextStyle get greyLight => copyWith(color: AppColors.greyLight);

  ///#EBEBEB
  TextStyle get greyVeryLight => copyWith(color: AppColors.greyVeryLight);
  TextStyle get secondaryColor => copyWith(color: AppColors.primaryColor);
  TextStyle get textColorBlack => copyWith(color: AppColors.textColorBlack);
  TextStyle get textColorgrayBlue =>
      copyWith(color: AppColors.textColorgrayBlue);
  TextStyle get textColorgray => copyWith(color: AppColors.textColorgray);
  TextStyle get bgWhite => copyWith(color: AppColors.bgWhite);
  TextStyle get bgOffWhite => copyWith(color: AppColors.bgOffWhite);
  TextStyle get boxBorder => copyWith(color: AppColors.boxBorder);
  TextStyle get highlighter => copyWith(color: AppColors.highlighter);
  TextStyle get error => copyWith(color: AppColors.error);
  TextStyle get success => copyWith(color: AppColors.success);
}
