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
                  child: Screenshot(
                      controller: controller.screenshotController,
                      child: CameraPreview(controller.cameraController)),
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
          if (controller.imageUInt8List.value != null)
            Container(
              height: Get.height,
              width: Get.width,
              color: AppColors.basicWhite,
            ),
          if (controller.imageUInt8List.value != null)
            Positioned(
              left: 25,
              right: 25,
              top: Get.height / 3.3 - Get.height / 6,
              child: Screenshot(
                controller: controller.screenshotControllerResult,
                child: SizedBox(
                  width: Get.size.width - 50,
                  height: Get.size.height / 2,
                  child: ClipRect(
                    child: OverflowBox(
                      maxWidth:
                          Get.size.width - AppConst.paddingLeftRightLiveNess,
                      maxHeight:
                          Get.size.height - AppConst.paddingTopBotLiveNess,
                      child: FractionalTranslation(
                        translation: const Offset(
                            AppConst.offsetLiveNessX, AppConst.offsetLiveNessY),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // Màu của border
                              width: 20.0, // Độ dày của border
                            ),
                          ),
                          child: Image.memory(
                            controller.imageUInt8List.value!,
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Visibility(
            visible: controller.imageUInt8List.value != null,
            child: Positioned(
              left: 25,
              right: 25,
              top: Get.height / 3.3 -
                  Get.height / 6 +
                  Get.size.height / 2 +
                  AppDimens.padding10,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.returnPhotos();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow.withOpacity(0.5),
                            spreadRadius: -3.4,
                            blurRadius: 0.5,
                            offset: const Offset(0, -3.5),
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        Assets.ASSETS_SVG_ICON_BUTTON_RETAKE_SVG,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          _buttonStart(controller),
          // _actionWidget(controller),
          _positionedAppbar(controller),
          // _warningFace(controller),
          // _speakerButton(controller),
          // if (controller.imageTemp.value != null)
          //   _buildWidgetHaveImage(controller),
        ]),
      ),
    ],
  );
}

// Stack _warningFace(LiveNessKycController controller) {
//   return Stack(
//     children: [
//       Visibility(
//         visible:
//             controller.isFaceEmpty.value && !controller.isSuccessLiveNess.value,
//         child: Positioned(
//           left: AppDimens.padding15,
//           right: AppDimens.padding15,
//           top: Get.height / 2 + AppDimens.padding30,
//           child: Container(
//             color: AppColors.colorGreyOpacity35,
//             child: TextUtils(
//               text: LocaleKeys.live_ness_liveNessEmptyFace.tr,
//               availableStyle: StyleEnum.detailRegular,
//               color: AppColors.basicWhite,
//               maxLine: 2,
//               textAlign: TextAlign.center,
//             ).paddingAll(8),
//           ),
//         ),
//       ),
//       Visibility(
//         visible:
//             controller.isManyFace.value && !controller.isSuccessLiveNess.value,
//         child: Positioned(
//           left: AppDimens.padding15,
//           right: AppDimens.padding15,
//           top: Get.height / 2 + AppDimens.padding30,
//           child: Container(
//             color: AppColors.colorGreyOpacity35,
//             child: TextUtils(
//               text: LocaleKeys.live_ness_liveNessManyFace.tr,
//               availableStyle: StyleEnum.detailRegular,
//               color: AppColors.basicWhite,
//               maxLine: 2,
//               textAlign: TextAlign.center,
//             ).paddingAll(8),
//           ),
//         ),
//       ),
//     ],
//   );
// }

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
//                         width: AppDimens.padding20, // Độ dày của border
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
//     left: AppDimens.padding10,
//     right: AppDimens.padding10,
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
//           horizontal: AppDimens.padding15,
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
//         ).paddingAll(AppDimens.padding15),
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
//       bottom: AppDimens.padding15,
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

// Visibility _actionWidget(LiveNessKycController controller) {
//   return Visibility(
//     visible: controller.currentStep > 0 && controller.imageTemp.value == null,
//     child: Positioned(
//       left: AppDimens.padding10,
//       right: AppDimens.padding10,
//       top: Get.height / 8,
//       child: controller.isSuccessLiveNess.isFalse
//           ? _itemAction(controller)
//               .paddingSymmetric(horizontal: AppDimens.padding20)
//           : TextUtils(
//               text: LocaleKeys.live_ness_titleTakePicture.tr,
//               availableStyle: StyleEnum.subBold,
//               color: AppColors.basicWhite,
//               maxLine: 2,
//               textAlign: TextAlign.center,
//             ),
//     ),
//   );
// }

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
//                           ? AppColors.statusYellow
//                           : AppColors.statusGreen
//                       : AppColors.basicWhite,
//                   BlendMode.srcIn),
//             ).paddingOnly(bottom: AppDimens.padding3),
//             TextUtils(
//               text: controller.questionTemp[index],
//               availableStyle: StyleEnum.detailRegular,
//               color: index <= controller.currentStep.value - 1
//                   ? index == controller.currentStep.value - 1
//                       ? AppColors.statusYellow
//                       : AppColors.statusGreen
//                   : AppColors.basicWhite,
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }

