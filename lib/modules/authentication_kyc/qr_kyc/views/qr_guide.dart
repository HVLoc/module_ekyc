import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/qr_kyc/qr_kyc.src.dart';
import 'package:module_ekyc/shares/widgets/form/base_form_login.dart';

import '../../../../shares/shares.src.dart';

class QRGuidePage extends BaseGetWidget<QRController> {
  const QRGuidePage({super.key});

  @override
  QRController get controller => Get.put(QRController());

  // @override
  // Widget buildWidgets() {
  //   return _buildBody();
  // }

  Widget _buildBody() {
    return Scaffold(
      backgroundColor: AppColors.basicWhite,
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                MobileScanner(
                  // fit: BoxFit.contain,
                  controller: controller.cameraController,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    // final Uint8List? image = capture.image;
                    // for (final barcode in barcodes) {
                    if (barcodes.first.rawValue != null) {
                      controller.getData(barcodes.first.rawValue ?? "");
                    }
                    // }
                  },
                  onScannerStarted: (_) {
                    controller.cameraController
                        .setZoomScale(controller.zoomX.value * 0.1);
                  },
                ),
                CustomPaint(
                  painter: CustomShapePainterDaily(),
                ),
                _buildListGuild(),
                _buildListImage(controller),
                Positioned(
                    top: Get.height / 4.2 - Get.height / 6 - 1,
                    left: 40 - 2,
                    child: Image.asset(
                      Assets.ASSETS_SVG_ICON_CORNER_LEFT_DOWN_PNG,
                      width: AppDimens.size45,
                      height: AppDimens.size45,
                      color: AppColors.primaryNavy,
                    )),
                Positioned(
                    top: Get.height / 4.2 - Get.height / 6 - 1,
                    right: 40 - 3,
                    child: Image.asset(
                      Assets.ASSETS_SVG_ICON_CORNER_RIGHT_DOWN_PNG,
                      width: AppDimens.size45,
                      height: AppDimens.size45,
                      color: AppColors.primaryNavy,
                    )),
                Positioned(
                    top: Get.height / 4.2 +
                        Get.height / 6 -
                        AppDimens.size45 +
                        2,
                    left: 40 - 2,
                    child: Image.asset(
                      Assets.ASSETS_SVG_ICON_CORNER_LEFT_UP_PNG,
                      width: AppDimens.size45,
                      height: AppDimens.size45,
                      color: AppColors.primaryNavy,
                    )),
                Positioned(
                    top: Get.height / 4.2 +
                        Get.height / 6 -
                        AppDimens.size45 +
                        1,
                    right: 40 - 1,
                    child: Image.asset(
                      Assets.ASSETS_SVG_ICON_CORNER_RIGHT_UP_PNG,
                      width: AppDimens.size45,
                      height: AppDimens.size45,
                      color: AppColors.primaryNavy,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListGuild() {
    return Positioned(
      left: 30,
      right: 30,
      top: Get.height / 3.8 + Get.height / 6 + 140,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.secondaryCamPastel2,
          borderRadius: BorderRadius.all(Radius.circular(AppDimens.radius10)),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextUtils(
              text: "Hướng dẫn:",
              color: AppColors.colorDisable,
              availableStyle: StyleEnum.subBold,
              maxLine: 3,
            ),
            TextUtils(
              text: "Bước 1: Đặt mã QR trên thẻ CCCD vào vị trí khung",
              color: AppColors.colorDisable,
              availableStyle: StyleEnum.bodyRegular,
              maxLine: 3,
            ),
            sdsSB5,
            TextUtils(
              text:
                  "Bước 2: Chờ hệ thống định danh và xác thực cho tới khi có thông báo thành công.",
              color: AppColors.colorDisable,
              availableStyle: StyleEnum.bodyRegular,
              maxLine: 3,
            ),
          ],
        ).paddingAll(AppDimens.padding15),
      ),
    );
  }

