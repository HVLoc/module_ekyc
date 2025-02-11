part of 'nfc_kyc_page.dart';

Widget _body(ScanNfcKycController controller) {
  return Stack(
    children: [
      Positioned.fill(
        child: ImageWidget.imageAsset(Assets.ASSETS_JPG_VTS___APP___NEN_1_JPG,
            fit: BoxFit.cover),
      ),
      SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              textEditingController:
                                  controller.userNameController,
                              isLoading: true,
                              hintText: "",
                              textInputType: TextInputType.number,
                              currentNode: controller.userNameFocus,
                              errorValidator: LocaleKeys
                                  .register_account_errorValidatorCCCD.tr,
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
                              errorValidator: LocaleKeys
                                  .register_account_errorValidatorCCCD.tr,
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
                              errorValidator: LocaleKeys
                                  .register_account_errorValidatorCCCD.tr,
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
              _buildButtonNfcContinue(controller),
              sdsSBHeight5,
              _titleInstruct(),
            ],
          ).paddingAll(AppDimens.padding20),
        ),
      ),
    ],
  );
}

Widget _titleInstruct() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(1),
      border: Border.all(color: AppColors.colorDisable, width: 1.0),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sdsSB5,
        TextUtils(
          text: "Hướng dẫn:",
          availableStyle: StyleEnum.subBold,
          maxLine: 3,
        ),
        sdsSB5,
        TextUtils(
          text:
              'Bước 1: Đưa thẻ CCCD ra khu vực cảm biến (phía sau đầu điện thoại) để tiến hành đọc thẻ',
          availableStyle: StyleEnum.bodyRegular,
          maxLine: 3,
        ),
        sdsSB5,
        TextUtils(
          text: 'Bước 2: Bấm vào nút quét CHIP với NFC để tiến hành quét',
          availableStyle: StyleEnum.bodyRegular,
          maxLine: 3,
        ),
        TextUtils(
          text: 'Bước 3: Giữ nguyên CCCD cho tới khi hiển thị kết quả xác thực',
          availableStyle: StyleEnum.bodyRegular,
          maxLine: 3,
        ),
      ],
    ).paddingAll(AppDimens.padding15),
  );
}

Widget _buildButtonNfcContinue(ScanNfcKycController controller) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () async {
            await controller.scanNfc();
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: AppColors.primaryMain),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const TextUtils(
              text: "Quét CHIP với NFC",
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
    ),
  );
}
