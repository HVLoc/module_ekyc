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
            left: AppDimens.padding5,
            right: AppDimens.padding5,
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

// Stack _buildWidgetHaveImage(LiveNessKycController controller) {
//   return Stack(
//     children: [
//       Positioned.fill(
//           child: Container(
//         color: AppColors.colorBlack,
//       )),
//       Positioned(
//         left: AppDimens.padding25,
//         right: AppDimens.padding25,
//         top: Get.height / 3.3 - Get.height / 6,
//         child: Screenshot(
//           controller: controller.screenshotControllerResult,
//           child: SizedBox(
//             width: Get.size.width - AppDimens.padding50,
//             height: Get.size.height / 2,
//             child: ClipRect(
//               child: OverflowBox(
//                 maxWidth: Get.size.width,
//                 maxHeight: Get.size.height,
//                 child: FractionalTranslation(
//                   translation: const Offset(0.00, 0.01),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: AppColors.basicBlack, // Màu của border
//                         width: AppDimens.btnSmall, // Độ dày của border
//                       ),
//                     ),
//                     child: Image.memory(
//                       controller.imageTemp.value!,
//                       // fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       _buildFinish(controller),
//     ],
//   );
// }

// Widget _buildFinish(LiveNessKycController controller) {
//   return Positioned(
//     left: AppDimens.sizeTextSmallest,
//     right: AppDimens.sizeTextSmallest,
//     bottom: AppDimens.padding6,
//     child: Column(
//       children: [
//         ButtonUtils.buildButton(LocaleKeys.live_ness_agree.tr, () async {
//           await controller.finishLiveNess();
//         },
//                 isLoading: controller.isShowLoading.value,
//                 backgroundColor: AppColors.primaryCam1,
//                 borderRadius: BorderRadius.circular(AppDimens.radius4),
//                 colorText: AppColors.basicWhite)
//             .paddingSymmetric(
//           horizontal: AppDimens.padding8,
//         ),
//         ButtonUtils.buildButton(
//           LocaleKeys.live_ness_capture.tr,
//           () async {
//             await controller.returnPhotos();
//           },
//           // isLoading: controller.isShowLoading.value,
//           backgroundColor: AppColors.colorTransparent,
//           border: Border.all(width: 1, color: AppColors.primaryCam1),
//           borderRadius: BorderRadius.circular(AppDimens.radius4),
//           colorText: AppColors.primaryCam1,
//         ).paddingAll(AppDimens.padding8),
//       ],
//     ),
//   );
// }

// Visibility _buttonTakePicture(LiveNessKycController controller) {
//   return Visibility(
//     visible: controller.isSuccessLiveNess.value &&
//         controller.imageTemp.value == null,
//     child: Positioned(
//       left: AppDimens.padding40,
//       right: AppDimens.padding40,
//       bottom: AppDimens.padding8,
//       child: GestureDetector(
//         onTap: () async {
//           if (!controller.isManyFace.value && !controller.isFaceEmpty.value) {
//             await controller.takePicture();
//           }
//         },
//         child: Center(
//           child: SvgPicture.asset(Assets.ASSETS_SVG_ICON_TAKE_PICTURE_SVG),
//         ),
//       ),
//     ),
//   );
// }

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
                  availableStyle: StyleEnum.body14,
                  color: AppColors.colorGreenText,
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

// Row _itemAction(LiveNessKycController controller) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       ...List.generate(
//         controller.listFaceDetectionTemp.length,
//         (index) => Column(
//           children: [
//             SvgPicture.asset(
//               controller.listFaceDetectionTemp[index],
//               colorFilter: ColorFilter.mode(
//                   index <= controller.currentStep.value - 1
//                       ? index == controller.currentStep.value - 1
//                           ? AppColors.colorErrorText
//                           : AppColors.colorSemantic2
//                       : AppColors.basicWhite,
//                   BlendMode.srcIn),
//             ).paddingOnly(bottom: AppDimens.paddingSmallest),
//             // TextUtils(
//             //   text: controller.questionTemp[index],
//             //   availableStyle: StyleEnum.body14,
//             //   color: index <= controller.currentStep.value - 1
//             //       ? index == controller.currentStep.value - 1
//             //           ? AppColors.colorErrorText
//             //           : AppColors.colorSemantic2
//             //       : AppColors.basicWhite,
//             // ),
//           ],
//         ),
//       ),
//     ],
//   );
// }

Visibility _buttonStart(LiveNessKycController controller) {
  return Visibility(
    visible: controller.currentStep.value == 0,
    child: Positioned(
      left: AppDimens.padding8,
      right: AppDimens.padding8,
      bottom: AppDimens.padding8,
      child: ButtonUtils.buildButton(
        LocaleKeys.live_ness_action.tr,
        () async {
          await controller.startStreamPicture();
        },
        isLoading: controller.isShowLoading.value,
        backgroundColor: AppColors.colorGreenText,
        borderRadius: BorderRadius.circular(AppDimens.padding12),
        colorText: AppColors.basicWhite,
      ),
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
