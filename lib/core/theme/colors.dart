import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _singleton = AppColors._internal();

  factory AppColors() {
    return _singleton;
  }

  AppColors._internal();

  static bool _isDarkMode() => false;

  static Color appBarColor() => _isDarkMode() ? basicWhite : basicWhite;

  static Color bottomSheet() => _isDarkMode() ? basicGrey4 : Colors.white;

  static Color accentColorTheme(bool isDark) =>
      isDark ? basicGrey4 : basicGrey4;
  static const Color colorGreenText = Color(0xFF3DA000);
  static const Color basicGrey4 = Colors.white;
  static const Color basicWhite = Colors.white;
  static const Color basicGrey3 = Color(0xFFDBDBDB);
  static const Color basicGrey2 = Color(0xFFA9A9A9);
  static const Color basicGrey1 = Color(0xFF7E7E7E);
  static const Color basicBlack = Color(0xFF333333);
  static const Color basicBorder =Color(0xFF91D7E3);
  static const Color basicGreyDialog =Color(0xFFF5F7FA);
  static const Color basicGreyText = Color(0xFF9F9F9F);
  static const Color basicDivider = Color(0xFF577D99);
  static const Color basicTextPay = Color(0xFF577D99);


  static const Color basicGrey40 = Color(0xFF939393);

  static const Color primaryTextColor = Color(0xFF02BEFE);
  static const Color primaryText2Color = Color(0xFF03548E);
  static const Color primaryBlue1 = Color(0xFF1548A2);
  static const Color primaryButtonGrey = Color(0xFF939393);
  static const Color primaryNavy = Color(0xFF1C1E66);
  static const Color inputFill = Color(0xCCEAF7FF);
  static const Color inputFillSearch = Color(0xFFF2F2F2);
  static const Color iconDefault = Color(0xFF939393);
  static const Color borderColor = Color(0xFFFFFAE6);
  static const Color shadow = Color(0xFF91D7E3);
  static const Color colorTextGrey = Color(0xFF9F9F9F);

  static const List<Color> primaryMain = [
    primaryBlue1,
    primaryBlue1,
  ];
  static const Color basicSuccess = Color(0xFFF5FFEC);
  static const Color basicError = Color(0xFFFFF4EC);

  static const Color basicGreen = Colors.green;
  static const Color statusGreen = Color(0xFF9CCB6B);
  static const Color statusRed = Color(0xFFFE0000);
  static const Color statusYellow = Color(0xFFFFC700);

  static const Color secondaryNavyPastel = Color(0xFFEAF7FF);
  static const Color secondaryCamPastel2 = Color(0xFFEEF9FF);
  static const Color secondaryCamPastel = Color(0xFFFFEADE);
  static const Color secondaryCam3 = Color(0xFFCA4A00);
  static const Color secondaryCam2 = Color(0xFFE45300);

  static const Color colorTransparent = Colors.transparent;
  static const Color colorBlack = Colors.black;
  static Color colorGreyOpacity35 = Colors.grey.withOpacity(0.35);

  static Color colorWhiteOpacity35() => Colors.black.withOpacity(0.8);

  static const Color colorDisable = Color(0xFF9d9d9d);

  static const Color colorSuccess = Color(0xFF00D4AE);
  static const Color colorNotSuccess = Color(0xFF939393);

}
