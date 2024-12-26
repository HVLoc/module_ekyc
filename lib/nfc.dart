import 'dart:async';

import 'package:dmrtd/dmrtd.dart';
import 'package:dmrtd/extensions.dart';
import 'package:dmrtd/src/proto/can_key.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class MethodNFC {
  Future<MrtdData?> readNFC(String can) async {
    _initPlatformState();
    print("_isNfcAvailable => $_isNfcAvailable");
    if (!_isNfcAvailable) return null;

    String errorText = "";
    if (can.isEmpty) {
      errorText = "Please enter CAN number!";
    } else if (can.length != 6) {
      errorText = "CAN number must be exactly 6 digits long!";
    }

    _alertMessage = errorText;

    //If there is an error, just jump out of the function
    if (errorText.isNotEmpty) return null;

    final canKeySeed = CanKey(can);
    MrtdData? result = await _readMRTD(accessKey: canKeySeed, isPace: true);

    return result;
  }
}

class MrtdData {
  EfCardAccess? cardAccess;
  EfCardSecurity? cardSecurity;
  EfCOM? com;
  EfSOD? sod;
  EfDG1? dg1;
  EfDG2? dg2;
  EfDG3? dg3;
  EfDG4? dg4;
  EfDG5? dg5;
  EfDG6? dg6;
  EfDG7? dg7;
  EfDG8? dg8;
  EfDG9? dg9;
  EfDG10? dg10;
  EfDG11? dg11;
  EfDG12? dg12;
  EfDG13? dg13;
  EfDG14? dg14;
  EfDG15? dg15;
  EfDG16? dg16;
  Uint8List? aaSig;
  bool? isPACE;
  bool? isDBA;
}

final Map<DgTag, String> dgTagToString = {
  EfDG1.TAG: 'EF.DG1',
  EfDG2.TAG: 'EF.DG2',
  EfDG3.TAG: 'EF.DG3',
  EfDG4.TAG: 'EF.DG4',
  EfDG5.TAG: 'EF.DG5',
  EfDG6.TAG: 'EF.DG6',
  EfDG7.TAG: 'EF.DG7',
  EfDG8.TAG: 'EF.DG8',
  EfDG9.TAG: 'EF.DG9',
  EfDG10.TAG: 'EF.DG10',
  EfDG11.TAG: 'EF.DG11',
  EfDG12.TAG: 'EF.DG12',
  EfDG13.TAG: 'EF.DG13',
  EfDG14.TAG: 'EF.DG14',
  EfDG15.TAG: 'EF.DG15',
  EfDG16.TAG: 'EF.DG16'
};

String formatEfCom(final EfCOM efCom) {
  var str = "version: ${efCom.version}\n"
      "unicode version: ${efCom.unicodeVersion}\n"
      "DG tags:";

  for (final t in efCom.dgTags) {
    try {
      str += " ${dgTagToString[t]!}";
    } catch (e) {
      str += " 0x${t.value.toRadixString(16)}";
    }
  }
  return str;
}

String formatMRZ(final MRZ mrz) {
  return "MRZ\n  version: ${mrz.version}\n  doc code: ${mrz.documentCode}\n  doc No.: ${mrz.documentNumber}\n  country: ${mrz.country}\n  nationality: ${mrz.nationality}\n  name: ${mrz.firstName}\n  surname: ${mrz.lastName}\n  gender: ${mrz.gender}\n  date of birth: ${DateFormat.yMd().format(mrz.dateOfBirth)}\n  date of expiry: ${DateFormat.yMd().format(mrz.dateOfExpiry)}\n  add. data: ${mrz.optionalData}\n  add. data: ${mrz.optionalData2}";
}

