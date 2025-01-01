import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';
import 'package:flutter/material.dart';

class DropdownBase {
  static baseDropDow({
    required Map<dynamic, dynamic> mapData,
    required bool isUseKey,
    required Rx<dynamic> item,
    Function(dynamic)? onChanged,
    String? hint,
    double? underlinePadding,
    bool isEnable = false,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<dynamic>(
        selectedItemBuilder: (BuildContext context) {
          return mapData.values.map<Widget>((val) {
            return Container(
              alignment: Alignment.centerLeft,
              child: TextUtils(
                text: val,
                availableStyle: StyleEnum.bodyRegular,
              ),
            );
          }).toList();
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: Get.height / 2.5,
          width: 155,
          elevation: 2,
          offset: const Offset(-32, -10),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(AppDimens.radius18),
            // thickness: MaterialStateProperty.all<double>(
            //   6,
            // ),
            thumbVisibility: WidgetStateProperty.all<bool>(true),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.basicWhite,
            ),
            color: AppColors.basicWhite,
          ),
        ),
        isExpanded: false,
        // buttonStyleData: ButtonStyleData(
        //   height: AppDimens.btnMedium,
        //   width: Get.width,
        //   // padding: padding ??
        //   //     const EdgeInsets.only(
        //   //       left: AppDimens.paddingTabBar,
        //   //     ),
        //   elevation: 2,
        // ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.basicBorder,
          ),
          // iconSize: AppDimens.sizeDialogNotiIcon,
          // iconEnabledColor: Colors.deepOrangeAccent,
          // iconDisabledColor: Colors.grey,
        ),
        isDense: true,
        items: mapData
            .map((key, value) {
              return MapEntry(
                key,
                DropdownMenuItem<dynamic>(
                    value: key,
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.ASSETS_SVG_ICON_CALENDER_SVG)
                            .paddingOnly(right: AppDimens.padding8),
                        Expanded(
                          child: TextUtils(
                            text: mapData[key] ?? "",
                            availableStyle: StyleEnum.bodyRegular,
                            color: AppColors.basicBlack,
                          ),
                        ),
                      ],
                    )),
              );
            })
            .values
            .toList(),
        value: item.value,
        onChanged: onChanged,
      ),
    ) /*DropdownButton2<dynamic>(
      hint: TextUtils(
        text: hint ?? "",
        availableStyle: StyleEnum.bodyRegular,
        color: AppColors.basicGrey2,
      ),
      underline: Container(
          padding: EdgeInsets.symmetric(
              vertical: underlinePadding ?? AppDimens.padding5),
          child: const Divider(
            color: AppColors.colorTransparent,
            height: 2,
          )),
      selectedItemBuilder: (BuildContext context) {
        return isUseKey
            ? mapData.keys.map<Widget>((val) {
          return Container(
            alignment: Alignment.centerLeft,
            child: TextUtils(
              text: val,
              availableStyle: StyleEnum.bodyRegular,
            ),
          );
        }).toList()
            : mapData.values.map<Widget>((val) {
          return Container(
            alignment: Alignment.centerLeft,
            child: TextUtils(
              text: val,
              availableStyle: StyleEnum.bodyRegular,
            ),
          );
        }).toList();
      },
      // dropdownColor: fillColor,
      dropdownStyleData: DropdownStyleData(
        maxHeight: Get.height / 2.5,
        width: 160,
        offset: const Offset(-32, -10),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(8),
          thickness: MaterialStateProperty.all<double>(
            6,
          ),
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
        // decoration: decoration,
      ),
      isExpanded: false,
      style: const TextStyle(color: AppColors.basicBlack),
      buttonStyleData: ButtonStyleData(
        height: AppDimens.btnMedium,
        width: Get.width,
        // padding: padding ??
        //     const EdgeInsets.only(
        //       left: AppDimens.paddingTabBar,
        //     ),
        elevation: 2,
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(Icons.arrow_drop_down, color: AppColors.basicBorder,),
        // iconSize: AppDimens.sizeDialogNotiIcon,
        // iconEnabledColor: Colors.deepOrangeAccent,
        // iconDisabledColor: Colors.grey,
      ),
      // isDense: true,
      items: isUseKey
          ? mapData.keys
          .toList()
          .map<DropdownMenuItem<String>>((dynamic value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              SvgPicture.asset(Assets.ASSETS_SVG_ICON_CALENDER_SVG)
                  .paddingOnly(right: AppDimens.padding8),
              TextUtils(
                text: value,
                availableStyle: StyleEnum.bodyRegular,
                color: AppColors.basicGrey2,
              ),
            ],
          ),
        );
      }).toList()
          : mapData
          .map((key, value) {
        return MapEntry(
          key,
          DropdownMenuItem<String>(
            value: mapData[value],
            child: Row(
              children: [
                SvgPicture.asset(Assets.ASSETS_SVG_ICON_CALENDER_SVG)
                    .paddingOnly(right: AppDimens.padding8),
                Expanded(
                  child: TextUtils(
                    text: value,
                    availableStyle: StyleEnum.bodyRegular,
                    color: AppColors.basicBlack,
                  ),
                ),
              ],
            ),
          ),
        );
      })
          .values
          .toList(),
      value: item.value,
      onChanged: isEnable ? null : onChanged,
      // dropdownSearchData: dropDownSearchData,
      // onMenuStateChange: onMenuStateChange,
    )*/
        ;
  }
}
