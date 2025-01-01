import 'package:flutter/material.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/verify_profile_ca/models/login_ca_model/login_ca_model.src.dart';

import '../../../shares/shares.src.dart';
import '../../modules.src.dart';

class HomeController extends BaseGetxController {
  // late CertificateListRepository listCertRepository;
  RxInt unVerifiedCertCount = 0.obs;

  AppController appController = Get.find();

  Rx<Offset> position = Offset(Get.width - 80, Get.height / 1.4).obs;

  RxBool isTrash = false.obs;

  RxBool isShowSupportCus = true.obs;

  RxBool isBack = false.obs;

  RxBool isVisibleButton = false.obs;

  Rx<TabItem> currentTab = TabItem.homePage.obs;

  LoginCaRequestModel loginInfoRequestModel = LoginCaRequestModel(
    userName: "",
    password: "",
    isRememberMe: false,
    isBiometric: false,
  );

  @override
  void onInit() {
    // listCertRepository = CertificateListRepository(this);
    // if(appController.userInfoModel.status == AppConst.statusUserCreateNewApp){
    //   routerName(nameRouter: AppRoutes.routeChoosePackage);
    // }
    loginInfoRequestModel = hiveUserLogin.get(AppKey.keyRememberLogin) ??
        LoginCaRequestModel(
          userName: "",
          password: "",
          isRememberMe: false,
          isBiometric: false,
        );
    if (appController.tabIndex < 5) {
      currentTab.value = TabItem.values[appController.tabIndex];
    } else if (appController.tabIndex == 5) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Get.bottomSheet(
          OtherPage(controller: this),
        );
      });
      appController.tabIndex = 0;
    } else {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        getToAuthentication();
        // appController.typeAuthentication = AppConst.typeAuthentication;
        // Get.toNamed(AppRoutes.routeProvision)?.then((value) {
        //   appController.clearData();
        // });
      });
    }
    super.onInit();
    // getUnverifiedCertNumber();
  }

  // void getUnverifiedCertNumber() {
  //   listCertRepository
  //       .getCertificationList(EnumCertVerifyStatus.unVerified)
  //       .then(
  //     (response) {
  //       if (response.success == EnumStatusResponse.success) {
  //         unVerifiedCertCount.value = response.data.length;
  //       }
  //     },
  //   );
  // }
  funcPageChange(int index) {
    // pageIndex.value = index;
    if (index == 4) {
      Get.bottomSheet(
        OtherPage(controller: this),
      );
    } else {
      if (index == 2) {
        getToAuthentication();
      } else {
        currentTab.value = TabItem.values[index];
      }
    }
    // pageController.value.jumpToPage(index);
  }

  void getToAuthentication() {
    if (appController.userInfoModel.subscribeInfo == null) {
      showFlushNoti(LocaleKeys.home_notPackage.tr);
    } else if (((appController.userInfoModel.subscribeInfo?.times ?? 0)
                .toInt() -
            (appController.userInfoModel.subscribeInfo?.totalUsed ?? 0)
                .toInt()) <=
        0) {
      if (appController.isEnablePay) {
        ShowDialog.showDialogConfirm(
          LocaleKeys.home_packageExpireEnable.tr,
          // cancelFunc: () => ShowDialog.dismissDialog(),
          confirm: () async {
            await UtilWidget.launchInBrowser("0989811110");
          },
          actionTitle: LocaleKeys.home_contract.tr,
          colorTextRight: AppColors.primaryTextColor,
        );
      } else {
        showFlushNoti(LocaleKeys.home_packageExpire.tr);
      }
    } else {
      appController.typeAuthentication = AppConst.typeAuthentication;
      Get.toNamed(AppRoutes.routeProvision)?.then((value) {
        appController.clearData();
      });
    }
  }

  void funcLogout() async {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
    ShowDialog.showDialogConfirm(
      LocaleKeys.home_logoutConfirm.tr,
      // cancelFunc: () => ShowDialog.dismissDialog(),
      confirm: () {
        appController.clearData(clearUserInfo: true);
        Get.offAllNamed(AppRoutes.routeLogin);
      },
      actionTitle: LocaleKeys.home_agree.tr,
      colorTextRight: AppColors.statusRed,
    );
  }

  // void fucItem(HomeItem item) {
  //   switch (item.code) {
  //     /// màn đăng ký cts
  //     case HomeCollection.codeCreateCert:
  //       fucCreateCert();
  //       break;
  //
  //     /// màn ds chứng thư số
  //     case HomeCollection.codeViewListCTS:
  //       routerName(nameRouter: AppRoutes.routeCertificationList);
  //       break;
  //
  //     ///xác thực hồ sơ
  //     case HomeCollection.codeViewListAuth:
  //       // truyen id user sang
  //       routerName(
  //         nameRouter: AppRoutes.routeVerifyProfile,
  //         arguments: appController.userInfoModel.customerInfo?.id,
  //       );
  //       break;
  //   }
  // }

  /// Dùng để chuyển màn hình
  // void routerName({
  //   required String nameRouter,
  //   dynamic arguments,
  //   Function? fuc,
  // }) {
  //   Get.toNamed(nameRouter, arguments: arguments)?.then((value) => fuc?.call());
  // }

  // void setPositionChatBox(Offset offset) {
  //   position.value = offset;
  //   if (position.value.dx > Get.width - AppDimens.padding50) {
  //     position.value =
  //         Offset(Get.width - AppDimens.padding50, position.value.dy);
  //   }
  //   if (position.value.dy > Get.height - AppDimens.paddingPositionPhone) {
  //     position.value = Offset(
  //         position.value.dx, Get.height - AppDimens.paddingPositionPhone);
  //   }
  //   if (position.value.dx - AppDimens.padding50 <= 0) {
  //     position.value = Offset(1, position.value.dy);
  //   }
  //   if (position.value.dy - AppDimens.padding50 <= 0) {
  //     position.value = Offset(position.value.dx, 1);
  //   }
  // }

  // DateTime? _currentBackPressTime;
  //
  // Future<void> onWillPop() async {
  //   DateTime now = DateTime.now();
  //   if (_currentBackPressTime == null ||
  //       now.difference(_currentBackPressTime ?? DateTime.now()) >
  //           const Duration(seconds: 2)) {
  //     _currentBackPressTime = now;
  //     Fluttertoast.showToast(msg: LocaleKeys.home_tapExit.tr);
  //     isBack.value = false;
  //     // return Future.value(false);
  //   }
  //   isBack.value = true;
  // }
}