String formatDG15(final EfDG15 dg15) {
  var str = "EF.DG15:\n"
      "  AAPublicKey\n"
      "    type: ";

  final rawSubPubKey = dg15.aaPublicKey.rawSubjectPublicKey();
  if (dg15.aaPublicKey.type == AAPublicKeyType.RSA) {
    final tvSubPubKey = TLV.fromBytes(rawSubPubKey);
    var rawSeq = tvSubPubKey.value;
    if (rawSeq[0] == 0x00) {
      rawSeq = rawSeq.sublist(1);
    }

    final tvKeySeq = TLV.fromBytes(rawSeq);
    final tvModule = TLV.decode(tvKeySeq.value);
    final tvExp = TLV.decode(tvKeySeq.value.sublist(tvModule.encodedLen));

    str += "RSA\n"
        "    exponent: ${tvExp.value.hex()}\n"
        "    modulus: ${tvModule.value.hex()}";
  } else {
    str += "EC\n    SubjectPublicKey: ${rawSubPubKey.hex()}";
  }
  return str;
}

String formatProgressMsg(String message, int percentProgress) {
  final p = (percentProgress / 20).round();
  final full = "🟢 " * p;
  final empty = "⚪️ " * (5 - p);
  return "$message\n\n$full$empty";
}

var _alertMessage = "";
final _log = Logger("mrtdeg.app");
var _isNfcAvailable = false;

// MrtdData? _mrtdData;

final NfcProvider _nfc = NfcProvider();

String rawData13 = '';

// Platform messages are asynchronous, so we initialize in an async method.
Future<void> _initPlatformState() async {
  bool isNfcAvailable;
  try {
    NfcStatus status = await NfcProvider.nfcStatus;
    isNfcAvailable = status == NfcStatus.enabled;
  } on PlatformException catch (e) {
    print(e);
    isNfcAvailable = false;
  }

  _isNfcAvailable = isNfcAvailable;
}

