import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/face_matching_result/face_matching_result.src.dart';
import 'package:module_ekyc/shares/package/export_package.dart';

import '../../../../shares/widgets/widgets.src.dart';
import '../../nfc_kyc/model/nfc_request_model.dart';

part 'face_matching_result_view.dart';

class FaceMatchingResultPage
    extends BaseGetWidget<FaceMatchingResultController> {
  const FaceMatchingResultPage({super.key});

  @override
  FaceMatchingResultController get controller =>
      Get.put(FaceMatchingResultController());

  @override
  Widget buildWidgets(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Scaffold(
      // backgroundColor: AppColors.basicWhite,
      appBar: BackgroundAppBar.buildAppBar(
        "Thông tin NFC & eKYC",
        isColorGradient: false,
        textColor: AppColors.colorVTS,
        backButtonColor: AppColors.colorVTS,
        backgroundColor: AppColors.basicWhite,
      ),
      body: baseShowLoading(
        () => Stack(
          children: [
            Positioned.fill(
              child: ImageWidget.imageAsset(
                  Assets.ASSETS_JPG_VTS___APP___NEN_1_JPG,
                  fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: ImageWidget.imageAsset(
                    Assets.ASSETS_JPG_IMAGE_BANNER_PNG,
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
                height: Get.height,
                width: Get.width,
                child: _itemBody(controller)),
          ],
        ),
      ),
      // bottomSheet: Column(
      //   children: [
      //     ButtonUtils.buildButton(LocaleKeys.home_agree.tr, () async {
      //       Get.toNamed(AppRoutes.routeQrKyc);
      //     },
      //         isLoading: controller.isShowLoading.value,
      //         backgroundColor: AppColors.primaryBlue1,
      //         colorText: AppColors.basicWhite),
      //     sdsSB5,
      //   ],
      // ),
    );
  }
}
