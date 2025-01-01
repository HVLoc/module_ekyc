import 'package:flutter/material.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/verify_profile_ca/repository/login_ca_repository.dart';
import 'package:module_ekyc/modules/login/login.src.dart';
import 'package:module_ekyc/shares/utils/time/date_utils.dart';

import '../../../../shares/shares.src.dart';

class OverviewController extends BaseRefreshGetxController {
  final TabController tabController;

  OverviewController(this.tabController);

  AppController appController = Get.find<AppController>();
  UserInfoModel userInfoModel = UserInfoModel();
  late LoginCaRepository loginCaRepository;
  RxString costTotal = "".obs;
  RxString totalUsed = "".obs;
  RxString namePackage = "".obs;
  RxString registerDate = "".obs;
  RxString statusPackage = "".obs;

  @override
  Future<void> onInit() async {
    userInfoModel = appController.userInfoModel;
    loginCaRepository = LoginCaRepository(this);
    _setData();
    super.onInit();
  }

  void _setData() {
    costTotal.value =
        (userInfoModel.subscribeInfo?.times ?? 0).toInt().toString();
    totalUsed.value = ((userInfoModel.subscribeInfo?.times ?? 0).toInt() -
            (userInfoModel.subscribeInfo?.totalUsed ?? 0).toInt())
        .toString();
    namePackage.value = userInfoModel.subscribeInfo?.packageName ?? "";
    registerDate.value = convertDateToString(
      userInfoModel.subscribeInfo?.createdAt,
      pattern1,
    );

  }

  Future<void> getUserInfo() async {
    await loginCaRepository.getUserInfo().then((value) {
      if (value.status) {
        appController.userInfoModel =
            userInfoModel = value.data ?? UserInfoModel();
        _setData();
      }
    });
  }

  @override
  Future<void> onLoadMore() async {}

  @override
  Future<void> onRefresh() async {
    await getUserInfo();
    refreshController.refreshCompleted();
  }
}
