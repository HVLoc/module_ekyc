import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';

import '../../shares.src.dart';

class BaseFormLogin {
  static Widget buildFormLogin({
    required TextEditingController textUserName,
    required TextEditingController textPassword,
    required Rx<FocusNode> userNameFocus,
    required Rx<FocusNode> passwordFocus,
    required bool isLoading,
    FocusNode? nextMode,
    required Rx<Color> fillColorUserName,
    required Rx<Color> fillColorPassword,
    required bool isSaveUser,
    required bool isShowLoading,
    required GlobalKey formKey,
    bool isForgotPassword = true,
    required Function() functionLogin,
    bool isFaceID = true,
    Function()? functionLoginBiometric,
    Function()? functionLoginOther,
    Function()? functionRegister,
    Function()? functionForgotPassword,
    final IconData? iconLeading,
    final Color? prefixIconColor,
    final String? displayName,
  }) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Visibility(
            visible: !isSaveUser,
            child: buildInputData(
              title: "" /*LocaleKeys.login_userTitle.tr*/,
              textEditingController: textUserName,
              isLoading: isLoading,
              hintText: LocaleKeys.login_userHint.tr,
              currentNode: userNameFocus,
              nextMode: nextMode,
              errorValidator: LocaleKeys.login_accountEmpty.tr,
              fillColor: fillColorUserName,
              isBiometric: isSaveUser,
              iconLeading: IconButton(
                  padding: const EdgeInsets.all(0.0),
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: SvgPicture.asset(Assets.LIB_ASSETS_SVG_ICON_USER_SVG)),
            ),
          ),
          isSaveUser
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextUtils(
                          text: displayName ?? "",
                          availableStyle: StyleEnum.subBold,
                          color: AppColors.colorBlack,
                        ),
                        sdsSBWidth8,
                        GestureDetector(
                            onTap: functionLoginOther,
                            child: SvgPicture.asset(
                                Assets.LIB_ASSETS_SVG_ICON_OTHER_USER_SVG)),
                      ],
                    ),
                    TextUtils(
                      text: textUserName.text
                          .replaceRange(7, textUserName.text.length, "*" * 5),
                      availableStyle: StyleEnum.detailRegular,
                      color: AppColors.basicBlack,
                    ),
                    sdsSBHeight5,
                  ],
                )
              : const SizedBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: buildInputData(
                  title: "" /*LocaleKeys.login_password.tr*/,
                  textEditingController: textPassword,
                  isLoading: isLoading,
                  hintText: LocaleKeys.login_passwordHint.tr,
                  currentNode: passwordFocus,
                  errorValidator: LocaleKeys.login_passwordEmpty.tr,
                  fillColor: fillColorPassword,
                  iconNextTextInputAction: TextInputAction.done,
                  isPassword: true,
                  onValidator: (text) => validatePass(text),
                  onEditingComplete: functionLogin,
                  iconLeading: ImageWidget.imageSvgIcon(
                    Assets.LIB_ASSETS_SVG_ICON_PASS_SVG,
                    height: AppDimens.padding8,
                    width: AppDimens.padding8,
                  ).paddingAll(AppDimens.padding16),
                ),
              ),
              if (isSaveUser)
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppDimens.padding11,
                    left: AppDimens.padding18,
                  ),
                  child: SizedBox(
                    width: AppDimens.iconHeightButton,
                    height: AppDimens.iconHeightButton,
                    child: GestureDetector(
                      onTap: functionLoginBiometric ?? () {},
                      child: SvgPicture.asset(
                        isFaceID
                            ? Assets.LIB_ASSETS_SVG_ICON_FACEID_SVG
                            : Assets.LIB_ASSETS_SVG_ICON_FINGERPRINT_SVG,
                        fit: BoxFit.fill,
                        width: AppDimens.iconHeightButton,
                        height: AppDimens.iconHeightButton,
                        // color: AppColors.primaryCam1,
                      ),
                    ),
                  ),
                )
            ],
          ),
          _buildOptional(
            isForgotPassword,
            functionRegister: functionRegister,
            functionForgotPassword: functionForgotPassword,
          ),
          sdsSBHeight10,
          Row(
            children: [
              Expanded(
                  child: _buildButtonLogin(isShowLoading,
                      function: functionLogin)),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: AppDimens.paddingDefault),
              //   child: SizedBox(
              //     width: AppDimens.btnMedium,
              //     height: AppDimens.btnMedium,
              //     child: IconButton(
              //       onPressed: functionLoginBiometric ?? () {},
              //       icon: Image.asset(
              //         isFaceID
              //             ? Assets.LIB_ASSETS_JPG_ICON_FACEID_PNG
              //             : Assets.LIB_ASSETS_JPG_ICON_FINGERPRINT_PNG,
              //         fit: BoxFit.fill,
              //         width: AppDimens.btnMediumMax,
              //         height: AppDimens.btnMediumMax,
              //         // color: AppColors.primaryCam1,
              //       ),
              //     ),
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }

  static Widget buildInputData({
    required String title,
    required TextEditingController textEditingController,
    required bool isLoading,
    required String hintText,
    required String errorValidator,
    required Rx<FocusNode> currentNode,
    required Rx<Color> fillColor,
    bool isBiometric = false,
    FocusNode? nextMode,
    String? Function(String?)? onValidator,
    bool isPassword = false,
    bool autoFocus = false,
    TextInputType textInputType = TextInputType.text,
    int? maxLength,
    EdgeInsetsGeometry? paddingModel,
    VoidCallback? onEditingComplete,
    TextInputAction iconNextTextInputAction = TextInputAction.next,
    final Widget? iconLeading,
    final Color? prefixIconColor,
    isValidate = false,
    int inputFormatters = InputFormatterEnum.lengthLimitingText,
  }) {
    return Obx(
      () => SDSInputWithLabel(
        inputLabelModel: SDSInputLabelModel(
          label: title,
          paddingLabel: paddingModel ??
              const EdgeInsets.symmetric(
                // horizontal: AppDimens.paddingDefault,
                vertical: AppDimens.padding4,
              ),
          isValidate: isValidate,
        ),
        inputTextFormModel: SDSInputTextModel(
          borderRadius: AppDimens.radius8,
          isShowCounterText: false,
          maxLengthInputForm: maxLength,
          validator: onValidator ??
              (value) => value.isNullOrEmpty ? errorValidator : null,
          controller: textEditingController,
          fillColor: AppColors.inputFill,
          isReadOnly: isLoading,
          hintTextSize: AppDimens.sizeTextSmall,
          hintTextColor: AppColors.basicGrey2,
          hintText: hintText,
          contentPadding: const EdgeInsets.only(
            top: AppDimens.paddingDefault,
            bottom: AppDimens.paddingDefault,
            left: AppDimens.paddingDefault,
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.radius8),
            borderSide: const BorderSide(
              color: AppColors.secondaryNavyPastel,
            ),
          ),
          obscureText: isPassword,
          iconLeading: iconLeading,
          prefixIconColor: prefixIconColor,
          focusNode: currentNode.value,
          nextNode: nextMode,
          textInputType: textInputType,
          iconNextTextInputAction: iconNextTextInputAction,
          onEditingComplete: onEditingComplete,
          inputFormatters: inputFormatters,
          autoFocus: autoFocus,
          paddingModel:
              const EdgeInsets.symmetric(vertical: AppDimens.paddingDefault),
        ),
      ),
    ).paddingOnly(bottom: AppDimens.padding5);
  }

  static Widget _buildOptional(
    bool isForgotPassword, {
    Function()? functionRegister,
    Function()? functionForgotPassword,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // GestureDetector(
        //   onTap: functionRegister,
        //   behavior: HitTestBehavior.opaque,
        //   child: RichText(
        //     text: TextSpan(
        //       text: LocaleKeys.login_notUser.tr,
        //       style: FontStyleUtils.fontStyleSans(
        //         color: AppColors.colorDisable,
        //         fontSize: AppDimens.sizeTextSmaller,
        //         fontWeight: FontWeight.w400,
        //       ),
        //       children: [
        //         TextSpan(
        //             text: LocaleKeys.login_RegisterNew.tr,
        //             style: FontStyleUtils.fontStyleSans(
        //               fontSize: AppDimens.sizeTextSmaller,
        //               color: AppColors.primaryBlue1,
        //               fontWeight: FontWeight.w700,
        //               decoration: TextDecoration.underline,
        //             )),
        //       ],
        //     ),
        //   ),
        // ),
        // sdsSB5,
        TextButton(
          onPressed: functionForgotPassword,
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: TextUtils(
            text: LocaleKeys.login_forgetPassword.tr,
            availableStyle: StyleEnum.bodyRegular,
            color: AppColors.primaryBlue1,
          ),
        )
      ],
    );
  }

  static Widget _buildButtonLogin(bool isShowLoading,
      {required Function() function}) {
    return ButtonUtils.buildButton(
      LocaleKeys.login_login.tr,
      function,
      isLoading: isShowLoading,
      backgroundColor: AppColors.primaryBlue1,
      borderRadius: BorderRadius.circular(AppDimens.radius10),
      isCenterButton: false,
    );
  }
}
