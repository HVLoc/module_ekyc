part of 'face_matching_result_page.dart';

Widget _itemBody(FaceMatchingResultController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Row(
              //   children: [
              //     TextUtils(
              //       text: LocaleKeys.live_ness_result_step3.tr,
              //       availableStyle: StyleEnum.titleMedium,
              //       color: AppColors.colorAccent1,
              //     ),
              //     Expanded(
              //       child: TextUtils(
              //         text: LocaleKeys.update_information_kyc_step1Title.tr,
              //         availableStyle: StyleEnum.titleMedium,
              //         color: AppColors.colorBack,
              //         maxLine: 2,
              //       ),
              //     ),
              //   ],
              // ),
              // UtilWidget.sizedBox45,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.memory(
                    base64Decode(controller
                            .appController.sendNfcRequestGlobalModel.file ??
                        ""),
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                    // fit: BoxFit.cover,
                  ),
                  Image.memory(
                    base64Decode(controller.appController
                            .sendNfcRequestGlobalModel.imgLiveNess ??
                        ""),
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                    // fit: BoxFit.cover,
                  )
                ],
              ),
              sdsSBHeight20,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    (controller.appController.sendNfcRequestGlobalModel
                                .isFaceMatching ??
                            false)
                        ? Assets.LIB_ASSETS_SVG_IC_SUCCESS_SNACKBAR_SVG
                        : Assets.LIB_ASSETS_SVG_IC_ERROR_SNACKBAR_SVG,
                  ).paddingOnly(
                    right: AppDimens.padding4,
                  ),
                  Flexible(
                    child: TextUtils(
                      text: LocaleKeys.live_ness_result_title.tr,
                      availableStyle: StyleEnum.body14,
                      color: (controller.appController.sendNfcRequestGlobalModel
                                  .isFaceMatching ??
                              false)
                          ? AppColors.colorGreenText
                          : AppColors.statusRed,
                      maxLine: 2,
                    ),
                  ),
                ],
              ),
              TextUtils(
                text:
                    "Kết quả: ${controller.appController.sendNfcRequestGlobalModel.faceMatching} ",
                availableStyle: StyleEnum.body14,
                color: (controller.appController.sendNfcRequestGlobalModel
                            .isFaceMatching ??
                        false)
                    ? AppColors.colorGreenText
                    : AppColors.statusRed,
                maxLine: 2,
              ),
              sdsSBHeight15,
              _buildItemText(LocaleKeys.nfcInformationUserPage_firstName.tr,
                  controller.appController.sendNfcRequestGlobalModel.nameVNM),
              _buildItemText(LocaleKeys.nfcInformationUserPage_idCard.tr,
                  controller.appController.sendNfcRequestGlobalModel.number),
              // _buildItemText(LocaleKeys.nfcInformationUserPage_phone.tr,
              //     controller.appController.sendNfcRequestGlobalModel.phone),
              (controller.appController.sendNfcRequestGlobalModel.otherPaper !=
                          "" &&
                      controller.appController.sendNfcRequestGlobalModel
                              .otherPaper !=
                          null)
                  ? _buildItemText(
                      LocaleKeys.nfcInformationUserPage_otherPaper.tr,
                      controller
                          .appController.sendNfcRequestGlobalModel.otherPaper)
                  : const SizedBox(),

              // sizeBoxHeight12(),
              // _buildItemText(
              //     '${LocaleKeys.nfcInformationUserPage_lastName.tr}: ${controller.lastName}',
              //     Assets.LIB_ASSETS_SVG_ICON_USER_NAME_CARD_SVG),
              _buildItemText(
                LocaleKeys.nfcInformationUserPage_dateOfBirth.tr,
                controller.appController.sendNfcRequestGlobalModel.dobVMN,
              ),
              _buildItemText(LocaleKeys.nfcInformationUserPage_gender.tr,
                  controller.appController.sendNfcRequestGlobalModel.sexVMN),
              _buildItemText(
                  LocaleKeys.nfcInformationUserPage_nationality.tr,
                  controller
                      .appController.sendNfcRequestGlobalModel.nationalityVMN),
              _buildItemText(
                  LocaleKeys.nfcInformationUserPage_religion.tr,
                  controller
                      .appController.sendNfcRequestGlobalModel.religionVMN),
              _buildItemText(LocaleKeys.nfcInformationUserPage_nation.tr,
                  controller.appController.sendNfcRequestGlobalModel.nationVNM),
              _buildItemText(
                  LocaleKeys.nfcInformationUserPage_homeTown.tr,
                  controller
                      .appController.sendNfcRequestGlobalModel.homeTownVMN),
              _buildItemText(
                  LocaleKeys.nfcInformationUserPage_resident.tr,
                  controller
                      .appController.sendNfcRequestGlobalModel.residentVMN),
              _buildItemText(
                  LocaleKeys.nfcInformationUserPage_identificationSigns.tr,
                  controller.appController.sendNfcRequestGlobalModel
                      .identificationSignsVNM),
              _buildItemText(
                  LocaleKeys.nfcInformationUserPage_registrationDate.tr,
                  controller.appController.sendNfcRequestGlobalModel
                      .registrationDateVMN),
              _buildItemText(LocaleKeys.nfcInformationUserPage_location.tr,
                  LocaleKeys.nfcInformationUserPage_locationTitle.tr),
              _buildItemText(
                LocaleKeys.nfcInformationUserPage_dateOfExpiry.tr,
                controller.appController.sendNfcRequestGlobalModel.doeVMN,
              ),
              _buildItemText(
                  LocaleKeys.nfcInformationUserPage_nameDad.tr,
                  controller
                      .appController.sendNfcRequestGlobalModel.nameDadVMN),
              _buildItemText(
                  LocaleKeys.nfcInformationUserPage_nameMom.tr,
                  controller
                      .appController.sendNfcRequestGlobalModel.nameMomVMN),
              (controller.appController.sendNfcRequestGlobalModel.nameCouple !=
                          "" &&
                      controller.appController.sendNfcRequestGlobalModel
                              .nameCouple !=
                          null)
                  ? _buildItemText(
                      controller.appController.sendNfcRequestGlobalModel.sex ==
                              "M"
                          ? "Tên vợ:"
                          : "Tên chồng:",
                      controller
                          .appController.sendNfcRequestGlobalModel.nameCouple)
                  : const SizedBox(),
            ],
          ).paddingSymmetric(
            vertical: AppDimens.padding4,
          ),
        ),
      ),
      sdsSBHeight15,
      Obx(
        () => ButtonUtils.buildButton(
          LocaleKeys.live_ness_result_button.tr,
          () async {
            Get.toNamed(
              AppRoutes.routeNfcInformationUser,
              arguments: controller.appController.sendNfcRequestGlobalModel,
            );
          },
          isLoading: controller.isShowLoading.value,
          width: AppDimens.sizeImg,
          // backgroundColor: AppColors.colorGreenText,
        ),
      ),
      GetPlatform.isAndroid ? sdsSBHeight10 : sdsSBHeight15,
    ],
  ).paddingSymmetric(horizontal: AppDimens.paddingTop);
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
      sdsSBHeight15,
    ],
  );
}
