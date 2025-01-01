part of 'provision_page.dart';

Widget _itemBody(ProvisionController controller) {
  return Column(
    children: [
      Expanded(
        child: SingleChildScrollView(
          child: HtmlWidget(
            controller.html,
            // textStyle: Get.textTheme.bodyLarge
            //     ?.copyWith(fontSize: AppDimens.sizeTextSmall, height: 1.6),
            onTapUrl: (url) {
              // openUrlString(url);
              return true;
            },
            enableCaching: true,
          ).paddingAll(AppDimens.padding15),
        ),
      ),
      sdsSB5,
      ButtonUtils.buildButton(LocaleKeys.home_agree.tr, () async {
        await controller.checkPermissionApp();
      },
              width: AppDimens.sizeImg,
              // isLoading: controller.isLoadingOverlay.value,
              backgroundColor: AppColors.primaryBlue1,
              colorText: AppColors.basicWhite)
          .paddingSymmetric(horizontal: AppDimens.padding12),
      GetPlatform.isAndroid ? sdsSB5 : sdsSBHeight10,
    ],
  );
}
