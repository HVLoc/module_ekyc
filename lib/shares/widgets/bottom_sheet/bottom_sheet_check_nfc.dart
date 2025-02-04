import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/shares/shares.src.dart';
import 'package:module_ekyc/shares/widgets/text/font_style.dart';

class BottomSheetCheckNfc extends StatelessWidget {
  final bool isSupportNfc;

  const BottomSheetCheckNfc(this.isSupportNfc, {super.key});

  String getTitle() {
    return isSupportNfc
        ? LocaleKeys.check_nfc_title_installation_guide.tr
        : LocaleKeys.check_nfc_title_not_available.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextUtils(
          text: getTitle(),
          availableStyle: StyleEnum.heading1Bold,
          color: AppColors.basicGrey1,
        ),
        sdsSBHeight20,
        SvgPicture.asset(
            isSupportNfc
                ? Assets.PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_SUPPORT_NFC_SVG
                : Assets.PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_NO_SUPPORT_NFC_SVG,
            colorFilter: const ColorFilter.mode(
                AppColors.primaryBlue1, BlendMode.srcIn)),
        sdsSBHeight20,
        Visibility(
          visible: isSupportNfc,
          child: _buildInstallationGuide(),
        ),
        Visibility(
          visible: !isSupportNfc,
          child: _buildContactSupport(),
        ),
        sdsSBHeight20,
        isSupportNfc
            ? ButtonUtils.buildButton(
                LocaleKeys.check_nfc_setting.tr,
                () {
                  AppSettings.openAppSettings(type: AppSettingsType.nfc);
                },
                backgroundColor: AppColors.primaryBlue1,
              ).paddingSymmetric(vertical: AppDimens.padding5)
            : _buildBottomContactSupport()
      ],
    );
  }

  Widget _buildInstallationGuide() {
    return RichText(
      text: TextSpan(
        text: LocaleKeys.check_nfc_content_installation_guide_one.tr,
        style: FontStyleUtils.fontStyleSans(color: Colors.black),
        children: [
          TextSpan(
            text: LocaleKeys.check_nfc_content_installation_guide_two.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text: LocaleKeys.check_nfc_content_installation_guide_three.tr),
          TextSpan(
            text: LocaleKeys.check_nfc_content_installation_guide_four.tr,
          ),
          TextSpan(
            text: LocaleKeys.check_nfc_content_installation_guide_five.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildBottomContactSupport() {
    return ButtonUtils.buildButton(
      LocaleKeys.check_nfc_contact.tr,
      () async {
        // await UtilWidget.launchInBrowser(LocaleKeys.check_nfc_number_hotline.tr)
        //     .then((value) {
        //   if (Get.isBottomSheetOpen ?? false) {
        //     Get.back();
        //   }
        // });
      },
      backgroundColor: AppColors.basicWhite,
      colorText: AppColors.primaryBlue1,
      border: Border.all(color: AppColors.primaryBlue1),
    ).paddingSymmetric(vertical: AppDimens.padding16);
  }

  Widget _buildContactSupport() {
    return RichText(
      text: TextSpan(
        text: LocaleKeys.check_nfc_not_available.tr,
        style: FontStyleUtils.fontStyleSans(color: Colors.black),
        children: const [
          // TextSpan(text: LocaleKeys.check_nfc_please_contact.tr),
          // TextSpan(
          //   text: LocaleKeys.check_nfc_hotline.tr,
          //   style: FontStyleUtils.fontStyleSans(
          //     color: AppColors.primaryBlue1,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // TextSpan(
          //   text: LocaleKeys.check_nfc_number_hotline.tr,
          //   style: FontStyleUtils.fontStyleSans(
          //     color: AppColors.primaryBlue1,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // TextSpan(text: LocaleKeys.check_nfc_support.tr),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
