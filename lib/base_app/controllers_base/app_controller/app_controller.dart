import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

late Box hiveApp;

late PackageInfo packageInfo;

IosDeviceInfo? iosDeviceInfo;

AndroidDeviceInfo? androidDeviceInfo;

late Box<LoginCaRequestModel> hiveUserLogin;

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

  Timer? timer;

  static const platform = MethodChannel('2id.ekyc');

  // Hàm gửi dữ liệu về native
  void sendDataToNative() async {
    try {
      print(sendNfcRequestGlobalModel.toJson());
      await platform.invokeMethod(
          'dataUser', {"value": sendNfcRequestGlobalModel.toJson()});
    } on PlatformException catch (e) {
      print("Error sending data: ${e.message}");
    }
  }

  @override
  Future<void> onInit() async {
    initHive().then((value) async {
      Get.put(BaseApi(), permanent: true);
      await getDataInit();
      await checkPermissionApp();
    });
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isIOS) {
      iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    } else {
      androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    }
    cameras = await availableCameras();

    super.onInit();
  }

  void startTimer(VoidCallback action) {
    const duration = Duration(minutes: AppConst.timeoutKyc);
    timer = Timer(duration, () {
      action();
      timer?.cancel();
    });
  }

  void clearData({bool clearUserInfo = false}) {
    tabIndex = 0;
    qrUserInformation = QrUserInformation();
    sendNfcRequestGlobalModel = SendNfcRequestModel();
    // hiveApp.delete(AppKey.sessionId);
    typeAuthentication = "";
    if (clearUserInfo) {
      userInfoModel = UserInfoModel();
    }
  }

  Future<void> getDataInit() async {
    try {
      final payload = await platform.invokeMethod('setInitial');
      if (payload != null) {
        final data = jsonDecode(Uri.decodeComponent(payload));

        sdkModel = SdkRequestModel(
          key: data['key'] ?? "",
          secretKey: data['secretKey'] ?? "",
        );
        qrUserInformation.documentNumber = data['CCCD'];
      }
    } catch (e) {}
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

  Future<void> checkPermissionApp() async {
    PermissionStatus permissionStatus =
        await checkPermission([Permission.camera]);
    switch (permissionStatus) {
      case PermissionStatus.granted:
        {
          goToEKYC();
        }
        break;
      case PermissionStatus.permanentlyDenied:
        ShowDialog.openAppSetting();
        break;
      default:
        return;
    }
  }

  void goToEKYC() {
    if (qrUserInformation.documentNumber.isStringNotEmpty) {
      Get.toNamed(AppRoutes.routeScanNfcKyc);
    } else {
      Get.offAllNamed(AppRoutes.routeQrKyc);
    }
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
