part of 'nfc_kyc_page.dart';

Widget _body(ScanNfcKycController controller) {
  return SizedBox(
    height: Get.height,
    width: Get.width,
    child: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.isGuide.value
                    ? _bodyGuide(controller)
                    : _buildInfor(controller),
                _buildButtonNfcContinue(controller),
                sdsSBHeight5,
                if (controller.isGuide.value) _titleInstruct(),
              ],
            ).paddingAll(AppDimens.padding15),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfor(ScanNfcKycController controller) {
  return Column(
    children: [
      const TextUtils(
        text: "Thông tin cá nhân",
        availableStyle: StyleEnum.bodyBold,
        color: AppColors.primaryNavy,
      ),
      sdsSB8,
      Form(
          key: controller.formKey,
          child: Column(
            children: [
              BaseFormLogin.buildInputData(
                title: "Số CCCD:",
                textEditingController: controller.idDocumentController,
                isLoading: true,
                hintText: "",
                textInputType: TextInputType.number,
                currentNode: controller.idDocumentFocus,
                errorValidator:
                    LocaleKeys.register_account_errorValidatorCCCD.tr,
                // onValidator: (text) => UtilWidget.validateId(text),
                fillColor: AppColors.basicWhite.obs,
                autoFocus: true,
                paddingModel: const EdgeInsets.symmetric(),
              ),
              Visibility(
                visible: controller.userNameController.text != "" &&
                    controller.dobController.text != "",
                child: Column(
                  children: [
                    BaseFormLogin.buildInputData(
                      title: "Họ và tên:",
                      textEditingController: controller.userNameController,
                      isLoading: true,
                      hintText: "",
                      textInputType: TextInputType.number,
                      currentNode: controller.userNameFocus,
                      errorValidator:
                          LocaleKeys.register_account_errorValidatorCCCD.tr,
                      // onValidator: (text) =>
                      //     UtilWidget.validateId(text),
                      fillColor: AppColors.basicWhite.obs,
                      autoFocus: true,
                      paddingModel: const EdgeInsets.symmetric(),
                    ),
                    BaseFormLogin.buildInputData(
                      title: "Ngày sinh:",
                      textEditingController: controller.dobController,
                      isLoading: true,
                      hintText: "",
                      textInputType: TextInputType.number,
                      currentNode: controller.dobFocus,
                      errorValidator:
                          LocaleKeys.register_account_errorValidatorCCCD.tr,
                      // onValidator: (text) =>
                      //     UtilWidget.validateId(text),
                      fillColor: AppColors.basicWhite.obs,
                      autoFocus: true,
                      paddingModel: const EdgeInsets.symmetric(),
                    ),
                    BaseFormLogin.buildInputData(
                      title: "Ngày đăng ký:",
                      textEditingController: controller.doeController,
                      isLoading: true,
                      hintText: "",
                      textInputType: TextInputType.number,
                      currentNode: controller.doeFocus,
                      errorValidator:
                          LocaleKeys.register_account_errorValidatorCCCD.tr,
                      // onValidator: (text) =>
                      //     UtilWidget.validateId(text),
                      fillColor: AppColors.basicWhite.obs,
                      autoFocus: true,
                      paddingModel: const EdgeInsets.symmetric(),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: controller.visiblePhone,
                child: BaseFormLogin.buildInputData(
                  title: LocaleKeys.client_phoneNumber.tr,
                  textEditingController: controller.phoneController,
                  isLoading: false,
                  hintText: "",
                  textInputType: TextInputType.number,
                  currentNode: controller.phoneFocus,
                  errorValidator: "",
                  onValidator: (text) => UtilWidget.validatePhone(text),
                  fillColor: AppColors.basicWhite.obs,
                  autoFocus: true,
                  paddingModel: const EdgeInsets.symmetric(),
                ),
              ),
            ],
          )),
    ],
  );
}

Widget _titleInstruct() {
  return Container(
    decoration: const BoxDecoration(
      color: AppColors.secondaryCamPastel2,
      borderRadius: BorderRadius.all(Radius.circular(AppDimens.radius10)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sdsSB5,
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextUtils(
              text: "Hướng dẫn:",
              color: AppColors.basicBlack,
              availableStyle: StyleEnum.subBold,
              maxLine: 3,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        sdsSB5,
        _rowText("1", "Bấm vào nút Quét CHIP với NFC để tiến hành quét"),
        sdsSB5,
        _rowText("2",
            "Đưa thẻ CCCD ra khu vực cảm biến (phía sau đầu điện thoại) để tiến hành đọc thẻ"),
        sdsSB5,
        _rowText("3", "Giữ nguyên CCCD cho tới khi hiển thị kết quả xác thực"),
      ],
    ).paddingAll(AppDimens.padding15),
  );
}

Widget _rowText(String text, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
            color: AppColors.basicWhite,
            border: Border.all(color: AppColors.primaryBlue1, width: 2),
            shape: BoxShape.circle),
        child: TextUtils(
          text: text,
          color: AppColors.primaryBlue1,
          availableStyle: StyleEnum.bodyBold,
        ).paddingAll(AppDimens.padding5),
      ),
      sdsSBWidth5,
      Expanded(
        child: TextUtils(
          text: value,
          color: AppColors.basicBlack,
          availableStyle: StyleEnum.bodyRegular,
          maxLine: 3,
        ),
      ),
    ],
  );
}

Widget _buildButtonNfcContinue(ScanNfcKycController controller) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      GestureDetector(
        onTap: () async {
          controller.isGuide.value
              ? await controller.scanNfc()
              : controller.isGuide(true);
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: AppColors.primaryMain),
            borderRadius: BorderRadius.circular(AppDimens.radius8),
          ),
          child: TextUtils(
            text: controller.isGuide.value ? "Quét CHIP với NFC" : "Tiếp tục",
            availableStyle: StyleEnum.subBold,
            color: AppColors.basicWhite,
          ).paddingSymmetric(
            horizontal: AppDimens.padding20,
            vertical: AppDimens.padding8,
          ),
        ).paddingAll(AppDimens.padding15),
      ),
      // ButtonUtils.buildButton("Quét CHIP với NFC", () async {
      //   await controller.scanNfc();
      // },
      //         isLoading: controller.isShowLoading.value,
      //         backgroundColor: AppColors.primaryBlue1,
      //         width: 180,
      //         // height: 50,
      //         colorText: AppColors.basicWhite)
      //     .paddingAll(AppDimens.padding15),
    ],
  );
}
