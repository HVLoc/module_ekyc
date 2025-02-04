import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/shares/shares.src.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackgroundAppBar {
  static PreferredSizeWidget buildAppBar(
    String title, {
    Color? textColor,
    Color? actionsIconColor,
    Color backButtonColor = AppColors.colorBlack,
    Color? backgroundColor,
    bool centerTitle = false,
    StyleEnum? availableStyle,
    FontWeight fontWeight = FontWeight.w400,
    Function()? funcLeading,
    bool leading = true,
    List<Widget>? actions,
    bool isColorGradient = false,
    List<Color>? colorTransparent,
    TabBar? widget,
    Widget? titleWidget,
    bool statusBarIconBrightness = false,
    bool isContinuous = true,
    double? iconSize,
  }) {
    return AppBar(
      bottom: widget,
      surfaceTintColor: AppColors.basicWhite,
      actionsIconTheme:
          IconThemeData(color: actionsIconColor ?? AppColors.basicBlack),
      systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.appBarColor(),
          statusBarColor: AppColors.colorTransparent,
          statusBarBrightness:
              statusBarIconBrightness ? Brightness.dark : Brightness.light,
          statusBarIconBrightness:
              statusBarIconBrightness ? Brightness.light : Brightness.dark),
      title: titleWidget ??
          TextUtils(
            text: title,
            availableStyle: availableStyle ?? StyleEnum.subBold,
            color: textColor ?? AppColors.basicBlack,
            textAlign: TextAlign.center,
            maxLine: 2,
          ),
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      leading: !leading
          ? null
          : ButtonUtils.baseOnAction(
              onTap: () {
                if (funcLeading != null) {
                  funcLeading();
                } else {
                  Get.back();
                }
              },
              child: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.chevron_left,
                  color: backButtonColor,
                  size: iconSize ?? AppDimens.iconMedium,
                ),
              ),
              isContinuous: isContinuous,
            )
      /*BackButton(
              color: backButtonColor ?? AppColors.textColorDefault,
              onPressed: funcLeading,
            )*/
      ,
      // flexibleSpace: isColorGradient
      //     ? Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.bottomLeft,
      //       end: Alignment.bottomRight,
      //       colors: colorTransparent ??
      //           <Color>[
      //             AppColors.colorBackgroundLight,
      //             AppColors.colorBackgroundLight,
      //           ],
      //     ),
      //   ),
      // )
      //     : null,
      actions: actions,
      backgroundColor: backgroundColor,
      // isColorGradient ? null : backgroundColor ?? AppColors.colorWhite,
      titleSpacing: titleWidget == null ? null : 0,
    );
  }

  static PreferredSizeWidget buildAppBarSearch(
    TextEditingController textEditingController, {
    Color? actionsIconColor,
    // required Function() funcLeading,
    bool leading = true,
    // List<Widget>? actions,
    // TabBar? widget,
    required VoidCallback functionSearch,
    required VoidCallback onTap,
  }) {
    return AppBar(
      // bottom: widget,
      actionsIconTheme:
          IconThemeData(color: actionsIconColor ?? AppColors.basicWhite),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.basicWhite,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      title: SDSInputWithLabel(
        inputLabelModel: SDSInputLabelModel(
          label: "",
          paddingLabel: const EdgeInsets.symmetric(
            // horizontal: AppDimens.paddingDefault,
            vertical: AppDimens.padding4,
          ),
        ),
        inputTextFormModel: SDSInputTextModel(
          borderRadius: AppDimens.radius8,
          isShowCounterText: false,
          // maxLengthInputForm: maxLength,
          // validator: onValidator ??
          //         (value) => value.isNullOrEmpty ? errorValidator : null,
          controller: textEditingController,
          fillColor: AppColors.inputFillSearch,
          // isReadOnly: isLoading,
          hintTextSize: AppDimens.sizeTextSmall,
          hintTextColor: AppColors.basicGrey2,
          hintText: LocaleKeys.client_appbarSearch.tr,
          onTap: onTap,
          contentPadding: const EdgeInsets.only(
            top: AppDimens.paddingDefault,
            bottom: AppDimens.paddingDefault,
            left: AppDimens.paddingDefault,
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.radius8),
            borderSide: const BorderSide(
              color: AppColors.inputFillSearch,
            ),
          ),
          // obscureText: isPassword,
          iconLeading: IconButton(
              padding: const EdgeInsets.all(0.0),
              constraints: const BoxConstraints(),
              onPressed: () {},
              icon: SvgPicture.asset(Assets.LIB_ASSETS_SVG_ICON_SEARCH_SVG)),
          // prefixIconColor: prefixIconColor,
          // focusNode: currentNode.value,
          // nextNode: nextMode,
          textInputType: TextInputType.text,
          iconNextTextInputAction: TextInputAction.done,
          onEditingComplete: functionSearch,
          onClear: functionSearch,
          // inputFormatters: inputFormatters,
          // autoFocus: autoFocus,
          paddingModel:
              const EdgeInsets.symmetric(vertical: AppDimens.paddingDefault),
        ),
      ),
      backgroundColor: AppColors.basicWhite,
      foregroundColor: AppColors.basicWhite,
      surfaceTintColor: AppColors.basicWhite,
      // actions: actions,
      // backgroundColor:
      // isColorGradient ? null : backgroundColor ?? AppColors.colorGreenX,
      // titleSpacing: titleWidget == null ? null : 0,
    );
  }
}
