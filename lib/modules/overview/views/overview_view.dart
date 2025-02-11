part of 'overview_page.dart';

Widget _body(OverviewController controller, TabController tabController) {
  return UtilWidget.buildSmartRefresher(
    refreshController: controller.refreshController,
    onRefresh: controller.onRefresh,
    onLoadMore: controller.onLoadMore,
    enablePullUp: false,
    child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetPlatform.isAndroid ? sdsSBHeight40 : sdsSBHeight45,
            Container(
              alignment: Alignment.centerLeft,
              child: ImageAppExt.image2ID().paddingSymmetric(
                horizontal: AppDimens.padding20,
              ),
            ),
            _buildInfoUser(controller.appController),
            sdsSBHeight25,
            // (controller.userInfoModel.customerInfo?.isVerified ?? true)
            //     ? sdsSBHeight25
            //     : Container(
            //         alignment: Alignment.center,
            //         width: Get.width - AppDimens.padding40,
            //         decoration: const BoxDecoration(
            //           color: AppColors.borderColor,
            //           borderRadius:
            //               BorderRadius.all(Radius.circular(AppDimens.padding5)),
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             SvgPicture.asset(Assets.ASSETS_SVG_ICON_WARNING_SVG)
            //                 .paddingSymmetric(
            //               horizontal: AppDimens.padding10,
            //               vertical: AppDimens.padding20,
            //             ),
            //             Expanded(
            //               child: RichText(
            //                 textAlign: TextAlign.start,
            //                 text: TextSpan(
            //                   children: [
            //                     const TextSpan(
            //                       text:
            //                           "Tài khoản chưa xác thực, vui lòng chọn ",
            //                       style: TextStyle(
            //                         height: 1.3,
            //                         color: AppColors.basicBlack,
            //                         fontSize: AppDimens.sizeTextSmaller,
            //                       ),
            //                     ),
            //                     TextSpan(
            //                       text: "Khách hàng",
            //                       style: const TextStyle(
            //                         height: 1.3,
            //                         color: AppColors.primaryBlue1,
            //                         // fontWeight: FontWeight.bold,
            //                         fontSize: AppDimens.sizeTextSmaller,
            //                         decoration: TextDecoration.underline,
            //                       ),
            //                       recognizer: TapGestureRecognizer()
            //                         ..onTap = () {
            //                           action?.call();
            //                         },
            //                     ),
            //                     const TextSpan(
            //                       text:
            //                           " để xác thực thông tin CCCD đã đăng ký với ứng dụng!",
            //                       style: TextStyle(
            //                         height: 1.3,
            //                         color: AppColors.basicBlack,
            //                         fontSize: AppDimens.sizeTextSmaller,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ).paddingOnly(
            //                 right: AppDimens.padding5,
            //               ),
            //             )
            //           ],
            //         ),
            //       ).paddingOnly().paddingSymmetric(
            //           vertical: AppDimens.padding15,
            //         ),
            Container(
              alignment: Alignment.centerLeft,
              child: TextUtils(
                text: LocaleKeys.overView_packageUse.tr,
                availableStyle: StyleEnum.subBold,
                color: AppColors.colorBlack,
              ).paddingOnly(left: AppDimens.padding20),
            ),
            sdsSBHeight10,
            // Expanded(child: SizedBox()),
          ],
        ),
        Expanded(
          child: SizedBox(
            // height: 250,
            width: Get.width - AppDimens.padding40,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: Get.width - AppDimens.padding50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          Assets.ASSETS_JPG_ICON_BANNER_LOGIN_PNG,
                        ),
                        fit: BoxFit.fitWidth,
                        opacity: 0.3,
                      ),
                    ),
                    // child: ImageAppExt.imageBanner(),
                  ).paddingOnly(
                    top: AppDimens.padding40,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 120,
                        width: Get.width - AppDimens.padding25,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.basicBorder,
                              spreadRadius: 0.1,
                              blurRadius: 0.1,
                            ),
                          ],
                          border: Border.all(
                            color: AppColors.basicWhite,
                          ),
                          color: AppColors.basicWhite,
                        ),
                      ),
                      Obx(
                        () => Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.statusGreen),
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(20)),
                              color: AppColors.statusGreen,
                            ),
                            child: TextUtils(
                              text: controller.statusPackage.value,
                              availableStyle: StyleEnum.detailBold,
                              color: AppColors.basicWhite,
                            ).paddingSymmetric(
                                horizontal: AppDimens.padding10,
                                vertical: AppDimens.padding5),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 120,
                          alignment: Alignment.centerLeft,
                          child: Obx(
                            () => Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      sdsSBHeight20,
                                      TextUtils(
                                        text: controller.namePackage.value,
                                        availableStyle: StyleEnum.bodyBold,
                                        color: AppColors.basicBlack,
                                        maxLine: 2,
                                      ),
                                      sdsSBHeight2,
                                      itemTitle(
                                          content: LocaleKeys
                                              .overView_registerDate.tr,
                                          title: controller.registerDate.value),
                                      sdsSBHeight2,
                                      Visibility(
                                        visible: !controller
                                            .appController.isEnablePay,
                                        child: itemTitle(
                                            content: LocaleKeys.overView_sum.tr,
                                            title:
                                                "${controller.costTotal.value} ${LocaleKeys.overView_turn.tr}"),
                                      ),
                                    ],
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Center(
                                      child: SvgPicture.asset(
                                        Assets.ASSETS_SVG_ICON_CIRCLE_SVG,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextUtils(
                                              text: LocaleKeys
                                                  .overView_remaining.tr,
                                              availableStyle:
                                                  StyleEnum.detailRegular,
                                              color: AppColors.basicBlack,
                                            ),
                                            TextUtils(
                                              text: controller.totalUsed.value,
                                              availableStyle:
                                                  StyleEnum.bodyBold,
                                              color: AppColors.basicBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Align(
                                    //   alignment: Alignment.center,
                                    //   child: Container(
                                    //     color: AppColors.primaryBlue1,
                                    //     child: Column(
                                    //       mainAxisAlignment: MainAxisAlignment.center,
                                    //       crossAxisAlignment: CrossAxisAlignment.center,
                                    //       children: [
                                    //         TextUtils(
                                    //           text: "Còn lại",
                                    //           availableStyle: StyleEnum.detailRegular,
                                    //           color: AppColors.basicBlack,
                                    //         ),
                                    //         TextUtils(
                                    //           text: "Còn lại",
                                    //           availableStyle: StyleEnum.detailRegular,
                                    //           color: AppColors.basicBlack,
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                )
                              ],
                            ).paddingSymmetric(
                              horizontal: AppDimens.padding20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoUser(AppController controller) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      Get.toNamed(AppRoutes.routeUserInfo);
    },
    child: SizedBox(
      height: 230,
      child: Stack(
        children: [
          SvgPicture.asset(Assets.ASSETS_SVG_ICON_BANNER_HOME_SVG),
          Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  ImageWidget.imageSvg(
                    Assets.ASSETS_SVG_ICON_ITEM_HOME_SVG,
                    width: Get.width - AppDimens.padding40,
                  ),
                  TextUtils(
                    text: controller.userInfoModel.customerInfo?.fullName ?? "",
                    availableStyle: StyleEnum.subBold,
                    maxLine: 3,
                    color: AppColors.basicWhite,
                    textAlign: TextAlign.center,
                  ).paddingOnly(
                    top: AppDimens.padding12,
                    left: AppDimens.padding22,
                    bottom: AppDimens.padding10,
                  ),
                  TextUtils(
                    text: controller.userInfoModel.customerInfo?.citizenNumber ==
                            null
                        ? ""
                        : (controller.userInfoModel.customerInfo
                                    ?.citizenNumber ??
                                "")
                            .replaceRange(
                                (controller.userInfoModel.customerInfo
                                                ?.citizenNumber ??
                                            "")
                                        .length -
                                    5,
                                (controller.userInfoModel.customerInfo
                                            ?.citizenNumber ??
                                        "")
                                    .length,
                                "*" * 5),
                    availableStyle: StyleEnum.detailRegular,
                    maxLine: 3,
                    color: AppColors.basicWhite,
                    textAlign: TextAlign.center,
                  ).paddingOnly(
                    left: AppDimens.padding22,
                    top: AppDimens.padding42,
                  ),
                ],
              )),
        ],
      ),
    ),
  );
}

Row itemTitle({required String content, required String title}) {
  return Row(
    children: [
      TextUtils(
        text: content,
        availableStyle: StyleEnum.detailRegular,
        color: AppColors.basicBlack,
      ),
      TextUtils(
        text: title,
        availableStyle: StyleEnum.detailRegular,
        color: AppColors.basicBlack,
      ),
    ],
  );
}
