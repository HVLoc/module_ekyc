import 'package:flutter/services.dart';

import 'package:module_ekyc/module_ekyc.dart';

class ModuleEkyc {
  static const _platform = MethodChannel(AppConst.channelEkyc);

  ModuleEkyc() {
    setNativeListeners();
  }

  void setNativeListeners() {
    _platform.setMethodCallHandler((methodCall) async {
      switch (methodCall.method) {
        case AppConst.qr:
          print("setNativeListeners qr");
        case AppConst.captureCCCD:
          print("setNativeListeners captureCCCD");
        case AppConst.nfc:
          print("setNativeListeners nfc");
          await  MethodNFC().readNFC('000631');
        case AppConst.liveness:
          print("setNativeListeners liveness");
        case AppConst.faceMactching:
          print("setNativeListeners faceMactching");
        default:
          throw MissingPluginException();
      }
    });
  }
}
