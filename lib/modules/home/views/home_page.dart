import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/modules/home/home.src.dart';
import 'package:module_ekyc/modules/home/views/bottom_navigation.dart';
import 'package:module_ekyc/modules/overview/overview.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';

import '../../../base_app/base_app.src.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // static final GlobalKey<_HomePageState> homePageKey =
  //     GlobalKey<_HomePageState>();

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final HomeController _controller;
  late final TabController _tabController;
  TabItem currentTab = TabItem.homePage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _controller = Get.put(HomeController());
    if (_controller.appController.tabIndex <= 5) {
      _tabController.index = _controller.appController.tabIndex;
    }
    /*else{
      // if(controller.appController.tabIndex == 5){
      //   controller.appController.typeAuthentication =
      //       AppConst.typeAuthentication;
      //   Get.toNamed(AppRoutes.routeProvision)?.then((value) {
      //     controller.appController.clearData();
      //   });
      // }
    }*/

    _tabController.addListener(() {
      if (_tabController.index == 4 || _tabController.index == 2) {
        setState(() {
          _tabController.index = _tabController.previousIndex;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        if (_controller.currentTab.value == TabItem.homePage) {
          Get.back();
        } else {
          _tabController.animateTo(0);
          _controller.funcPageChange(0);
        }
      },
      // onWillPop: () async {
      //   if (controller.currentTab.value == TabItem.homePage) {
      //     return true;
      //   } else {
      //     tabController.animateTo(0);
      //     controller.funcPageChange(0);
      //     return false;
      //   }
      // },
      child: DefaultTabController(
        length: HomeConst.tabName.length,
        child: Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              // OverviewPage(),
              OverviewPage(_tabController),
              const SizedBox(),

              const SizedBox(),
              // const DocumentsManagementPage(),
              // const NotificationPage(),
              // const PersonalPage(),
            ],
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigation(
              currentTab: _controller.currentTab.value,
              homeController: _controller,
              tabController: _tabController,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Obx(
            () => Visibility(
              visible: !_controller.isVisibleButton.value,
              child: Container(
                width: 55,
                height: 55,
                margin: const EdgeInsets.only(top: AppDimens.padding15),
                child: FloatingActionButton(
                  backgroundColor: AppColors.basicWhite,
                  onPressed: () {
                    _controller.getToAuthentication();
                    // Get.toNamed(AppRoutes.routeLiveNessKyc);
                  },
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 1, color: AppColors.basicGrey40),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: SvgPicture.asset(
                    Assets.ASSETS_SVG_ICON_HOME_AUTHENTICATION_FOCUS_SVG,
                    colorFilter: const ColorFilter.mode(
                        AppColors.basicGrey40, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildMode({required Widget child}) {
  //   return UpgradeAlert(
  //     upgrader: upgrade,
  //     child: child,
  //   );
  // }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
