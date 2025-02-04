part of 'login_page.dart';

Widget _body(LoginController controller) {
  return SizedBox(
    height: Get.height,
    width: Get.width,
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GetPlatform.isAndroid ? sdsSBHeight40 : sdsSBHeight45,
              ImageAppExt.image2ID(),
              // Expanded(
              //   child: Container(
              //     alignment: Alignment.centerRight,
              //     child: TextButton(
              //       onPressed: () {},
              //       style: TextButton.styleFrom(
              //           padding: EdgeInsets.zero,
              //           alignment: Alignment.centerLeft),
              //       child: TextUtils(
              //         text: LocaleKeys.login_clause.tr,
              //         availableStyle: StyleEnum.bodyRegular,
              //         color: AppColors.primaryBlue1,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ).paddingSymmetric(vertical: AppDimens.padding15),
          /*SvgPicture.asset(
            Assets.LIB_ASSETS_SVG_ICON_KYC_SVG,
            width: 136,
            height: 115,
          )*/
          /*SvgPicture.asset(
            Assets.LIB_ASSETS_SVG_ICON_KYC_SVG,
            width: 136,
            height: 115,
          )*/
          GestureDetector(
            onTap: () {
              controller.showLog();
            },
            behavior: HitTestBehavior.opaque,
            child: ImageAppExt.imageBanner()
                .paddingSymmetric(vertical: AppDimens.padding30),
          ),
          // _buildInputData(
          //   title: LocaleKeys.login_userTitle.tr,
          //   textEditingController: controller.userNameController,
          //   isLoading: controller.isShowLoading.value,
          //   hintText: LocaleKeys.login_userHint.tr,
          //   // errorValidator: LoginSTr.errorLoginUser,
          //   currentNode: controller.userNameFocus,
          //   nextMode: controller.passwordFocus.value,
          //   errorValidator: '',
          //   fillColor: controller.fillColorUserName,
          // ),
          // _buildInputData(
          //   title: LocaleKeys.login_password.tr,
          //   textEditingController: controller.passwordController,
          //   isLoading: controller.isShowLoading.value,
          //   hintText: LocaleKeys.login_passwordHint.tr,
          //   // errorValidator: LoginSTr.errorLoginUser,
          //   currentNode: controller.passwordFocus,
          //   // nextMode: controller.passwordFocus,
          //   errorValidator: '',
          //   fillColor: controller.fillColorPassword,
          //   isPassword: true,
          // ),
          // _buildOptional(controller),
          // _buildButtonLogin(controller),
          Obx(
            () => BaseFormLogin.buildFormLogin(
              formKey: controller.formKey,
              textUserName: controller.userNameController,
              textPassword: controller.passwordController,
              userNameFocus: controller.userNameFocus,
              passwordFocus: controller.passwordFocus,
              isLoading: controller.isShowLoading.value,
              fillColorUserName: controller.fillColorUserName,
              fillColorPassword: controller.fillColorPassword,
              isSaveUser: controller.isSaveUser.value,
              displayName: controller.displayName,
              isShowLoading: controller.isShowLoading.value,
              functionLogin: () async {
                await controller.confirmLogin();
              },
              functionLoginBiometric: () async {
                await controller.loginFingerprint();
              },
              functionLoginOther: () {
                controller.loginOther();
              },
              functionRegister: () async {
                controller.appController.typeAuthentication =
                    AppConst.typeRegister;
                Get.toNamed(AppRoutes.routeProvision)?.then((value) {
                  controller.appController.clearData(clearUserInfo: true);
                });
              },
              functionForgotPassword: () async {
                controller.appController.typeAuthentication =
                    AppConst.typeForgotPass;
                await controller.checkPermissionApp();
              },
              isFaceID: controller.biometricTypes.contains(BiometricType.face),
            ),
          ),
          sdsSBHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itemListFunction(
                  icon: Assets.LIB_ASSETS_SVG_ICON_AUTHENTICATION_SVG,
                  title: LocaleKeys.login_authentication.tr,
                  action: () async {
                    await controller.loginToList(6);
                  }),
              _itemListFunction(
                  icon: Assets.LIB_ASSETS_SVG_ICON_LIST_USER_SVG,
                  title: LocaleKeys.login_listUser.tr,
                  action: () async {
                    await controller.loginToList(1);
                  }),
              Visibility(
                visible: controller.appController.isEnablePackage,
                child: _itemListFunction(
                    icon: Assets.LIB_ASSETS_SVG_ICON_SERVICE_PACKAGE_SVG,
                    title: LocaleKeys.login_servicePackage.tr,
                    action: () async {
                      await controller.loginToList(3);
                    }),
              ),
              _itemListFunction(
                icon: Assets.LIB_ASSETS_SVG_ICON_SUPPORT_SVG,
                title: LocaleKeys.login_other.tr,
                action: () async => await controller.loginToList(5),
              ),
            ],
          )
        ],
      ),
    ).paddingAll(AppDimens.padding15),
  );
}

Widget _itemListFunction({
  required String icon,
  required String title,
  required VoidCallback action,
}) {
  return Expanded(
    flex: 1,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: action,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withOpacity(0.5),
                    spreadRadius: -3.4,
                    blurRadius: 0.5,
                    offset: const Offset(0, -3.5),
                  ),
                ],
              ),
              child: SvgPicture.asset(icon)),
          sdsSBHeight5,
          TextUtils(
            text: title,
            availableStyle: StyleEnum.detailRegular,
            maxLine: 3,
            textAlign: TextAlign.center,
          )
        ],
      ).paddingSymmetric(
        horizontal: AppDimens.padding5,
      ),
    ),
  );
}

Widget _buildDevelopBy(LoginController controller) {
  return SizedBox(
    width: Get.width,
    height: 50,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              controller.appController.typeAuthentication =
                  AppConst.typeRegister;
              Get.toNamed(AppRoutes.routeProvision)?.then((value) {
                controller.appController.clearData();
              });
            },
            behavior: HitTestBehavior.opaque,
            child: RichText(
              text: TextSpan(
                text: LocaleKeys.login_notUser.tr,
                style: FontStyleUtils.fontStyleSans(
                  color: AppColors.colorDisable,
                  fontSize: AppDimens.sizeTextSmaller,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                      text: LocaleKeys.login_RegisterNew.tr,
                      style: FontStyleUtils.fontStyleSans(
                        fontSize: AppDimens.sizeTextSmaller,
                        color: AppColors.primaryBlue1,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      )),
                ],
              ),
            ),
          ),
          sdsSBHeight3,
          TextUtils(
            text: LocaleKeys.login_id.tr,
            availableStyle: StyleEnum.bodyRegular,
            textAlign: TextAlign.center,
            color: AppColors.colorDisable,
          ),
        ],
      ),
    ),
  );
}
