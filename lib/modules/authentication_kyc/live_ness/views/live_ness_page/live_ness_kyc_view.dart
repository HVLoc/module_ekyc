part of 'live_ness_kyc_page.dart';

Widget _body(LiveNessKycController controller) {
  return _buildCapturePage(controller);
}

Widget _buildCapturePage(LiveNessKycController controller) {
  return Stack(
    children: [
      controller.cameraIsInitialize.value
          ? Positioned.fill(
              child: Transform.scale(
                scale: 1.2,
                child: Center(
                  child: CameraPreview(controller.cameraController),
                ),
              ),
            )
          : const SizedBox(),
      SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(fit: StackFit.passthrough, children: [
          CustomPaint(
            painter: CustomShapePainterLiveNess(),
          ),
          // _buttonTakePicture(controller),
          _buttonStart(controller),
          _actionWidget(controller),
          _positionedAppbar(controller),
          _warningFace(controller),
          Positioned(
            left: AppDimens.padding15,
            right: AppDimens.padding15,
            bottom: Get.height / 2.2 - Get.width / 2 - 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextUtils(
                  text: LocaleKeys.live_ness_Step.tr,
                  availableStyle: StyleEnum.body14,
                  // color: AppColors.colorSemantic3,
                  textAlign: TextAlign.center,
                ),
                _itemRow(LocaleKeys.live_ness_Step1.tr),
                _itemRow(LocaleKeys.live_ness_Step2.tr),
              ],
            ),
          )
          // if (controller.imageTemp.value != null)
          //   _buildWidgetHaveImage(controller),
        ]),
      ),
    ],
  );
}

Row _itemRow(String title) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const TextUtils(
        text: "•   ",
        availableStyle: StyleEnum.body14,
        color: AppColors.basicBlack,
      ),
      Expanded(
        child: TextUtils(
          text: title,
          availableStyle: StyleEnum.body14,
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
      top: Get.height / 8,
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
                  availableStyle: StyleEnum.subNormal,
                  color: AppColors.primaryBlue1,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Column(
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
                  text: LocaleKeys.live_ness_titleSchedule.tr,
                  availableStyle: StyleEnum.body14,
                  color: AppColors.colorTextGrey,
                  maxLine: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    ),
  );
}

Visibility _buttonStart(LiveNessKycController controller) {
  return Visibility(
    visible: controller.currentStep.value == 0,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: ButtonUtils.buildButton(
        LocaleKeys.live_ness_action.tr,
        () async {
          await controller.startStreamPicture();
        },
        width: AppDimens.sizeImg,
        isLoading: controller.isShowLoading.value,
        // backgroundColor: AppColors.colorGreenText,
        borderRadius: BorderRadius.circular(AppDimens.padding12),
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
        isColorGradient: false,
        leading: true,
        // funcLeading: () async {
        //   if(controller.appController.openAppToDeepLink){
        //     Get.offAllNamed(
        //       AppRoutes.routeHome,
        //     );
        //   }else{
        //     Get.back();
        //   }
        //   // await controller.closePros();
        // },
        // backButtonColor: AppColors.basicWhite,
        // textColor: AppColors.basicWhite,
        // availableStyle: StyleEnum.bodyRegular,
        backgroundColor: AppColors.colorTransparent,
        statusBarIconBrightness: true,
        // iconSize:
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
