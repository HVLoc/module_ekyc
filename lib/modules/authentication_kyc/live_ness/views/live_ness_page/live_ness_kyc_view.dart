part of 'live_ness_kyc_page.dart';

Widget _body(LiveNessKycController controller) {
  return _buildCapturePage(controller);
}

Widget _buildCapturePage(LiveNessKycController controller) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: ImageWidget.imageAsset(
                  Assets.ASSETS_JPG_VTS___APP___NEN_1_JPG,
                  fit: BoxFit.cover),
            ),
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(fit: StackFit.passthrough, children: [
                Positioned(
                  top: Get.height / 2 - Get.width / 1.8,
                  left: Get.width / 2 - Get.width / 2.6,
                  child: Center(
                    child: SizedBox(
                      width: Get.width / 1.3,
                      height: Get.height / 2.3,
                      // decoration: BoxDecoration(
                      //   shape: BoxShape.circle,
                      //   border: Border.all(color: Colors.grey, width: 5),
                      // ),
                      child: ClipOval(
                        child: FittedBox(
                          fit: BoxFit.cover, // Đảm bảo camera lấp đầy vòng tròn
                          child: SizedBox(
                            width: Get.width,
                            child: controller.cameraIsInitialize.value
                                ? Transform.scale(
                                    scale: 1.2,
                                    child: Center(
                                      child: CameraPreview(
                                          controller.cameraController),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                _actionWidget(controller),
                _positionedAppbar(controller),
                _warningFace(controller),
                _buildGuide(),
                _buttonStart(controller),
                // if (controller.imageTemp.value != null)
                //   _buildWidgetHaveImage(controller),
              ]),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildGuide() {
  return Positioned(
    left: AppDimens.padding15,
    right: AppDimens.padding15,
    top: Get.height - Get.width / 1.8,
    child: Container(
      constraints: BoxConstraints(
        maxHeight: Get.width / 1.8 - kToolbarHeight,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1.0),
        border: Border.all(color: AppColors.colorDisable, width: 1.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextUtils(
              text: "Hướng dẫn thao tác:",
              availableStyle: StyleEnum.body14Bold,
              // color: AppColors.colorSemantic3,
              textAlign: TextAlign.center,
            ),
            _itemRow('Đi đến nơi có đủ ánh sáng.'),
            _itemRow('Không đeo khẩu trang, kính mát, mũ,...'),
            _itemRow('Thực hiện quay trái, phải,... theo yêu cầu.'),
            _itemRow('Đưa khuôn mặt vào trong khung quy định.'),
          ],
        ).paddingAll(AppDimens.padding15),
      ),
    ),
  );
}

Row _itemRow(String title) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const TextUtils(
        text: "-   ",
        availableStyle: StyleEnum.body14,
        color: AppColors.basicBlack,
      ),
      Expanded(
        child: TextUtils(
          text: title,
          availableStyle: StyleEnum.bodyRegular,
          color: AppColors.basicBlack,
          maxLine: 4,
        ),
      ),
    ],
  );
}

Stack _warningFace(LiveNessKycController controller) {
  return Stack(
    children: [
      Visibility(
        visible:
            controller.isFaceEmpty.value && !controller.isSuccessLiveNess.value,
        child: Positioned(
          left: AppDimens.padding8,
          right: AppDimens.padding8,
          top: Get.height / 2 + AppDimens.sizeBorderNavi,
          child: Container(
            color: AppColors.colorGreyOpacity35,
            child: TextUtils(
              text: LocaleKeys.live_ness_liveNessEmptyFace.tr,
              availableStyle: StyleEnum.body14,
              color: AppColors.basicWhite,
              maxLine: 2,
              textAlign: TextAlign.center,
            ).paddingAll(8),
          ),
        ),
      ),
      Visibility(
        visible:
            controller.isManyFace.value && !controller.isSuccessLiveNess.value,
        child: Positioned(
          left: AppDimens.padding8,
          right: AppDimens.padding8,
          top: Get.height / 2 + AppDimens.sizeBorderNavi,
          child: Container(
            color: AppColors.colorGreyOpacity35,
            child: TextUtils(
              text: LocaleKeys.live_ness_liveNessManyFace.tr,
              availableStyle: StyleEnum.body14,
              color: AppColors.basicWhite,
              maxLine: 2,
              textAlign: TextAlign.center,
            ).paddingAll(8),
          ),
        ),
      ),
    ],
  );
}

Visibility _actionWidget(LiveNessKycController controller) {
  return Visibility(
    visible: controller.isSuccessLiveNess.isFalse,
    child: Positioned(
      left: AppDimens.sizeTextSmallest,
      right: AppDimens.sizeTextSmallest,
      top: kToolbarHeight * 2,
      child: controller.currentStep.value > 0
          ? Column(
              children: [
                TextUtils(
                  text: LocaleKeys.live_ness_titleAction.tr,
                  availableStyle: StyleEnum.body14Bold,
                  color: AppColors.basicGrey1,
                  maxLine: 2,
                  textAlign: TextAlign.center,
                ),
                sdsSBHeight20,
                TextUtils(
                  text: (controller.currentStep.value - 1) > 4
                      ? ""
                      : controller
                          .questionTemp[controller.currentStep.value - 1],
                  availableStyle: StyleEnum.subBold,
                  color: AppColors.statusRed,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Column(
              children: [
                TextUtils(
                  text: LocaleKeys.live_ness_titleAction.tr,
                  availableStyle: StyleEnum.body14Bold,
                  color: Colors.black,
                  maxLine: 2,
                  textAlign: TextAlign.center,
                ),
                sdsSBHeight5,
                TextUtils(
                  text: LocaleKeys.live_ness_titleSchedule.tr,
                  availableStyle: StyleEnum.body14,
                  color: Colors.black,
                  maxLine: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            ).paddingSymmetric(horizontal: AppDimens.btnMedium),
    ),
  );
}

Visibility _buttonStart(LiveNessKycController controller) {
  return Visibility(
    visible: controller.currentStep.value == 0,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: ButtonUtils.buildButton(
        "Đồng ý thực hiện",
        () async {
          await controller.startStreamPicture();
        },
        width: Get.width / 2,
        isLoading: controller.isShowLoading.value,
        // backgroundColor: AppColors.colorGreenText,
        borderRadius: BorderRadius.circular(24),
        colorText: AppColors.basicWhite,
      ).paddingOnly(bottom: AppDimens.padding10),
    ),
  );
}

Positioned _positionedAppbar(LiveNessKycController controller) {
  return Positioned(
    left: 0,
    right: AppDimens.sizeTextSmallest,
    top: 0,
    child: Align(
      alignment: Alignment.topCenter,
      child: BackgroundAppBar.buildAppBar(
        "Quét khuôn mặt",
        leading: true,
        textColor: AppColors.colorVTS,
        backButtonColor: AppColors.colorVTS,
        backgroundColor: AppColors.basicWhite,
      ), /*AppBar(
          leading: ButtonUtils.baseOnAction(
            onTap: () async {
              Get.back();
              await controller.closePros();
            },
            child: const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.chevron_left,
                color: AppColors.basicWhite,
                size: AppDimens.iconMedium,
              ),
            ),
            isContinuous: true,
          ),
          backgroundColor: AppColors.colorTransparent,
          iconTheme: Get.theme.iconTheme.copyWith(color: AppColors.basicWhite),
          elevation: 0,
          title: TextUtils(
            text: controller.currentStep.value > 0
                ? LocaleKeys.live_ness_titleAppbarAction.tr
                : LocaleKeys.live_ness_titleAppbar.tr,
            availableStyle: StyleEnum.bodyRegular,
            color: AppColors.basicWhite,
            maxLine: 2,
            textAlign: TextAlign.center,
          ),
          centerTitle: true),*/
    ),
  );
}
