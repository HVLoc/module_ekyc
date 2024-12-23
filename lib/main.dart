import 'dart:async';

import 'package:asn1lib/asn1lib.dart';
import 'package:dmrtd/dmrtd.dart';
import 'package:dmrtd/extensions.dart';
import 'package:dmrtd/src/proto/can_key.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

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

Widget _makeMrtdAccessDataWidget(
    {required String header,
    required String collapsedText,
    required bool isPACE,
    required bool isDBA}) {
  return ExpandablePanel(
      theme: const ExpandableThemeData(
        headerAlignment: ExpandablePanelHeaderAlignment.center,
        tapBodyToCollapse: true,
        hasIcon: true,
        iconColor: Colors.red,
      ),
      header: Text(header),
      collapsed: Text(collapsedText,
          softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis),
      expanded: Container(
          padding: const EdgeInsets.all(18),
          color: const Color.fromARGB(255, 239, 239, 239),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              'Access protocol: ${isPACE ? "PACE" : "BAC"}',
              //style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Access key type: ${isDBA ? "DBA" : "CAN"}',
              //style: TextStyle(fontSize: 16.0),
            )
          ])));
}

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

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.logSensitiveData = true;
  Logger.root.onRecord.listen((record) {
    print(
        '${record.loggerName} ${record.level.name}: ${record.time}: ${record.message}');
  });
  runApp(const MrtdEgApp());
}

class MrtdEgApp extends StatelessWidget {
  const MrtdEgApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: MrtdHomePage(),
    );
  }
}

class MrtdHomePage extends StatefulWidget {
  const MrtdHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MrtdHomePageState createState() => _MrtdHomePageState();
}

