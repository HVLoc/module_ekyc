import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hive/hive.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/hive_helper/hive_adapters.dart';
import 'package:module_ekyc/hive_helper/register_adapters.dart';
import 'package:module_ekyc/modules/authentication_kyc/nfc_kyc/nfc_kyc.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/qr_kyc/qr_kyc.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/verify_profile_ca/models/login_ca_model/login_ca_model.src.dart';
import 'package:module_ekyc/modules/login/login.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../modules/sdk/sdk.src.dart';

late Box hiveApp;

late PackageInfo packageInfo;

late Box<LoginCaRequestModel> hiveUserLogin;

const platform = MethodChannel('2id.ekyc');

typedef GuidNFC = Widget? Function(ScanNfcKycController controller);

class AppController extends GetxController {
  RxBool isBusinessHousehold = false.obs;
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  // AuthProfileResponseModel authProfileRequestModel = AuthProfileResponseModel();
  QrUserInformation qrUserInformation = QrUserInformation();
  SendNfcRequestModel sendNfcRequestGlobalModel = SendNfcRequestModel();
  UserInfoModel userInfoModel = UserInfoModel();
  SdkRequestModel sdkModel = SdkRequestModel();
  String typeAuthentication = "";
  int tabIndex = 0;
  RxBool isFingerprintOrFaceID = false.obs;
  bool isFaceID = false;
  bool isEnablePay = false;
  bool isEnablePackage = false;

  bool isOnlyNFC = false;
  bool isScanEKYC = false;

  GuidNFC? guidNFC;

  ///  Hàm gửi dữ liệu về native
  /// [isOnlyNFC] = true dữ liệu NFC về native không cần liveness và xác thực
  void sendDataToNative() async {
    try {
      String methodData = isOnlyNFC ? 'dataNFC' : 'dataUser';
      await platform.invokeMethod(
          methodData, {"value": sendNfcRequestGlobalModel.toJsonFull()});
    } on PlatformException catch (e) {
      print("Error sending data: ${e.message}");
    }
  }

  void sendDataToModulesEkyc() async {
    try {
      // Sau khi xong thì back về màn đầu tiên để trả kết quả
      Get.until((route) => Get.routing.current == AppRoutes.initApp);

      // Get.offNamed(AppRoutes.initApp);
      // Get.close(3);
      Get.back();
      // Get.back(result: sendNfcRequestGlobalModel);
    } catch (e) {
      print("Error sending data: $e");
    }
  }

  @override
  Future<void> onInit() async {
    Get.put(BaseApi(), permanent: true);
    initializeMethod();
    await initHive();

    super.onInit();
  }

  // Future<void> demoModule() async {
  //   sdkModel = SdkRequestModel(
  //     key: "89f797ab-ec41-446a-8dc1-1dfda5e7e93d",
  //     secretKey: "63f81c69722acaa42f622ec16d702fdb",
  //     isProd: false,
  //   );

  //   await checkPermissionApp();
  // }

  void clearData({bool clearUserInfo = false}) {
    qrUserInformation = QrUserInformation();
    sendNfcRequestGlobalModel = SendNfcRequestModel();

    if (clearUserInfo) {
      userInfoModel = UserInfoModel();
    }
  }

  void initializeMethod() {
    platform.setMethodCallHandler((MethodCall call) async {
      if (call.method == 'setInitialNFC') {
        // final String? data = call.arguments as String?;
        // Xử lý dữ liệu từ iOS
        isOnlyNFC = true;

        await checkPermissionApp();
      } else if (call.method == 'setInitial') {
        if (call.arguments != null) {
          print("Received from iOS call.arguments: ${call.arguments}");
          final data = jsonDecode(Uri.decodeComponent(call.arguments));
          qrUserInformation.documentNumber = data['CCCD'];

          sdkModel = SdkRequestModel(
            merchantKey: data['merchantKey'] ?? "",
            secretKey: data['secretKey'] ?? "",
            apiKey: data['apiKey'] ?? "",
            method: data['method'] ?? "",
            documentNumber: data['CCCD'],
            isProd: data['isProd'] ?? false,
          );

          await checkPermissionApp();
        }
      }
      return null;
    });
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
    );
    await cameraController.initialize();
  }

  Future<SendNfcRequestModel?> checkPermissionApp() async {
    PermissionStatus permissionStatus =
        await checkPermission([Permission.camera]);
    switch (permissionStatus) {
      case PermissionStatus.granted:
        {
          return await goToEKYC();
        }
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
        ShowDialog.openAppSetting();
        break;
      default:
        return null;
    }
    return null;
  }

  Future<SendNfcRequestModel?> goToEKYC() async {
    if (qrUserInformation.documentNumber.isStringNotEmpty) {
      await Get.toNamed(AppRoutes.routeScanNfcKyc);
    } else {
      await Get.toNamed(AppRoutes.routeQrKyc);
    }
    return sendNfcRequestGlobalModel;
  }
}

Future<void> initHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  hiveApp = await Hive.openBox(LocaleKeys.app_name.tr);
  registerAdapters();
  await openBox();
  packageInfo = await PackageInfo.fromPlatform();
}

Future<void> openBox() async {
  hiveUserLogin = await Hive.openBox(HiveAdapters.loginCaRequestModel);
}
