//Tạm thời để BottomSheet vì view sẵn, sau này đổi lại page
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';

import '../../../core/core.src.dart';
import '../../../shares/shares.src.dart';
import '../../home/home.src.dart';

class OtherPage extends StatelessWidget {
  final HomeController controller;

  const OtherPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: "",
      padding: 0,
      body: Column(
        children: [
          UtilWidget.bottomSheetRow(
              Assets.LIB_ASSETS_SVG_ICON_USER_NAME_CARD_SVG,
              LocaleKeys.home_accountInfo.tr, onTap: () {
            Get.back();
            Get.toNamed(AppRoutes.routeUserInfo);
          }),
          UtilWidget.bottomSheetRow(
            Assets.LIB_ASSETS_SVG_ICON_TELEPHONE_SVG,
            LocaleKeys.login_support.tr,
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.routeSupport);
            } /*await UtilWidget.launchInBrowser(
                LocaleKeys.check_nfc_number_hotline.tr)*/
            ,
          ),
          _buildLoginByFingerprint(),
          _buildDividerThick(),
          UtilWidget.bottomSheetRow(
            Assets.LIB_ASSETS_SVG_ICON_OTHER_USER_SVG,
            LocaleKeys.home_logout.tr,
            onTap: () => controller.funcLogout(),
            isDivider: false,
          ),
        ],
      ),
      noHeader: true,
    );
  }

  Divider _buildDividerThick() {
    return const Divider(
      color: AppColors.basicGrey2,
      thickness: 4,
    );
  }

  Widget _buildLoginByFingerprint() {
    return UtilWidget.bottomSheetRow(
        controller.appController.isFaceID
            ? Assets.LIB_ASSETS_SVG_ICON_FACEID_SVG
            : Assets.LIB_ASSETS_SVG_ICON_FINGERPRINT_SVG,
        controller.appController.isFaceID
            ? LocaleKeys.other_byFaceId
            : LocaleKeys.other_byFingerprint,
        onTap: () {},
        // isSVG: false,
        isDivider: false,
        trailingWidget: SizedBox(
          width: AppDimens.btnMedium,
          height: 30,
          child: Obx(
            () => CupertinoSwitch(
              value: controller.appController.isFingerprintOrFaceID.value,
              activeColor: AppColors.primaryBlue1,
              onChanged: (value) async {
                if (value) {
                  await Biometrics().authenticate(
                      // localizedReasonStr: "Quý khách vui lòng quét vân tay hoặc khuôn mặt để xác thực",
                      onDeviceUnlockUnavailable: () {
                    Fluttertoast.showToast(
                        msg: LocaleKeys.biometric_msgUnavailable.tr,
                        toastLength: Toast.LENGTH_LONG);
                  }, onAfterLimit: () {
                    Fluttertoast.showToast(
                        msg: LocaleKeys.biometric_msgLimit.tr,
                        toastLength: Toast.LENGTH_LONG);
                  }).then((isAuthenticated) async {
                    if (isAuthenticated != null && isAuthenticated) {
                      controller.appController.isFingerprintOrFaceID.toggle();
                      controller.loginInfoRequestModel.isBiometric =
                          controller.appController.isFingerprintOrFaceID.value;
                    } else {
                      controller.showFlushNoti(
                        LocaleKeys.login_biometricError.tr,
                        type: FlushBarType.error,
                      );
                    }
                  });
                } else {
                  controller.appController.isFingerprintOrFaceID.toggle();
                  controller.loginInfoRequestModel.isBiometric =
                      controller.appController.isFingerprintOrFaceID.value;
                  // APP_DATA.write(AppKey.keyFingerprint,
                  //     appController.isFingerprintOrFaceID.value);
                }
                hiveUserLogin.put(
                    AppKey.keyRememberLogin, controller.loginInfoRequestModel);
              },
            ),
          ),
        ));
  }
}