class _MrtdHomePageState extends State<MrtdHomePage>
    with TickerProviderStateMixin {
  var _alertMessage = "";
  final _log = Logger("mrtdeg.app");
  var _isNfcAvailable = false;
  var _isReading = false;
  final _mrzData = GlobalKey<FormState>();
  final _canData = GlobalKey<FormState>();

  // mrz data
  final _docNumber = TextEditingController(text: '');
  final _dob = TextEditingController(text: ''); // date of birth
  final _doe = TextEditingController(text: '');
  final _can = TextEditingController(text: '006031');
  bool _checkBoxPACE = false;

  MrtdData? _mrtdData;

  final NfcProvider _nfc = NfcProvider();

  // ignore: unused_field
  late Timer _timerStateUpdater;
  final _scrollController = ScrollController();
  late final TabController _tabController;

  String rawData13 = '';

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    //_tabController.addListener(_handleTabSelection);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _initPlatformState();

    // Update platform state every 3 sec
    // _timerStateUpdater = Timer.periodic(Duration(seconds: 3), (Timer t) {
    //   _initPlatformState();
    // });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initPlatformState() async {
    bool isNfcAvailable;
    try {
      NfcStatus status = await NfcProvider.nfcStatus;
      isNfcAvailable = status == NfcStatus.enabled;
    } on PlatformException {
      isNfcAvailable = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _isNfcAvailable = isNfcAvailable;
    });
  }

  DateTime? _getDOBDate() {
    if (_dob.text.isEmpty) {
      return null;
    }
    return DateFormat.yMd().parse(_dob.text);
  }

  DateTime? _getDOEDate() {
    if (_doe.text.isEmpty) {
      return null;
    }
    return DateFormat.yMd().parse(_doe.text);
  }

  Future<String?> _pickDate(BuildContext context, DateTime firstDate,
      DateTime initDate, DateTime lastDate) async {
    final locale = Localizations.localeOf(context);
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: firstDate,
        initialDate: initDate,
        lastDate: lastDate,
        locale: locale);

    if (picked != null) {
      return DateFormat.yMd().format(picked);
    }
    return null;
  }

  void _buttonPressed() async {
    print("Button pressed");
    //Check on what tab we are
    if (_tabController.index == 0) {
      //DBA tab
      String errorText = "";
      if (_doe.text.isEmpty) {
        errorText += "Please enter date of expiry!\n";
      }
      if (_dob.text.isEmpty) {
        errorText += "Please enter date of birth!\n";
      }
      if (_docNumber.text.isEmpty) {
        errorText += "Please enter passport number!";
      }

      setState(() {
        _alertMessage = errorText;
      });
      //If there is an error, just jump out of the function
      if (errorText.isNotEmpty) return;

      final bacKeySeed = DBAKey(_docNumber.text, _getDOBDate()!, _getDOEDate()!,
          paceMode: _checkBoxPACE);
      _readMRTD(accessKey: bacKeySeed, isPace: _checkBoxPACE);
    } else {
      //PACE tab
      String errorText = "";
      if (_can.text.isEmpty) {
        errorText = "Please enter CAN number!";
      } else if (_can.text.length != 6) {
        errorText = "CAN number must be exactly 6 digits long!";
      }

      setState(() {
        _alertMessage = errorText;
      });
      //If there is an error, just jump out of the function
      if (errorText.isNotEmpty) return;

      final canKeySeed = CanKey(_can.text);
      _readMRTD(accessKey: canKeySeed, isPace: true);
    }
  }

  void _readMRTD({required AccessKey accessKey, bool isPace = false}) async {
    try {
      setState(() {
        _mrtdData = null;
        _alertMessage = "Waiting for Passport tag ...";
        _isReading = true;
      });
      try {
        bool demo = false;
        if (!demo) {
          await _nfc.connect(
              iosAlertMessage: "Hold your phone near Biometric Passport");
        }

        final passport = Passport(_nfc);

        setState(() {
          _alertMessage = "Reading Passport ...";
        });

        _nfc.setIosAlertMessage("Trying to read EF.CardAccess ...");
        final mrtdData = MrtdData();

        // try {
        //   mrtdData.cardAccess = await passport.readEfCardAccess();
        // } on PassportError catch (e) {
        //   print("erorrrrr 2 " + e.message);
        //   //if (e.code != StatusWord.fileNotFound) rethrow;
        // } catch (e) {
        //   print("erorrrrr " + e.toString());
        // }

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

        _nfc.setIosAlertMessage(
            formatProgressMsg("Reading Data Groups ...", 20));

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

        _nfc.setIosAlertMessage(
            formatProgressMsg("Reading Data Groups 10", 60));

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
        _nfc.setIosAlertMessage(
            formatProgressMsg("Reading Data Groups 13", 80));
        if (mrtdData.com!.dgTags.contains(EfDG13.TAG)) {
          mrtdData.dg13 = await passport.readEfDG13();

          rawData13 = _getDg13VNM(mrtdData.dg13);
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

        setState(() {
          _mrtdData = mrtdData;
        });

        setState(() {
          _alertMessage = "";
        });

        _scrollController.animateTo(300.0,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
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

        setState(() {
          _alertMessage = alertMsg;
        });
      } finally {
        if (_alertMessage.isNotEmpty) {
          await _nfc.disconnect(iosErrorMessage: _alertMessage);
        } else {
          await _nfc.disconnect(
              iosAlertMessage: formatProgressMsg("Finished", 100));
        }
        setState(() {
          _isReading = false;
        });
      }
    } on Exception catch (e) {
      _log.error("Read MRTD error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  bool _disabledInput() {
    //return true;
    return _isReading || !_isNfcAvailable;
  }

  Widget _makeMrtdDataWidget(
      {required String header,
      required String collapsedText,
      required dataText}) {
    return ExpandablePanel(
        theme: const ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          tapBodyToCollapse: true,
          hasIcon: true,
          iconColor: Colors.red,
        ),
        header: Text(header),
        collapsed: Text(collapsedText,
            softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis),
        expanded: Container(
            padding: const EdgeInsets.all(18),
            color: const Color.fromARGB(255, 239, 239, 239),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    child: const Text('Copy'),
                    onPressed: () =>
                        Clipboard.setData(ClipboardData(text: dataText)),
                  ),
                  SelectableText(dataText, textAlign: TextAlign.left)
                ])));
  }

  List<Widget> _mrtdDataWidgets() {
    List<Widget> list = [];
    if (_mrtdData == null) return list;

    if (_mrtdData!.isPACE != null && _mrtdData!.isDBA != null) {
      list.add(_makeMrtdAccessDataWidget(
          header: "Access protocol",
          collapsedText: '',
          isDBA: _mrtdData!.isDBA!,
          isPACE: _mrtdData!.isPACE!));
    }

    if (_mrtdData!.cardAccess != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.CardAccess',
          collapsedText: '',
          dataText: _mrtdData!.cardAccess!.toBytes().hex()));
    }

    if (_mrtdData!.cardSecurity != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.CardSecurity',
          collapsedText: '',
          dataText: _mrtdData!.cardSecurity!.toBytes().hex()));
    }

    if (_mrtdData!.sod != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.SOD',
          collapsedText: '',
          dataText: _mrtdData!.sod!.toBytes().hex()));
    }

    if (_mrtdData!.com != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.COM',
          collapsedText: '',
          dataText: formatEfCom(_mrtdData!.com!)));
    }

    if (_mrtdData!.dg1 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG1',
          collapsedText: '',
          dataText: formatMRZ(_mrtdData!.dg1!.mrz)));
    }

    if (_mrtdData!.dg2 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG2',
          collapsedText: '',
          dataText: _mrtdData!.dg2!.toBytes().hex()));
    }

    if (_mrtdData!.dg3 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG3',
          collapsedText: '',
          dataText: _mrtdData!.dg3!.toBytes().hex()));
    }

    if (_mrtdData!.dg4 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG4',
          collapsedText: '',
          dataText: _mrtdData!.dg4!.toBytes().hex()));
    }

    if (_mrtdData!.dg5 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG5',
          collapsedText: '',
          dataText: _mrtdData!.dg5!.toBytes().hex()));
    }

    if (_mrtdData!.dg6 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG6',
          collapsedText: '',
          dataText: _mrtdData!.dg6!.toBytes().hex()));
    }

    if (_mrtdData!.dg7 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG7',
          collapsedText: '',
          dataText: _mrtdData!.dg7!.toBytes().hex()));
    }

    if (_mrtdData!.dg8 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG8',
          collapsedText: '',
          dataText: _mrtdData!.dg8!.toBytes().hex()));
    }

    if (_mrtdData!.dg9 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG9',
          collapsedText: '',
          dataText: _mrtdData!.dg9!.toBytes().hex()));
    }

    if (_mrtdData!.dg10 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG10',
          collapsedText: '',
          dataText: _mrtdData!.dg10!.toBytes().hex()));
    }

    if (_mrtdData!.dg11 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG11',
          collapsedText: '',
          dataText: _mrtdData!.dg11!.toBytes().hex()));
    }

    if (_mrtdData!.dg12 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG12',
          collapsedText: '',
          dataText: _mrtdData!.dg12!.toBytes().hex()));
      list.add(
        _makeMrtdDataWidget(
          header: 'EF.DG12 Raw',
          collapsedText: '',
          dataText: _getDg13VNM(_mrtdData!.dg12),
        ),
      );
    }

    if (_mrtdData!.dg13 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG13',
          collapsedText: '',
          dataText: _mrtdData!.dg13!.toBytes().hex()));
    }
    if (rawData13.isNotEmpty) {
      list.add(_makeMrtdDataWidget(
          header: 'rawData13', collapsedText: '', dataText: rawData13));
    }

    if (_mrtdData!.dg14 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG14',
          collapsedText: '',
          dataText: _mrtdData!.dg14!.toBytes().hex()));
    }

    if (_mrtdData!.dg15 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG15',
          collapsedText: '',
          dataText: _mrtdData!.dg15!.toBytes().hex()));
    }

    if (_mrtdData!.aaSig != null) {
      list.add(_makeMrtdDataWidget(
          header: 'Active Authentication signature',
          collapsedText: '',
          dataText: _mrtdData!.aaSig!.hex()));
    }

    if (_mrtdData!.dg16 != null) {
      list.add(_makeMrtdDataWidget(
          header: 'EF.DG16',
          collapsedText: '',
          dataText: _mrtdData!.dg16!.toBytes().hex()));
    }

    return list;
  }

  Scaffold _buildPage(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MRTD Example App'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  _initPlatformState();
                },
                child: const Icon(
                  Icons.refresh,
                ))
          ],
        ),
        // iosContentPadding: false,
        // iosContentBottomPadding: false,
        body: Material(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildForm(context),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        // btn Read MRTD
                        onPressed: _buttonPressed,
                        child:
                            Text(_isReading ? 'Reading ...' : 'Read Passport'),
                      ),
                      const SizedBox(height: 20),
                      Row(children: <Widget>[
                        const Text('NFC available:',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4),
                        Text(_isNfcAvailable ? "Yes" : "No",
                            style: const TextStyle(fontSize: 18.0))
                      ]),
                      const SizedBox(height: 15),
                      Text(_alertMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(_mrtdData != null ? "Passport Data:" : "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 8.0, bottom: 8.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _mrtdDataWidgets()))
                            ]),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      );

  Widget _buildForm(BuildContext context) {
    return Column(children: <Widget>[
      TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        tabs: const <Widget>[
          Tab(text: 'DBA'),
          Tab(text: 'PACE'),
        ],
      ),
      SizedBox(
          height: 350,
          child: TabBarView(controller: _tabController, children: <Widget>[
            Card(
              borderOnForeground: false,
              elevation: 0,
              color: Colors.white,
              //shadowColor: Colors.white,
              margin: const EdgeInsets.all(16.0),
              child: Form(
                key: _mrzData,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      enabled: !_disabledInput(),
                      controller: _docNumber,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Passport number',
                          fillColor: Colors.white),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]+')),
                        LengthLimitingTextInputFormatter(14)
                      ],
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.characters,
                      autofocus: true,
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'Please enter passport number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                        enabled: !_disabledInput(),
                        controller: _dob,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Date of Birth',
                            fillColor: Colors.white),
                        autofocus: false,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'Please select Date of Birth';
                          }
                          return null;
                        },
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          // Can pick date which dates 15 years back or more
                          final now = DateTime.now();
                          final firstDate =
                              DateTime(now.year - 90, now.month, now.day);
                          final lastDate =
                              DateTime(now.year - 15, now.month, now.day);
                          final initDate = _getDOBDate();
                          final date = await _pickDate(context, firstDate,
                              initDate ?? lastDate, lastDate);

                          FocusScope.of(context).requestFocus(FocusNode());
                          if (date != null) {
                            _dob.text = date;
                          }
                        }),
                    const SizedBox(height: 12),
                    TextFormField(
                        enabled: !_disabledInput(),
                        controller: _doe,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Date of Expiry',
                            fillColor: Colors.white),
                        autofocus: false,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'Please select Date of Expiry';
                          }
                          return null;
                        },
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          // Can pick date from tomorrow and up to 10 years
                          final now = DateTime.now();
                          final firstDate =
                              DateTime(now.year, now.month, now.day + 1);
                          final lastDate =
                              DateTime(now.year + 1000, now.month + 6, now.day);
                          final initDate = _getDOEDate();
                          final date = await _pickDate(context, firstDate,
                              initDate ?? firstDate, lastDate);

                          FocusScope.of(context).requestFocus(FocusNode());
                          if (date != null) {
                            _doe.text = date;
                          }
                        }),
                    const SizedBox(height: 12),
                    CheckboxListTile(
                      title: const Text('DBA with PACE'),
                      value: _checkBoxPACE,
                      onChanged: (newValue) {
                        setState(() {
                          _checkBoxPACE = !_checkBoxPACE;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            Card(
              borderOnForeground: false,
              elevation: 0,
              color: Colors.white,
              //shadowColor: Colors.white,
              margin: const EdgeInsets.all(16.0),
              child: Form(
                key: _canData,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      enabled: !_disabledInput(),
                      controller: _can,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CAN number',
                          fillColor: Colors.white),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+')),
                        LengthLimitingTextInputFormatter(6)
                      ],
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.characters,
                      // autofocus: true,
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'Please enter CAN number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            )
          ]))
    ]);
  }

  String removeSpecialCharacters(String input) {
    return input.replaceAll(
        RegExp(
            r'[^\w\s\r\f\t,:/-áàảãạăắằẳẵặâấầẩẫậéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵÁÀẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬÉÈẺẼẸÊẾỀỂỄỆÍÌỈĨỊÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢÚÙỦŨỤƯỨỪỬỮỰÝỲỶỸỴđĐ]'),
        '');
  }

  String _getDg13VNM(DataGroup? byteDg13) {
    if (byteDg13 == null) return "";
    Uint8List encodedData = Uint8List.fromList(byteDg13.toBytes());
    ASN1Parser parser = ASN1Parser(encodedData);
    ASN1Object asn1Object = parser.nextObject();
    if (asn1Object is ASN1Sequence) {
      ASN1Sequence sequence = asn1Object;
      String asn1Data = sequence.elements[0].toString();
      RegExp regex = RegExp(r'(UTF8String|PrintableString)\((.*?)\)');
      Iterable<Match> matches = regex.allMatches(asn1Data);
      List<String> listDg13 = [];
      for (Match match in matches) {
        // String stringType = match.group(1)??"";
        String value = match.group(2) ?? "";
        listDg13.add(value);
      }
      var raw = listDg13.join(", ");
      return raw;
    }
    return "";
  }
}
