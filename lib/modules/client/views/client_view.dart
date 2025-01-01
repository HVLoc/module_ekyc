part of 'client_page.dart';

//
Widget _body(ClientController controller) {
  return Container(
    child: Column(
      children: [
        Row(
          children: [
            // sdsSBHeight40,
            Container(
              alignment: Alignment.centerLeft,
              child: TextUtils(
                text: LocaleKeys.client_filter.tr,
                availableStyle: StyleEnum.bodyRegular,
                color: AppColors.colorTextGrey,
              ),
            ),
            Container(
              height: AppDimens.padding30,
              // width: 120,
              decoration: BoxDecoration(
                // color: AppColors.inputFill,
                border: Border.all(color: AppColors.basicBorder),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    AppDimens.padding8,
                  ),
                ),
              ),
              child: Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.ASSETS_SVG_ICON_CALENDER_SVG)
                        .paddingSymmetric(horizontal: AppDimens.padding8),
                    SizedBox(
                      // width: AppDimens.size120,
                      child: DropdownBase.baseDropDow(
                        mapData: ClientCollection.listFilter,
                        isUseKey: false,
                        item: controller.indexFilter,
                        // hint: "Tất cả",
                        onChanged: (newValue) {
                          controller.selectDropdown(newValue ?? 0);
                          // controller.indexCategories = ComplainCollection
                          //         .listTypeComplainDropDow[newValue ?? ""] ??
                          //     0;
                        },
                      ),
                    ),
                  ],
                ).paddingSymmetric(
                  // horizontal: AppDimens.padding12,
                  vertical: AppDimens.padding1,
                ),
              ),
            ).paddingSymmetric(horizontal: AppDimens.padding20)
          ],
        ),
        Expanded(
          child: Obx(() => UtilWidget.baseShowLoadingChild(
              child: () => controller.listDocument.isEmpty
                  ? UtilWidget.buildEmptyList()
                  : UtilWidget.buildSmartRefresher(
                      refreshController: controller.refreshController,
                      onRefresh: controller.onRefresh,
                      onLoadMore: controller.onLoadMore,
                      enablePullUp: controller.enablePullUp.value,
                      child: ListView.builder(
                        itemBuilder: ((context, index) {
                          return _itemDocument(
                            controller.listDocument[index],
                            controller,
                          );
                        }),
                        itemCount: controller.listDocument.length,
                      ),
                    ),
              isShowLoading: controller.isShowLoadingList.value)),
        )
      ],
    ).paddingAll(
      AppDimens.padding15,
    ),
  );
}

Widget _itemDocument(
  ClientListModel clientModel,
  ClientController controller,
) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      controller.detailListClient(
        clientModel.id ?? "",
        clientModel.fileId ?? "",
        clientModel.bodyFileId ?? "",
      );
    },
    child: Container(
      decoration: const BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.all(Radius.circular(AppDimens.padding5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(Assets.ASSETS_SVG_ICON_CLIENT_SVG).paddingOnly(
                  right: AppDimens.padding15,
                  top: AppDimens.padding3,
                ),
                // sdsSBWidth12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextUtils(
                        text: clientModel.fullName ?? "",
                        availableStyle: StyleEnum.subBold,
                        maxLine: 2,
                        color: AppColors.colorBlack,
                      ),
                      sdsSBHeight3,
                      itemTitle(
                        content: LocaleKeys.client_identify.tr,
                        title: clientModel.citizenNumber ?? "",
                      ),
                      sdsSBHeight3,
                      itemTitle(
                        content: LocaleKeys.client_phoneNumber.tr,
                        title: clientModel.phone ?? "",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              sdsSBHeight3,
              TextUtils(
                text: LocaleKeys.client_registerDate.tr,
                availableStyle: StyleEnum.detailRegular,
                color: AppColors.basicGreyText,
              ),
              sdsSBHeight5,
              TextUtils(
                text: convertDateToString(
                  clientModel.createdAt,
                  pattern6,
                ),
                availableStyle: StyleEnum.detailRegular,
                color: AppColors.basicGreyText,
              ),
              sdsSBHeight3,
              Container(
                decoration: BoxDecoration(
                  color: ClientCollection
                      .mapSignType[clientModel.status] ??
                      AppColors.colorSuccess,
                ),
                child: TextUtils(
                  text: clientModel.status ?? "",
                  availableStyle: StyleEnum.bodyRegular,
                  color: AppColors.basicWhite,
                ).paddingSymmetric(
                  horizontal: AppDimens.padding8,
                  // vertical: AppDimens.padding2,
                ),
              ),
              sdsSBHeight3,
              // itemTitle(
              //   content: "Ngày xác thực: ",
              //   title: convertDateToString(
              //     clientModel.createdAt,
              //     pattern1,
              //   ),
              //   colorText: AppColors.colorTextGrey,
              // ),
              GestureDetector(
                onTap: () {
                  controller.detailListClient(
                    clientModel.id ?? "",
                    clientModel.fileId ?? "",
                    clientModel.bodyFileId ?? "",
                  );
                },
                child: TextUtils(
                  text: LocaleKeys.client_detail.tr,
                  availableStyle: StyleEnum.bodyRegular,
                  color: AppColors.primaryTextColor,
                  colorDecoration: AppColors.primaryTextColor,
                  textDecoration: TextDecoration.underline,
                ),
              ),
            ],
          )
        ],
      ).paddingAll(AppDimens.padding10),
    ).paddingSymmetric(
      vertical: AppDimens.padding8,
    ),
  );
}

Row itemTitle(
    {required String content, required String title, Color? colorText}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextUtils(
        text: content,
        availableStyle: StyleEnum.detailRegular,
        color: colorText ?? AppColors.basicBlack,
      ),
      Expanded(
        child: TextUtils(
          text: title,
          availableStyle: StyleEnum.detailRegular,
          color: colorText ?? AppColors.basicBlack,
          maxLine: 2,
        ),
      ),
    ],
  );
}