Future<MrtdData?> _readMRTD({required AccessKey accessKey, bool isPace = false}) async {
  try {
    // _mrtdData = null;
    _alertMessage = "Waiting for Passport tag ...";

    try {
      // print("nfc.connect");
      await _nfc.connect(
          iosAlertMessage: "Hold your phone near Biometric Passport");
      // }
      print("Passport");

      final passport = Passport(_nfc);

      _alertMessage = "Reading Passport ...";

      _nfc.setIosAlertMessage("Trying to read EF.CardAccess ...");
      final mrtdData = MrtdData();

      _nfc.setIosAlertMessage("Trying to read EF.CardSecurity ...");

      try {
        //mrtdData.cardSecurity = await passport.readEfCardSecurity();
      } on PassportError {
        //if (e.code != StatusWord.fileNotFound) rethrow;
      }

      //set MrtdData
      mrtdData.isPACE = isPace;
      mrtdData.isDBA = accessKey.PACE_REF_KEY_TAG == 0x01;

      if (isPace) {
        _nfc.setIosAlertMessage("Initiating session with PACE...");
        // Fix cứng giá trị vì ios không đọc được efCardAccessData
        final efCardAccessData =
            "3134300d060804007f0007020202020101300f060a04007f000702020302020201013012060a04007f0007020204020202010202010d"
                .parseHex(); //TODO: gía trị fix cứng

        EfCardAccess efCardAccess = EfCardAccess.fromBytes(efCardAccessData);
        //PACE session
        await passport.startSessionPACE(accessKey, efCardAccess);
      } else {
        //BAC session
        await passport.startSession(accessKey as DBAKey);
      }

      _nfc.setIosAlertMessage(formatProgressMsg("Reading EF.COM ...", 0));
      mrtdData.com = await passport.readEfCOM();

      _nfc.setIosAlertMessage(formatProgressMsg("Reading Data Groups ...", 20));

      if (mrtdData.com!.dgTags.contains(EfDG1.TAG)) {
        mrtdData.dg1 = await passport.readEfDG1();
      }

      _nfc.setIosAlertMessage(
          formatProgressMsg("Vui lòng giữ nguyên CCCD", 40));
      if (mrtdData.com!.dgTags.contains(EfDG2.TAG)) {
        mrtdData.dg2 = await passport.readEfDG2();
      }

      // To read DG3 and DG4 session has to be established with CVCA certificate (not supported).
      // if(mrtdData.com!.dgTags.contains(EfDG3.TAG)) {
      //   mrtdData.dg3 = await passport.readEfDG3();
      // }

      // if(mrtdData.com!.dgTags.contains(EfDG4.TAG)) {
      //   mrtdData.dg4 = await passport.readEfDG4();
      // }
      _nfc.setIosAlertMessage(formatProgressMsg("Reading Data Groups 5", 45));

      if (mrtdData.com!.dgTags.contains(EfDG5.TAG)) {
        mrtdData.dg5 = await passport.readEfDG5();
      }

      if (mrtdData.com!.dgTags.contains(EfDG6.TAG)) {
        mrtdData.dg6 = await passport.readEfDG6();
      }

      if (mrtdData.com!.dgTags.contains(EfDG7.TAG)) {
        mrtdData.dg7 = await passport.readEfDG7();
      }

      if (mrtdData.com!.dgTags.contains(EfDG8.TAG)) {
        mrtdData.dg8 = await passport.readEfDG8();
      }

      _nfc.setIosAlertMessage(formatProgressMsg("Reading Data Groups 10", 60));

      if (mrtdData.com!.dgTags.contains(EfDG9.TAG)) {
        mrtdData.dg9 = await passport.readEfDG9();
      }

      if (mrtdData.com!.dgTags.contains(EfDG10.TAG)) {
        mrtdData.dg10 = await passport.readEfDG10();
      }

      if (mrtdData.com!.dgTags.contains(EfDG11.TAG)) {
        mrtdData.dg11 = await passport.readEfDG11();
      }

      if (mrtdData.com!.dgTags.contains(EfDG12.TAG)) {
        mrtdData.dg12 = await passport.readEfDG12();
      }
      _nfc.setIosAlertMessage(formatProgressMsg("Reading Data Groups 13", 80));
      if (mrtdData.com!.dgTags.contains(EfDG13.TAG)) {
        mrtdData.dg13 = await passport.readEfDG13();
      }

      if (mrtdData.com!.dgTags.contains(EfDG14.TAG)) {
        mrtdData.dg14 = await passport.readEfDG14();
      }

      if (mrtdData.com!.dgTags.contains(EfDG15.TAG)) {
        mrtdData.dg15 = await passport.readEfDG15();
        _nfc.setIosAlertMessage(formatProgressMsg("Doing AA ...", 60));
        mrtdData.aaSig = await passport.activeAuthenticate(Uint8List(8));
      }

      if (mrtdData.com!.dgTags.contains(EfDG16.TAG)) {
        mrtdData.dg16 = await passport.readEfDG16();
      }

      _nfc.setIosAlertMessage(formatProgressMsg("Reading EF.SOD ...", 80));
      mrtdData.sod = await passport.readEfSOD();

      // _mrtdData = mrtdData;

      _alertMessage = "";

      return mrtdData;
    } on Exception catch (e) {
      final se = e.toString().toLowerCase();
      String alertMsg = "An error has occurred while reading Passport!+\n$se";
      if (e is PassportError) {
        if (se.contains("security status not satisfied")) {
          alertMsg =
              "Failed to initiate session with passport.\nCheck input data!";
        }
        _log.error("PassportError: ${e.message}");
      } else {
        _log.error(
            "An exception was encountered while trying to read Passport: $e");
      }

      if (se.contains('timeout')) {
        alertMsg = "Timeout while waiting for Passport tag";
      } else if (se.contains("tag was lost")) {
        alertMsg = "Tag was lost. Please try again!";
      } else if (se.contains("invalidated by user")) {
        alertMsg = "";
      }

      _alertMessage = alertMsg;
    } finally {
      if (_alertMessage.isNotEmpty) {
        await _nfc.disconnect(iosErrorMessage: _alertMessage);
      } else {
        await _nfc.disconnect(
            iosAlertMessage: formatProgressMsg("Finished", 100));
      }
    }
  } on Exception catch (e) {
    _log.error("Read MRTD error: $e");
  }
}
