part of 'nfc_information_user_page.dart';

Widget _buildListGuild(NfcInformationUserController controller) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Visibility(
          visible: controller.authenticationVisible.value ||
              controller.sendNfcRequestModel.isView,
          child: Row(
            children: [
              SvgPicture.asset(
                controller.authenticationSuccess ||
                        controller.sendNfcRequestModel.statusSuccess
                    ? Assets.PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_DONE_SVG
                    : Assets
                        .PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_CANCEL_AUTHENTICATION_SVG,
              ),
              sdsSBWidth5,
              Expanded(
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: controller.packageKind == AppConst.typeProduction
                            ? LocaleKeys.nfc_nfcAuthentication1.tr
                            : (controller.authenticationSuccess ||
                                    controller
                                        .sendNfcRequestModel.statusSuccess)
                                ? LocaleKeys.nfc_nfcAuthenticationSanbox1.tr
                                : LocaleKeys
                                    .nfc_nfcAuthenticationSanbox1Fail.tr,
                        style: const TextStyle(
                          height: 1.3,
                          color: AppColors.basicBlack,
                          fontSize: AppDimens.sizeTextSmall,
                        ),
                      ),
                      TextSpan(
                        text: controller.authenticationSuccess ||
                                controller.sendNfcRequestModel.statusSuccess
                            ? controller.packageKind == AppConst.typeProduction
                                ? LocaleKeys.nfc_nfcAuthenticationSuccess.tr
                                : LocaleKeys.nfc_nfcAuthenticationSanbox2.tr
                            : controller.packageKind == AppConst.typeProduction
                                ? LocaleKeys.nfc_nfcAuthenticationErorr.tr
                                : LocaleKeys
                                    .nfc_nfcAuthenticationSanbox2Fail.tr,
                        style: TextStyle(
                          height: 1.3,
                          color: controller.authenticationSuccess ||
                                  controller.sendNfcRequestModel.statusSuccess
                              ? AppColors.statusGreen
                              : AppColors.statusRed,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimens.sizeTextSmall,
                        ),
                      ),
                      TextSpan(
                        text: controller.packageKind == AppConst.typeProduction
                            ? LocaleKeys.nfc_nfcAuthentication2.tr
                            : "",
                        style: const TextStyle(
                          height: 1.3,
                          color: AppColors.basicBlack,
                          fontSize: AppDimens.sizeTextSmall,
                        ),
                      ),
                    ],
                  ),
                ).paddingSymmetric(horizontal: AppDimens.padding15),
              ),
            ],
          ).paddingSymmetric(horizontal: AppDimens.padding12),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.memory(
              base64Decode(controller.image ?? ""),
              width: 120,
              height: 120,
            ),
            (controller.imageBody ?? "") != ""
                ? Image.memory(
                    base64Decode(controller.imageBody ?? ""),
                    width: 120,
                    height: 120,
                  )
                : const SizedBox()
          ],
        ).paddingSymmetric(vertical: AppDimens.padding10),
        _buildItemText(LocaleKeys.nfcInformationUserPage_firstName.tr,
            controller.sendNfcRequestModel.nameVNM),
        _buildItemText(LocaleKeys.nfcInformationUserPage_idCard.tr,
            controller.sendNfcRequestModel.number),
        // _buildItemText(LocaleKeys.nfcInformationUserPage_phone.tr,
        //     controller.sendNfcRequestModel.phone),
        (controller.sendNfcRequestModel.otherPaper != "" &&
                controller.sendNfcRequestModel.otherPaper != null)
            ? _buildItemText(LocaleKeys.nfcInformationUserPage_otherPaper.tr,
                controller.sendNfcRequestModel.otherPaper)
            : const SizedBox(),

        // sizeBoxHeight12(),
        // _buildItemText(
        //     '${LocaleKeys.nfcInformationUserPage_lastName.tr}: ${controller.lastName}',
        //     Assets.PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_USER_NAME_CARD_SVG),
        _buildItemText(LocaleKeys.nfcInformationUserPage_dateOfBirth.tr,
            controller.dateOfBirth),
        _buildItemText(LocaleKeys.nfcInformationUserPage_gender.tr,
            controller.sendNfcRequestModel.sexVMN),
        _buildItemText(LocaleKeys.nfcInformationUserPage_nationality.tr,
            controller.sendNfcRequestModel.nationalityVMN),
        _buildItemText(LocaleKeys.nfcInformationUserPage_religion.tr,
            controller.sendNfcRequestModel.religionVMN),
        _buildItemText(LocaleKeys.nfcInformationUserPage_nation.tr,
            controller.sendNfcRequestModel.nationVNM),
        _buildItemText(LocaleKeys.nfcInformationUserPage_homeTown.tr,
            controller.sendNfcRequestModel.homeTownVMN),
        _buildItemText(LocaleKeys.nfcInformationUserPage_resident.tr,
            controller.sendNfcRequestModel.residentVMN),
        _buildItemText(LocaleKeys.nfcInformationUserPage_identificationSigns.tr,
            controller.sendNfcRequestModel.identificationSignsVNM),
        _buildItemText(LocaleKeys.nfcInformationUserPage_registrationDate.tr,
            controller.sendNfcRequestModel.registrationDateVMN),
        _buildItemText(LocaleKeys.nfcInformationUserPage_location.tr,
            LocaleKeys.nfcInformationUserPage_locationTitle.tr),
        _buildItemText(LocaleKeys.nfcInformationUserPage_dateOfExpiry.tr,
            controller.dateOfExpiry),
        _buildItemText(LocaleKeys.nfcInformationUserPage_nameDad.tr,
            controller.sendNfcRequestModel.nameDadVMN),
        _buildItemText(LocaleKeys.nfcInformationUserPage_nameMom.tr,
            controller.sendNfcRequestModel.nameMomVMN),
        (controller.sendNfcRequestModel.nameCouple != "" &&
                controller.sendNfcRequestModel.nameCouple != null)
            ? _buildItemText(
                controller.sendNfcRequestModel.sex == "M"
                    ? "Tên vợ:"
                    : "Tên chồng:",
                controller.sendNfcRequestModel.nameCouple)
            : const SizedBox(),
      ],
    ).paddingSymmetric(horizontal: AppDimens.padding10),
  );
}

SizedBox sizeBoxHeight12() {
  return const SizedBox(
    height: 12,
  );
}

Widget _buildItemText(String title, String? content) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // buildBaseIcon(assetIcon).paddingOnly(right: AppDimens.padding5),
          TextUtils(
            text: title,
            availableStyle: StyleEnum.body14,
            maxLine: 3,
          ),
          sdsSBWidth10,
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: TextUtils(
                text: content ?? "",
                availableStyle: StyleEnum.body14,
                color: AppColors.primaryBlue1,
                maxLine: 3,
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
      sizeBoxHeight12(),
    ],
  );
}

Widget buildBaseText(String text) {
  return TextUtils(
    text: text,
    availableStyle: StyleEnum.bodyRegular,
    maxLine: 3,
  );
}

Widget buildBaseIcon(String assetIcon) {
  return SvgPicture.asset(
    assetIcon,
    width: 16,
    height: 16,
  );
}