  Widget _buildListImage(QRController controller) {
    return Positioned(
      left: 20,
      right: 20,
      top: Get.height / 3.8 + Get.height / 6 + 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TextUtils(
            text: "Đặt mã QR vào khung để thực hiện xác thực CCCD",
            availableStyle: StyleEnum.bodyBold,
            color: AppColors.colorBlack,
            maxLine: 2,
            textAlign: TextAlign.center,
          ),
          // IconButton(
          //     color: Colors.white,
          //     icon: ValueListenableBuilder(
          //       valueListenable: controller.cameraController.torchState,
          //       builder: (context, state, child) {
          //         switch (state as TorchState) {
          //           case TorchState.off:
          //             return const Icon(Icons.flash_off,
          //                 color: AppColors.basicWhite);
          //           case TorchState.on:
          //             return const Icon(Icons.flash_on, color: Colors.yellow);
          //         }
          //       },
          //     ),
          //     iconSize: 32.0,
          //     onPressed: () async {
          //       controller.cameraController.toggleTorch();
          //       await Future.delayed(const Duration(milliseconds: 1500), () {
          //         controller.cameraController.toggleTorch();
          //       });
          //     }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SliderTheme(
                data: SliderThemeData(
                  trackShape: CustomTrackShape(),
                ),
                child: SizedBox(
                  width: Get.width / 2.5,
                  child: Slider(
                    value: controller.zoomX.value,
                    max: 10,
                    divisions: 5,
                    label: "${controller.zoomX.value}X",
                    activeColor: AppColors.colorBlack,
                    inactiveColor: AppColors.colorDisable,
                    onChanged: (double value) {
                      controller.zoomX.value = value;
                      controller.cameraController.setZoomScale(value * 0.1);
                    },
                  ),
                ),
              ).paddingOnly(right: 10),
              TextUtils(
                text: "Zoom ${controller.zoomX.value}X",
                color: AppColors.colorBlack,
                availableStyle: StyleEnum.subBold,
                textAlign: TextAlign.left,
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // _itemSelect("Tải ảnh lên", () async {
              //   await controller.getQrToImage();
              // }),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(BaseBottomSheet(
                    title: "",
                    body: Column(
                      children: [
                        Form(
                          key: controller.formKey,
                          child: BaseFormLogin.buildInputData(
                              title: "Số CCCD",
                              textEditingController:
                                  controller.idDocumentController,
                              isLoading: false,
                              hintText: "Nhập số CCCD",
                              textInputType: TextInputType.number,
                              currentNode: controller.idDocumentFocus,
                              errorValidator: LocaleKeys
                                  .register_account_errorValidatorCCCD.tr,
                              onValidator: (text) =>
                                  UtilWidget.validateId(text),
                              fillColor: AppColors.basicWhite.obs,
                              autoFocus: true,
                              onEditingComplete: () {
                                controller.getDataToEnter(
                                    controller.idDocumentController.text);
                              }),
                        ),
                        ButtonUtils.buildButton(
                          LocaleKeys.registerCa_continue.tr,
                          () {
                            controller.getDataToEnter(
                                controller.idDocumentController.text);
                          },
                          // isLoading: isShowLoading,
                          // backgroundColor: AppColors.primaryCam1,
                          borderRadius:
                              BorderRadius.circular(AppDimens.radius8),
                        ).paddingAll(AppDimens.paddingDefault),
                      ],
                    ),
                    noHeader: true,
                  )).then((value) => controller.idDocumentController.clear());
                },
                child: Container(
                    // decoration: BoxDecoration(
                    //   borderRadius: const BorderRadius.all(Radius.circular(10)),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: AppColors.shadow.withOpacity(0.5),
                    //       spreadRadius: -3.4,
                    //       blurRadius: 0.5,
                    //       offset: const Offset(0, -3.5),
                    //     ),
                    //   ],
                    // ),
                    // child:
                    //     SvgPicture.asset(Assets.ASSETS_SVG_ICON_BUTTON_QR_SVG)
                    ),
              ),
              // _itemSelect("Nhập số CCCD", () {
              //   Get.bottomSheet(SDSBottomSheet(
              //     title: "",
              //     body: Column(
              //       children: [
              //         Form(
              //           key: controller.formKey,
              //           child: BaseFormLogin.buildInputData(
              //               title: "Số CCCD",
              //               textEditingController:
              //                   controller.idDocumentController,
              //               isLoading: false,
              //               hintText: "Nhập số CCCD",
              //               textInputType: TextInputType.number,
              //               currentNode: controller.idDocumentFocus,
              //               errorValidator: LocaleKeys
              //                   .register_account_errorValidatorCCCD.tr,
              //               onValidator: (text) => UtilWidget.validateId(text),
              //               fillColor: AppColors.basicWhite.obs,
              //               autoFocus: true,
              //               onEditingComplete: () {
              //                 controller.getDataToEnter(
              //                     controller.idDocumentController.text);
              //               }),
              //         ),
              //         ButtonUtils.buildButton(
              //           LocaleKeys.registerCa_continue.tr,
              //           () {
              //             controller.getDataToEnter(
              //                 controller.idDocumentController.text);
              //           },
              //           // isLoading: isShowLoading,
              //           // backgroundColor: AppColors.primaryCam1,
              //           borderRadius: BorderRadius.circular(AppDimens.radius8),
              //         ).paddingAll(AppDimens.paddingDefault),
              //       ],
              //     ),
              //     noHeader: true,
              //   )).then((value) => controller.idDocumentController.clear());
              // }),
            ],
          ),
        ],
      ).paddingOnly(bottom: AppDimens.padding5),
    );
  }

  // GestureDetector _itemSelect(String title, VoidCallback action) {
  //   return GestureDetector(
  //     behavior: HitTestBehavior.opaque,
  //     onTap: action,
  //     child: Padding(
  //       padding: const EdgeInsets.only(top: 8),
  //       child: Container(
  //         alignment: Alignment.centerLeft,
  //         padding: const EdgeInsets.symmetric(horizontal: 8),
  //         height: 30,
  //         decoration: BoxDecoration(
  //           borderRadius: const BorderRadius.all(Radius.circular(8)),
  //           border: Border.all(color: AppColors.colorBlack, width: 1),
  //           color: AppColors.basicWhite,
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(0.3), // Màu bóng và độ mờ
  //               spreadRadius: 1, // Bán kính bóng
  //               blurRadius: 2, // Độ mờ
  //               offset: const Offset(0, 1), // Độ dịch chuyển của bóng
  //             ),
  //           ],
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             GestureDetector(
  //               child: TextUtils(
  //                 text: title,
  //                 availableStyle: StyleEnum.bodyRegular,
  //                 color: AppColors.colorBlack,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget buildWidgets(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        controller.onClose();
      },
      child: Scaffold(
        appBar: BackgroundAppBar.buildAppBar(
          "Cung cấp thông tin QR",
          isColorGradient: false,
          centerTitle: false,
          leading: true,
          backgroundColor: AppColors.colorTransparent,
        ),
        body: Obx(() => controller.isShowLoading.value
            ? Container(
                color: Colors.white,
                child: const Center(child: CupertinoActivityIndicator()))
            : _buildBody()),
      ),
    );
  }
}