Visibility _buttonStart(LiveNessKycController controller) {
  return Visibility(
    visible: controller.currentStep.value == 0,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          controller.isShowSkip.value
              ? ButtonUtils.buildButton(
                  LocaleKeys.live_ness_authentication.tr,
                  () async {
                    await controller.skipButton();
                  },
                  isLoading: controller.isShowLoadingSkip.value,
                  backgroundColor: AppColors.basicWhite,
                  border: Border.all(width: 1, color: AppColors.primaryBlue1),
                  // borderRadius: BorderRadius.circular(AppDimens.radius4),
                  colorText: AppColors.primaryBlue1,
                ).paddingOnly(
                  bottom: AppDimens.padding10,
                )
              : const SizedBox(),
          ButtonUtils.buildButton(
            controller.imageUInt8List.value == null
                ? LocaleKeys.live_ness_takePicture.tr
                : controller.isShowSkip.value
                    ? LocaleKeys.live_ness_takeBody.tr
                    : LocaleKeys.live_ness_authentication.tr,
            () async {
              if (!controller.isShowLoadingSkip.value) {
                if (controller.isShowSkip.value) {
                  await controller.saveImage();
                } else {
                  if (controller.imageUInt8List.value == null) {
                    await controller.takePicture();
                  } else {
                    await controller.saveImage();
                  }
                }
              }
            },
            isLoading: controller.isShowLoading.value,
            backgroundColor: AppColors.primaryBlue1,
            // borderRadius: BorderRadius.circular(AppDimens.radius4),
            colorText: AppColors.basicWhite,
            // width: 200,
            // height: AppDimens.btnMediumMax,
          ) /*.paddingOnly(
              left: controller.isShowSkip.value ? AppDimens.padding5 : 0)*/
          ,
        ],
      ).paddingSymmetric(
          horizontal: AppDimens.padding25, vertical: AppDimens.padding10),
    ),
  );
}

Positioned _positionedAppbar(LiveNessKycController controller) {
  return Positioned(
    left: 0,
    right: AppDimens.padding10,
    top: 0,
    child: Align(
      alignment: Alignment.topCenter,
      child: BackgroundAppBar.buildAppBar(
          controller.fileId != ""
              ? "Chụp toàn thân khách hàng"
              : "Chụp chân dung khách hàng",
          isColorGradient: false,
          centerTitle: false,
          leading: true, funcLeading: () async {
        Get.back();
        // await controller.closePros();
      },
          backButtonColor: AppColors.colorBlack,
          textColor: AppColors.colorBlack,
          // availableStyle: StyleEnum.bodyRegular,
          // backgroundColor: AppColors.colorTransparent,
          statusBarIconBrightness: true,
          actions: [
            IconButton(
              onPressed: () async {
                await controller.toggleCameraAction();
              },
              icon: const Icon(
                Icons.switch_camera_outlined,
                size: AppDimens.padding25,
              ),
            )
          ]
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

// Visibility _speakerButton(LiveNessKycController controller) {
//   return Visibility(
//     visible: (controller.currentStep > 0),
//     child: Positioned(
//       // Get.height / 2 + 30 : center  of oval clip
//       // (Get.height / 3.2) : Y-axis radius of oval
//       top: Get.height / 2 + 30 - (Get.height / 3.2),
//       right: Get.width / 4,
//       child: Container(
//         height: AppDimens.btnMedium,
//         width: AppDimens.btnMedium,
//         decoration: BoxDecoration(
//           color: AppColors.secondaryCam2,
//           borderRadius: BorderRadius.circular(
//             AppDimens.radius10,
//           ),
//         ),
//         child: GestureDetector(
//           onTap: () {
//             controller.speakCurrentRequest();
//           },
//           child: const Icon(
//             Icons.graphic_eq_rounded,
//             size: AppDimens.btnMediumTb,
//             color: AppColors.basicWhite,
//           ),
//         ),
//       ),
//     ),
//   );
// }
