import 'package:flutter/material.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/nfc_kyc/nfc_dialog/nfc_dialog.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/nfc_kyc/nfc_kyc.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';
import 'package:module_ekyc/shares/widgets/bottom_sheet/bottom_sheet.src.dart';

import '../../../../base_app/controllers_base/base_controller.src.dart';

class ScanNfcKycController extends BaseGetxController
    with WidgetsBindingObserver {
  final RxBool maybeContinue = false.obs;
  late NfcRepository nfcRepository;
  final idDocumentController = TextEditingController();
  final userNameController = TextEditingController();
  final dobController = TextEditingController();
  final doeController = TextEditingController();
  final phoneController = TextEditingController();
  AppController appController = Get.find<AppController>();
  final Rx<FocusNode> idDocumentFocus = FocusNode().obs;
  final Rx<FocusNode> userNameFocus = FocusNode().obs;
  final Rx<FocusNode> dobFocus = FocusNode().obs;
  final Rx<FocusNode> doeFocus = FocusNode().obs;
  final Rx<FocusNode> phoneFocus = FocusNode().obs;
  bool visiblePhone = true;

  String statusNFC = "";

  final formKey = GlobalKey<FormState>();

  @override
  Future<void> onInit() async {
    nfcRepository = NfcRepository(this);
    if (appController.typeAuthentication == AppConst.typeRegister ||
        appController.typeAuthentication == AppConst.typeForgotPass) {
      visiblePhone = false;
    }
    idDocumentController.text =
        appController.qrUserInformation.documentNumber ?? "";
    userNameController.text = appController.qrUserInformation.fullName ?? "";
    dobController.text = appController.qrUserInformation.dateOfBirth ?? "";
    doeController.text = appController.qrUserInformation.dateOfIssuer ?? "";
    statusNFC = await CheckSupportNfc.checkNfcAvailability();

    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      statusNFC = await CheckSupportNfc.checkNfcAvailability();
      if (Get.currentRoute == AppRoutes.routeAuthenticationGuide) {
        if (statusNFC == AppConst.nfcAvailable) {
          if (Get.isBottomSheetOpen ?? false) {
            Get.back();
            showFlushNoti(LocaleKeys.check_nfc_nfc_open.tr);
          }
        }
      }
    }
  }

  Future<void> scanNfc() async {
    // ShowDialog.funcOpenBottomSheet(const NfcDialog());
    KeyBoard.hide();
    if (statusNFC == AppConst.nfcAvailable) {
      if (GetPlatform.isIOS) {
        NfcDialogController nfcDialogController =
            Get.put(NfcDialogController());
        await nfcDialogController.scanNFC();
      } else if (GetPlatform.isAndroid) {
        ShowDialog.funcOpenBottomSheet(const NfcDialog());
      }
    } else if (statusNFC == AppConst.nfcDisabled) {
      showNfcBottomSheet(true);
    } else if (statusNFC == AppConst.nfcDisabledNotSupported) {
      showNfcBottomSheet(false);
      // // Get.toNamed(AppRoutes.routeVerifyProfile);
      // Get.toNamed(AppRoutes.routeAuthenticationGuide);
    }
  }

  void showNfcBottomSheet(bool isSupportNfc) {
    Get.bottomSheet(
      BaseBottomSheet(
        title: "",
        body: BottomSheetCheckNfc(isSupportNfc),
        noHeader: true,
      ),
      isScrollControlled: true,
    );
  }
}