class CustomShapePainterDaily extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Khởi tạo Paint để vẽ
    Paint paint = Paint();
    size = Get.size;

    // Tính toán các tọa độ và kích thước cho hình chữ nhật
    final centerX = size.width / 2; // Tọa độ x của trung tâm
    final centerY = size.height / 4.2; // Tọa độ y của trung tâm
    final width = size.width - 80; // Chiều rộng của hình chữ nhật
    final height = size.height / 3; // Chiều cao của hình chữ nhật

    // Tạo Path để đại diện cho phần bên ngoài của hình chữ nhật
    Path clipPath = Path()
      ..addRect(
          Rect.fromLTWH(0, 0, size.width, size.height)) // Vùng toàn màn hình
      ..addRect(Rect.fromCenter(
          center: Offset(centerX, centerY), width: width, height: height));
    clipPath.fillType = PathFillType.evenOdd;

    // Cắt phần bên trong hình chữ nhật để phần còn lại có màu trắng
    canvas.clipPath(clipPath);

    // Vẽ màu trắng xung quanh hình chữ nhật
    paint.color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Vẽ hình chữ nhật
    paint.color = Colors
        .transparent; // Hình chữ nhật sẽ trong suốt để thấy được phần viền trắng
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(centerX, centerY), width: width, height: height),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void drawDashedPath(Canvas canvas, Path path, Paint paint, double dashWidth,
      double dashSpace) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double start = 0.0;
      while (start < metric.length) {
        final end = start + dashWidth;
        canvas.drawPath(
          metric.extractPath(start, end),
          paint,
        );
        start = end + dashSpace;
      }
    }
  }
}
