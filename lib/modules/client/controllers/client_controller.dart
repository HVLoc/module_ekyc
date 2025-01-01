import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/modules/client/repository/client_repository.dart';
import 'package:module_ekyc/modules/home/home.src.dart';
import 'package:module_ekyc/shares/utils/time/date_utils.dart';

import '../../../../shares/shares.src.dart';
import '../client.src.dart';

class ClientController extends BaseRefreshGetxController
    with WidgetsBindingObserver {
  AppController appController = Get.find<AppController>();
  RxList<ClientListModel> listDocument = <ClientListModel>[].obs;
  RxBool enablePullUp = true.obs;
  RxBool isShowLoadingList = false.obs;
  RxBool isShowLoadingButton = false.obs;
  int pageIndex = 1;
  String from = "";
  String to = "";
  String keyword = "";
  RxString textFilter = "Tất cả".obs;
  RxInt indexFilter = 0.obs;

  final TextEditingController searchTextEdit = TextEditingController();
  late ClientRepository clientRepository = ClientRepository(this);

  @override
  Future<void> onInit() async {
    WidgetsBinding.instance.addObserver(this);
    await initDocument();
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    bool isOpen = WidgetsBinding.instance.window.viewInsets.bottom > 0;
    visibleFloatButton(visible: isOpen);
  }

  Future<void> initDocument() async {
    isShowLoadingList.value = true;
    await initListDocument();
    isShowLoadingList.value = false;
  }

  Future<void> searchDocument() async {
    // visibleFloatButton();
    pageIndex = 1;
    keyword = searchTextEdit.text;
    KeyBoard.hide();
    await initDocument();
  }

  void visibleFloatButton({bool visible = false}) {
    if (Get.isRegistered<HomeController>()) {
      HomeController homeController = Get.find<HomeController>();
      homeController.isVisibleButton.value = visible;
    }
  }

  Future<void> initListDocument() async {
    await clientRepository
        .getListClient(
            page: pageIndex, pageSize: 20, from: from, to: to, keyword: keyword)
        .then((value) {
      // listDocument.value = value.data?.listDocument ?? [];
      if (pageIndex == ClientCollection.pageIndex) {
        listDocument.clear();
      }
      if (value.data.isEmpty) {
        enablePullUp.value = false;
      }
      if ((value.totalItem) > 0) {
        listDocument.addAll(value.data);
      } else {
        listDocument.clear();
      }
    });
  }

  Future<void> selectDropdown(int index) async {
    if (index != indexFilter.value && index != 4) {
      indexFilter.value = index;
      pageIndex = 1;
      DateTime now = DateTime.now();
      if (index == 0) {
        from = to = "";
      } else if (index == 1) {
        DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));
        from = convertDateToString(sevenDaysAgo, pattern15);
        to = convertDateToString(now, pattern15);
      } else if (index == 2) {
        DateTime dayFrom = now.subtract(const Duration(days: 30));
        from = convertDateToString(dayFrom, pattern15);
        to = convertDateToString(now, pattern15);
      } else if (index == 3) {
        DateTime dayFrom = now.subtract(const Duration(days: 90));
        from = convertDateToString(dayFrom, pattern15);
        to = convertDateToString(now, pattern15);
      }
      isShowLoadingList.value = true;
      await initListDocument();
      isShowLoadingList.value = false;
    } else if (index == 4) {
      ShowDialog.showDialogTime(
        confirm: () {
          Get.back();
        },
        toCalender: () async {
          Get.back();
          await _showCalender(index);
        },
        startTime: index == indexFilter.value ? from : "",
        endTime: index == indexFilter.value ? to : "",
      );
    }
  }

  Future<void> _showCalender(int index) async {
    ShowDialog.showDialogMultiTimePicker(
        listRange: [
          convertStringToDate(
              index == indexFilter.value ? to : null, patternDefault),
          convertStringToDate(
              index == indexFilter.value ? from : null, patternDefault),
        ],
        onSubmit: (value) async {
          if (value is PickerDateRange) {
            Get.back();
            ShowDialog.showDialogTime(
              confirm: () async {
                Get.back();
                await changDateTime(value, index);
              },
              toCalender: () async {
                Get.back();
                await _showCalender(index);
              },
              startTime: convertDateToString(
                  value.startDate ?? value.endDate, pattern15),
              endTime: convertDateToString(
                  value.endDate ?? value.startDate, pattern15),
            );
          }
        });
  }

  Future<void> changDateTime(PickerDateRange value, int index) async {
    if (value.startDate != null || value.endDate != null) {
      if (value.startDate != null && value.endDate != null) {
        indexFilter.value = index;
        from = convertDateToString(value.startDate, pattern15);
        to = convertDateToString(value.endDate, pattern15);
      } else if (value.startDate != null || value.endDate != null) {
        indexFilter.value = index;
        to = from =
            convertDateToString(value.startDate ?? value.endDate, pattern15);
      }
      isShowLoadingList.value = true;
      await initListDocument();
      isShowLoadingList.value = false;
    }
  }

  Future<void> detailListClient(
      String id, String fileId, String bodyFileId) async {
    KeyBoard.hide();
    showLoadingOverlay();
    await clientRepository
        .getDetailClient(id: id /*"698dd066-3b8d-4c19-a34c-66c59c2d811c"*/)
        .then((value) async {
      await clientRepository.getFile(id: fileId).then((value) {
        appController.sendNfcRequestGlobalModel.file = value.data;
      });
      if (bodyFileId != "") {
        await clientRepository.getFile(id: bodyFileId).then((value) {
          appController.sendNfcRequestGlobalModel.bodyFileId = value.data;
        });
      }
      if (value.status) {
        appController.sendNfcRequestGlobalModel.nameVNM =
            value.data?.fullName ?? "";
        appController.sendNfcRequestGlobalModel.phone = value.data?.phone ?? "";
        appController.sendNfcRequestGlobalModel.number =
            value.data?.citizenNumber ?? "";
        appController.sendNfcRequestGlobalModel.otherPaper =
            value.data?.oldCitizenNumber ?? "";
        appController.sendNfcRequestGlobalModel.dob =
            value.data?.dateOfBirth ?? "";
        appController.sendNfcRequestGlobalModel.doe =
            value.data?.dateOfExpired ?? "";
        appController.sendNfcRequestGlobalModel.sex =
            value.data?.sex == "Nam" ? "F" : "M";
        appController.sendNfcRequestGlobalModel.sexVMN = value.data?.sex ?? "";
        appController.sendNfcRequestGlobalModel.nationalityVMN =
            value.data?.nationality ?? "";
        appController.sendNfcRequestGlobalModel.religionVMN =
            value.data?.religion ?? "";
        appController.sendNfcRequestGlobalModel.nationVNM =
            value.data?.ethnic ?? "";
        appController.sendNfcRequestGlobalModel.homeTownVMN =
            value.data?.placeOfOrigin ?? "";
        appController.sendNfcRequestGlobalModel.identificationSignsVNM =
            value.data?.personalIdentification ?? "";
        appController.sendNfcRequestGlobalModel.registrationDateVMN =
            value.data?.dateProvide ?? "";
        appController.sendNfcRequestGlobalModel.nameDadVMN =
            value.data?.fatherName ?? "";
        appController.sendNfcRequestGlobalModel.nameMomVMN =
            value.data?.motherName ?? "";
        appController.sendNfcRequestGlobalModel.nameCouple =
            value.data?.coupleName ?? "";
        appController.sendNfcRequestGlobalModel.residentVMN =
            value.data?.placeOfResidence ?? "";
        appController.sendNfcRequestGlobalModel.isView = true;
        appController.sendNfcRequestGlobalModel.statusSuccess =
            value.data?.status == "Hợp lệ";
        appController.sendNfcRequestGlobalModel.kind =
            value.data?.kind ?? AppConst.typeProduction;
        appController.sendNfcRequestGlobalModel.visibleButtonDetail = false;
        hideLoadingOverlay();
        Get.toNamed(
          AppRoutes.routeNfcInformationUser,
          arguments: appController.sendNfcRequestGlobalModel,
        )?.then((value) => appController.clearData());
      }
    });
  }

  @override
  Future<void> onLoadMore() async {
    pageIndex++;
    await initListDocument();
    refreshController.loadComplete();
  }

  @override
  Future<void> onRefresh() async {
    pageIndex = 1;
    enablePullUp.value = true;
    isShowLoadingList.value = true;
    await initListDocument();
    isShowLoadingList.value = false;
  }

// Future<void> registerPackage(PackageListModel packageListModel) async {
//   isShowLoadingButton.value = true;
//   await packageRepository
//       .registerPackage(packageId: packageListModel.id ?? "")
//       .then((value) {
//     isShowLoadingButton.value = false;
//     if (value.status) {
//       Get.toNamed(AppRoutes.routeQrBill, arguments: packageListModel);
//     } else {
//       showSnackBar(value.errors?.first.message?.vn ?? "");
//     }
//   });
// }

// void initState(){
//   if()
// }
}
