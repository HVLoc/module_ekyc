import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';

/// Lấy tên thiết bị điện thoại
String getNameDevice() {
  String nameDevice = "";
  // if (iosDeviceInfo != null) {
  //   nameDevice = iosDeviceInfo!.utsname.machine;
  // } else {
  //   nameDevice = androidDeviceInfo!.model;
  // }
  return nameDevice;
}

/// Lấy id điện thoại
String getIdDevice() {
  String idDevice = "";
  // if (iosDeviceInfo != null) {
  //   idDevice = iosDeviceInfo!.identifierForVendor.toString();
  // } else {
  //   idDevice = androidDeviceInfo!.id;
  // }
  return idDevice;
}

abstract class IdGenerator {
  IdGenerator._();

  static const _uuid = Uuid();

  static String generate() {
    return _uuid.v4();
  }

  static String get randomIKey {
    return _uuid.v4();
  }
}
