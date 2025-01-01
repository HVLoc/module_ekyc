part of 'support_page.dart';

Widget _itemBody(SupportController controller) {
  return Column(
    children: [
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.ASSETS_SVG_ICON_LOGO_SUPPORT_SVG,
                  ).paddingOnly(right: AppDimens.padding10),
                  Flexible(
                    child: TextUtils(
                      text: (controller.supportModel.companyName ?? "")
                          .toUpperCase(),
                      availableStyle: StyleEnum.body14Bold,
                      color: AppColors.primaryText2Color,
                      maxLine: 2,
                    ),
                  ),
                ],
              ),
              sdsSBHeight25,
              _itemSupport(
                  icon: Assets.ASSETS_SVG_ICON_ADDRESS_SVG,
                  title: LocaleKeys.support_address.tr,
                  content: controller.supportModel.address ?? "",
                  function: () {}),
              _itemSupport(
                  icon: Assets.ASSETS_SVG_ICON_HOTLINE_SVG,
                  title: LocaleKeys.support_hotline1.tr,
                  content: controller.listPhone.first,
                  function: () async {
                    await UtilWidget.launchInBrowser(
                        controller.listPhone.first);
                  }),
              _itemSupport(
                  icon: Assets.ASSETS_SVG_ICON_HOTLINE_SVG,
                  title: LocaleKeys.support_hotline2.tr,
                  content: controller.listPhone.last,
                  function: () async {
                    await UtilWidget.launchInBrowser(controller.listPhone.last);
                  }),
              _itemSupport(
                  icon: Assets.ASSETS_SVG_ICON_EMAIL_SUPPORT_SVG,
                  title: LocaleKeys.support_email.tr,
                  content: controller.supportModel.email ?? "",
                  function: () async {
                    await UtilWidget.launchInBrowser(
                        controller.supportModel.email ?? "");
                  }),
              _itemSupport(
                  icon: Assets.ASSETS_SVG_ICON_WEB_SVG,
                  title: LocaleKeys.support_web.tr,
                  content: controller.supportModel.webSite ?? "",
                  function: () async {
                    await UtilWidget.launchInBrowser(
                        controller.supportModel.webSite ?? "");
                  }),
            ],
          ).paddingAll(AppDimens.padding20),
        ),
      ),
    ],
  );
}

Widget _itemSupport({
  required String icon,
  required String title,
  required String content,
  required Function function,
}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      function();
    },
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                ),
                sdsSBWidth15,
                TextUtils(
                  text: title,
                  availableStyle: StyleEnum.body14,
                ),
              ],
            ),
            Expanded(
              child: TextUtils(
                text: content,
                availableStyle: StyleEnum.body14,
                color: AppColors.primaryText2Color,
                maxLine: 4,
                textAlign: TextAlign.right,
              ).paddingOnly(
                top: AppDimens.padding4,
                left: AppDimens.padding8,
              ),
            )
          ],
        ),
        sdsSBHeight25,
      ],
    ),
  );
}
