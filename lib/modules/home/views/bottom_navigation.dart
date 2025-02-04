import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/home/home.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.currentTab,
    // required this.onSelectTab,
    // required this.count,
    required this.homeController,
    required this.tabController,
  });
  final TabItem currentTab;

  // final ValueChanged<TabItem> onSelectTab;
  // final int count;
  final HomeController homeController;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GetPlatform.isIOS
          ? AppDimens.heightBottomTabBar
          : AppDimens.heightBottomTabBarAndroid,
      // color: AppColors.white,
      decoration: const BoxDecoration(
        color: AppColors.basicWhite,
        border: Border(
          top: BorderSide(
            color: AppColors.basicGrey40,
            width: 0.5,
          ),
        ),
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppDimens.padding20)),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3), // Màu bóng và độ mờ
        //     spreadRadius: 1, // Bán kính bóng
        //     blurRadius: 2, // Độ mờ
        //     // offset: Offset(0, 0), // Độ dịch chuyển của bóng
        //   ),
        // ],
      ),
      // decoration: const BoxDecoration(
      //     borderRadius: BorderRadius.vertical(
      //         top: Radius.circular(AppDimens.sizeBorderNavi)),
      //     color: AppColors.white),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppDimens.sizeBorderNavi)),
              child: TabBar(
                // indicator: CustomIndicator(),
                indicatorColor: Colors.transparent,
                onTap: (index) async {
                  homeController.funcPageChange(index);
                },
                splashBorderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppDimens.sizeBorderNavi)),
                controller: tabController,
                isScrollable: false,
                labelPadding: EdgeInsets.zero,
                tabs: [
                  _bottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        currentTab != TabItem.homePage
                            ? Assets
                                .PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_HOME_SVG
                            : Assets
                                .PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_HOME_FOCUS_SVG,
                      ),
                      isSelect: currentTab == TabItem.homePage,
                      label: LocaleKeys.home_homeTitle.tr),
                  _bottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        currentTab != TabItem.listUser
                            ? Assets
                                .PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_HOME_LIST_USER_SVG
                            : Assets
                                .PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_HOME_LIST_USER_FOCUS_SVG,
                      ),
                      isSelect: currentTab == TabItem.listUser,
                      label: LocaleKeys.home_user.tr),
                  _bottomNavigationBarItem(
                      icon: const SizedBox(),
                      isSelect: currentTab == TabItem.authentication,
                      label: LocaleKeys.login_authentication.tr),
                  _bottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        homeController.appController.isEnablePay
                            ? currentTab != TabItem.listPackage
                                ? Assets
                                    .PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_NOTIFICATION_HOME_SVG
                                : Assets
                                    .PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_NOTIFICATION_HOME_FOCUS_SVG
                            : currentTab != TabItem.listPackage
                                ? Assets
                                    .PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_HOME_SERVICE_PACKAGE_SVG
                                : Assets
                                    .PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_HOME_SERVICE_PACKAGE_FOCUS_SVG,
                      ),
                      isSelect: currentTab == TabItem.listPackage,
                      label: homeController.appController.isEnablePay
                          ? LocaleKeys.notification_notificationTitle.tr
                          : LocaleKeys.home_servicePackage.tr),
                  _bottomNavigationBarItem(
                      icon: SvgPicture.asset(Assets
                          .PACKAGES_SDS_ASSETS_ASSETS_SVG_ICON_HOME_OTHER_SVG),
                      isSelect: currentTab == TabItem.other,
                      label: LocaleKeys.home_other.tr)
                ],
              ).paddingOnly(
                  left: AppDimens.paddingTabBar,
                  right: AppDimens.paddingTabBar),
            ),
          ),
        ],
      ),
    );
  }

  _bottomNavigationBarItem({
    required Widget icon,
    required bool isSelect,
    required String label,
  }) {
    return SizedBox(
      width:
          Get.width / (HomeConst.tabName.length) - AppDimens.paddingTabBar / 3,
      child: Padding(
          padding: const EdgeInsets.only(
            bottom: AppDimens.paddingSmallBottomNavigation,
            left: AppDimens.paddingSmallBottomNavigation,
            right: AppDimens.paddingSmallBottomNavigation,
            top: AppDimens.paddingBottomTabBar,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20, height: 20, child: icon),
              // sdsSB8,
              TextUtils(
                text: label,
                availableStyle: /*
                    isSelect ? StyleEnum.detailBold :*/
                    StyleEnum.detailRegular,
                color:
                    isSelect ? AppColors.primaryBlue1 : AppColors.basicGrey40,
              ),
              /*                const SizedBox(
                    height: 5,
                  ),
                  isSelect
                      ? Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                              color: AppColors.colorsOrange,
                              borderRadius: BorderRadius.circular(8)),
                        )
                      : const SizedBox(),*/
            ],
          )),
    );
  }
}
