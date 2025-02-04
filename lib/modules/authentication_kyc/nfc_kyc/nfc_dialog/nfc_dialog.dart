import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/nfc_kyc/nfc_dialog/nfc_dialog.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';

class NfcDialog extends BaseGetWidget<NfcDialogController> {
  @override
  NfcDialogController get controller => Get.put(NfcDialogController());

  const NfcDialog({super.key});

  @override
  Widget buildWidgets(BuildContext context) {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              child: TextUtils(
                text: controller.isReading.value
                    ? LocaleKeys.nfc_nfcWaitingTitle.tr
                    : LocaleKeys.nfc_dialogTitle.tr,
                availableStyle: StyleEnum.heading2Bold,
                color: AppColors.basicGrey1,
              ).paddingOnly(
                  top: AppDimens.padding20, bottom: AppDimens.padding15),
            ),
            SvgPicture.asset(
              Assets.LIB_ASSETS_SVG_ICON_SCAN_NFC_SVG,
              package: 'module_ekyc',
            ),
            TextUtils(
              text: controller.isReading.value
                  ? LocaleKeys.nfc_nfcWaiting.tr
                  : LocaleKeys.nfc_dialogContent.tr,
              availableStyle: StyleEnum.bodyRegular,
              color: AppColors.basicBlack,
              maxLine: 3,
              textAlign: TextAlign.center,
            ).paddingAll(AppDimens.padding10),
            Visibility(
              visible: controller.processQuantity.value > 0,
              child: TextUtils(
                text: "${controller.processQuantity.value * 10}%",
                availableStyle: StyleEnum.bodyRegular,
                color: AppColors.basicBlack,
                maxLine: 1,
                textAlign: TextAlign.center,
              ).paddingOnly(bottom: AppDimens.padding5),
            ),
            buildProgressBar(controller),
            ButtonUtils.buildButton(
              LocaleKeys.dialog_cancel.tr,
              () async {
                await controller.closeNfc();
              },
              isLoading: controller.isShowLoading.value,
              backgroundColor: AppColors.basicWhite,
              border: Border.all(width: 1, color: AppColors.primaryBlue1),
              borderRadius: BorderRadius.circular(AppDimens.radius4),
              colorText: AppColors.primaryBlue1,
            ).paddingAll(AppDimens.padding15)
          ],
        ).paddingOnly(bottom: AppDimens.padding10));
  }

  Widget buildProgressBar(NfcDialogController controller) {
    return Visibility(
      visible: controller.isReading.value,
      child: LinearPercentIndicator(
        width: Get.width / 1.5,
        lineHeight: 5,
        alignment: MainAxisAlignment.center,
        percent: controller.processQuantity.value / controller.maxProcess,
        progressColor: AppColors.primaryBlue1,
        barRadius: const Radius.circular(AppDimens.radius4),
      ).paddingOnly(top: AppDimens.padding4, bottom: AppDimens.padding4),
    );
  }
}
