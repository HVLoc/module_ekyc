import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';
import 'package:module_ekyc/shares/utils/time/date_utils.dart';

class QRController extends BaseGetxController {
  String? barcodeController;
  String? idIdentity;
  String? information;
  String? informationIdCard;
  final AppController appController = Get.find<AppController>();
  final ImagePicker picker = ImagePicker();
  final idDocumentController = TextEditingController();
  final Rx<FocusNode> idDocumentFocus = FocusNode().obs;
  final formKey = GlobalKey<FormState>();

  // UserInformation userInformation = UserInformation();
  late MobileScannerController cameraController;
  RxDouble zoomX = 6.0.obs;

  @override
  Future<void> onInit() async {
    showLoading();
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      // torchEnabled: true,
    );
    hideLoading();

    super.onInit();
  }

  // @override
  // void dispose() {
  //   cameraController.dispose();
  //   super.dispose();
  // }

  @override
  void onClose() {
    cameraController.dispose();
  }

  void getDataToEnter(String text) {
    if (formKey.currentState?.validate() ?? false) {
      appController.qrUserInformation.documentNumber = text;
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
      if (appController.typeAuthentication == AppConst.typeForgotPass) {
        cameraController.stop();
        Get.toNamed(AppRoutes.routeScanNfcKyc)?.then((value) {
          cameraController.start();
        });
      } else {
        Get.offNamed(AppRoutes.routeScanNfcKyc);
      }
    }
  }

  void getData(String barcodeScanRes) {
    try {
      cameraController.stop();
      barcodeController = barcodeScanRes;
      idIdentity = barcodeController?.substring(0, 12);
      information = barcodeController?.substring(13);
      List<String> splitStrings = information?.split("|") ?? [];
      if (splitStrings.isNotEmpty) {
        DateTime? dateTimeDob = _convertDatetimeQr(splitStrings[2]);
        DateTime? dateTimeDor = _convertDatetimeQr(splitStrings[5]);
        if (dateTimeDob != null && dateTimeDor != null) {
          appController.qrUserInformation.documentNumber = idIdentity;
          appController.qrUserInformation.dateOfBirth =
              convertDateToString(dateTimeDob, pattern1);
          appController.qrUserInformation.dateOfIssuer =
              convertDateToString(dateTimeDor, pattern1);
          appController.qrUserInformation.dateOfExpiry = convertDateToString(
            calculateExpiryDate(dateTimeDob, dateTimeDor),
            pattern1,
          );
          appController.qrUserInformation.fullName = splitStrings[1];
          appController.qrUserInformation.gender = splitStrings[3];
          appController.qrUserInformation.gender = splitStrings[4];
          appController.qrUserInformation.informationIdCard = splitStrings[0];
        }
        // if (splitStrings[0] == "") {
        //   appController.qrUserInformation.informationIdCard = "";
        //
        // }else{
        //   appController.qrUserInformation.informationIdCard = splitStrings[0];
        // }
        if (appController.typeAuthentication == AppConst.typeForgotPass) {
          // cameraController.start();
          Get.toNamed(AppRoutes.routeScanNfcKyc)?.then((value) {
            cameraController.start();
          });
        } else {
          Get.offNamed(AppRoutes.routeScanNfcKyc);
        }
      }
    } catch (e) {
      cameraController.start();
      showFlushNoti(
        "QR không hợp lệ",
        type: FlushBarType.error,
      );
    }
  }

// print(calculateExpiryDate(_convertDatetimeQr(splitStrings[5])),
//     _convertDatetimeQr(splitStrings[5]))
// );
// userInformation.documentNumber = idIdentity;
// userInformation.raw = barcodeController;Yeah
//
// for (var i = 0; i < splitStrings.length; i++) {
//   if (splitStrings[0] == "") {
//     userInformation.fullName = splitStrings[1];
//     userInformation.dateOfBirth = formatDateString(splitStrings[2]);
//     // userInformation.dateOfBirth = splitStrings[2];
//     userInformation.gender = splitStrings[3];
//     userInformation.address = splitStrings[4];
//     userInformation.dateOfIssuer = formatDateString(splitStrings[5]);
//     userInformation.informationIdCard = "";
//   } else {
//     userInformation.informationIdCard = splitStrings[0];
//     userInformation.fullName = splitStrings[1];
//     userInformation.dateOfBirth = formatDateString(splitStrings[2]);
//     // userInformation.dateOfBirth = splitStrings[2];
//     userInformation.gender = splitStrings[3];
//     userInformation.address = splitStrings[4];
//     userInformation.dateOfIssuer = formatDateString(splitStrings[5]);
//   }
// }
}

DateTime? calculateExpiryDate(DateTime? birthDate, DateTime? issueDate) {
  if (birthDate != null && issueDate != null) {
    Duration difference = issueDate.difference(birthDate);

    int numberYear = difference.inDays ~/ 365;

    if (numberYear < 23) {
      return DateTime(birthDate.year + 25, birthDate.month, birthDate.day);
    } else if (23 <= numberYear && numberYear < 38) {
      return DateTime(birthDate.year + 40, birthDate.month, birthDate.day);
    } else if (38 <= numberYear && numberYear <= 58) {
      return DateTime(birthDate.year + 60, birthDate.month, birthDate.day);
    } else {
      return null;
    }
  }
  return null;
}

DateTime? _convertDatetimeQr(String dateString) {
  if (dateString.length == 8) {
    int day = int.parse(dateString.substring(0, 2));
    int month = int.parse(dateString.substring(2, 4));
    int year = int.parse(dateString.substring(4, 8));

    return DateTime(year, month, day);
  }
  return null;
}
