import 'package:flutter/material.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';

import '../../../assets.dart';

class ShowFlushBar {
  static Flushbar? flushbar;
  Future<void> showFlushBar(
    String message, {
    final FlushBarType type = FlushBarType.notification,
    Duration duration = const Duration(seconds: 5),
    final FlushbarPosition position = FlushbarPosition.TOP,
  }) async {
    final Color backgroundColor;
    Color messageColor = AppColors.statusRed;
    final String assetName;
    if (message.length > 150) {
      duration = const Duration(seconds: 6);
    }
    switch (type) {
      case FlushBarType.notification:
        backgroundColor = AppColors.shadow;
        assetName = Assets.ASSETS_SVG_NOTIFICATION_13_SVGREPO_COM_SVG;
        messageColor = AppColors.basicBlack;
        break;
      case FlushBarType.success:
        backgroundColor = AppColors.basicSuccess;
        assetName = Assets.ASSETS_SVG_SUCCESS_STANDARD_SVGREPO_COM_SVG;
        messageColor = AppColors.statusGreen;
        break;
      case FlushBarType.error:
        backgroundColor = AppColors.basicError;
        assetName = Assets.ASSETS_SVG_ERROR_SVGREPO_COM_SVG;

        break;
      case FlushBarType.warning:
        backgroundColor = AppColors.secondaryCam2;
        assetName = Assets.ASSETS_SVG_WARNING_SVGREPO_COM_SVG;

        break;
    }
    if (flushbar != null) {
      flushbar!.dismiss();
    }
    flushbar = await Flushbar(
      messageSize: AppDimens.fontSmall(),
      isDismissible: true,
      message: message,
      messageColor: messageColor,
      duration: duration,
      flushbarPosition: position,
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: AppDimens.padding20),
      icon: ImageWidget.imageSvg(
        assetName,
        width: AppDimens.iconSize30,
        color: messageColor,
      ),
      flushbarStyle: FlushbarStyle.GROUNDED,
    ).show(Get.context!);
  }

  void dismissFlushbar() {
    if (flushbar != null) {
      flushbar!.dismiss();
    }
  }
}

enum FlushBarType { notification, success, warning, error }
