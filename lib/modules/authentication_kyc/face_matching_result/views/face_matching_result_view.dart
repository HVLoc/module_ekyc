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
                  ImageWidget.imageSvg(
                    (controller.appController.sendNfcRequestGlobalModel
                                .isFaceMatching ??
                            false)
                        ? Assets.ASSETS_SVG_IC_SUCCESS_SNACKBAR_SVG
                        : Assets.ASSETS_SVG_IC_ERROR_SNACKBAR_SVG,
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
              _buildItemText(
                LocaleKeys.nfcInformationUserPage_firstName.tr,
                controller.appController.sendNfcRequestGlobalModel.nameVNM,
                isFirst: true,
              ),
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
              //     Assets.ASSETS_SVG_ICON_USER_NAME_CARD_SVG),
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
              buildStatusVerify(
                  controller.appController.sendNfcRequestGlobalModel),
            ],
          ).paddingSymmetric(
            vertical: AppDimens.padding4,
          ),
        ),
      ),
      sdsSBHeight15,
      Obx(
        () => ButtonUtils.buildButton(
          "Xác thực BCA",
          () async {
            Get.toNamed(
              AppRoutes.routeNfcInformationUser,
              arguments: controller.appController.sendNfcRequestGlobalModel,
            );
          },
          isLoading: controller.isShowLoading.value,
          width: Get.width / 2,
          // backgroundColor: AppColors.colorGreenText,
        ),
      ),
      GetPlatform.isAndroid ? sdsSBHeight10 : sdsSBHeight15,
    ],
  ).paddingSymmetric(horizontal: AppDimens.paddingTop);
}

Widget _buildItemText(String title, String? content, {bool isFirst = false}) {
  return Column(
    children: [
      if (!isFirst)
        const Divider(
          color: AppColors.colorDisable,
          height: 1,
        ),
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

Widget buildStatusVerify(SendNfcRequestModel sendNfcRequestModel) {
  final Map<String, bool?> verificationStatus = {
    "Toàn vẹn dữ liệu": sendNfcRequestModel.isIntegrity,
    "Xác thực khuôn mặt": sendNfcRequestModel.faceMatching!=null,
    "Xác thực Bộ Công An": sendNfcRequestModel.isVerifyBCA,
  };
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const TextUtils(
        text: 'Tình trạng xác thực:',
        availableStyle: StyleEnum.subBold,
        maxLine: 3,
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: verificationStatus.entries.map((entry) {
            return Column(
              children: [
                _buildStatusRow(
                  title: entry.key,
                  status: getStatusText(entry.value),
                  statusColor: getStatusColor(entry.value),
                  icon: getStatusIcon(entry.value),
                  iconColor: getStatusIconColor(entry.value),
                ),
                if (entry.key != verificationStatus.keys.last)
                  Divider(color: Colors.grey.shade300),
              ],
            );
          }).toList(),
        ),
      ),
    ],
  );
}

/// Hàm lấy text theo trạng thái
String getStatusText(bool? value) {
  if (value == null) return "Chưa xác thực";
  return value ? "Đã xác thực" : "Không xác thực";
}

/// Hàm lấy màu chữ theo trạng thái
Color getStatusColor(bool? value) {
  if (value == null) return Colors.orange;
  return value ? Colors.blue : Colors.red;
}

/// Hàm lấy icon theo trạng thái
IconData getStatusIcon(bool? value) {
  if (value == null) return Icons.info;
  return value ? Icons.check_circle : Icons.cancel;
}

/// Hàm lấy màu icon theo trạng thái
Color getStatusIconColor(bool? value) {
  if (value == null) return Colors.orange;
  return value ? Colors.green : Colors.red;
}

Widget _buildStatusRow({
  required String title,
  required String status,
  required Color statusColor,
  required IconData icon,
  required Color iconColor,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextUtils(
            text: title,
            availableStyle: StyleEnum.bodyRegular,
            maxLine: 2,
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: TextUtils(
                  text: title,
                  availableStyle: StyleEnum.bodyRegular,
                  color: statusColor,
                  maxLine: 2,
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(width: 5),
              Icon(icon, color: iconColor, size: 20),
            ],
          ),
        ),
      ],
    ),
  );
}
