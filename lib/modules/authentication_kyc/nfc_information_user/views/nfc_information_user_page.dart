import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/nfc_information_user/nfc_information_user_src.dart';
import 'package:module_ekyc/shares/shares.src.dart';

part 'nfc_information_user_view.dart';

class NfcInformationUserPage extends BaseGetWidget {
  const NfcInformationUserPage({super.key});

  @override
  NfcInformationUserController get controller =>
      Get.put(NfcInformationUserController());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.basicWhite,
      appBar: BackgroundAppBar.buildAppBar(
        controller.authenticationVisible.value ||
                (!controller.sendNfcRequestModel.visibleButtonDetail)
            ? LocaleKeys.nfcInformationUserPage_resultAuthentication.tr
            : LocaleKeys.nfcInformationUserPage_information.tr,
        isColorGradient: false,
        // centerTitle: true,
        leading: true,
        backgroundColor: AppColors.colorTransparent,
      ),
      body: buildLoadingOverlay(
        () => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Assets.ASSETS_JPG_IMAGE_BANNER_PNG,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                color: Colors.white.withOpacity(0.9),
              ),
              _buildListGuild(controller)
                  .paddingSymmetric(horizontal: AppDimens.paddingDefaultHeight),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Visibility(
          visible: (!controller.sendNfcRequestModel.statusSuccess) &&
              controller.sendNfcRequestModel.visibleButtonDetail,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonUtils.buildButton(
                controller.authenticationVisible.value ||
                        controller.appController.isOnlyNFC
                    ? LocaleKeys.nfc_nfcSuccess.tr
                    : LocaleKeys.registerCa_continue.tr,
                () async {
                  if (controller.authenticationVisible.value) {
                    controller.returnToModule();
                  } else {
                    await controller.goPage();
                  }
                },
                isLoading: controller.isShowLoading.value,
                backgroundColor: AppColors.primaryBlue1,
                width: AppDimens.sizeImg,
                // borderRadius: BorderRadius.circular(AppDimens.radius4),
                // height: AppDimens.iconHeightButton,
              ).paddingSymmetric(
                  horizontal: AppDimens.paddingDefaultHeight,
                  vertical: AppDimens.padding15),
              // Visibility(
              //   visible: controller.authenticationVisible.value,
              //   child: RichText(
              //     textAlign: TextAlign.start,
              //     text: TextSpan(
              //       children: [
              //         const TextSpan(
              //           text: "Quay về ",
              //           style: TextStyle(
              //             height: 1.3,
              //             color: AppColors.basicGrey40,
              //             fontSize: AppDimens.sizeText13,
              //           ),
              //         ),
              //         TextSpan(
              //           text: LocaleKeys.home_other.tr,
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () {
              //               Get.until((route) =>
              //                   Get.currentRoute == AppRoutes.routeHome);
              //             },
              //           style: const TextStyle(
              //             height: 1.3,
              //             color: AppColors.primaryBlue1,
              //             fontSize: AppDimens.sizeText13,
              //             decoration: TextDecoration.underline,
              //           ),
              //         ),
              //         const TextSpan(
              //           text: " hoặc tiếp tục ",
              //           style: TextStyle(
              //             height: 1.3,
              //             color: AppColors.basicBlack,
              //             fontSize: AppDimens.sizeText13,
              //           ),
              //         ),
              //         TextSpan(
              //           text: LocaleKeys.biometric_authentication.tr,
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () {
              //               controller.getToHome();
              //             },
              //           style: const TextStyle(
              //             height: 1.3,
              //             color: AppColors.primaryBlue1,
              //             fontSize: AppDimens.sizeText13,
              //             decoration: TextDecoration.underline,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ).paddingAll(AppDimens.padding12),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
