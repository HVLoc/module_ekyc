import 'package:flutter/material.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';

import '../../../assets.dart';

class ImageWidget {
  static Widget imageSvg(
    String assetName, {
    final double? width,
    final double? height,
    final Color? color,
  }) {
    return SvgPicture.asset(
      assetName,
      fit: BoxFit.contain,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(
              color,
              BlendMode.srcIn,
            )
          : null,
      width: width ?? AppDimens.padding25,
      package: 'module_ekyc',
    );
  }

  static Widget imageSvgIcon(
    String assetName, {
    final double? width,
    final double? height,
    final Color? color,
  }) {
    return SvgPicture.asset(
      assetName,
      fit: BoxFit.contain,
      height: height ?? AppDimens.iconMedium,
      colorFilter: color != null
          ? ColorFilter.mode(
              color,
              BlendMode.srcIn,
            )
          : null,
      width: width ?? AppDimens.iconMedium,
      package: 'module_ekyc',
    );
  }

  static Widget imageAsset(
    String assetName, {
    final double? width,
    final double? height,
    final Color? color,
    final BoxFit? fit,
  }) {
    return Image.asset(
      assetName,
      fit: fit ?? BoxFit.contain,
      height: height,
      width: width ?? AppDimens.padding25,
      package: 'module_ekyc',
    );
  }
}

class ImageAppExt {
  static Widget imageBanner({
    final double? width,
    final double? height,
    final double? opacity,
    final Color? color,
    final BoxFit? fit,
  }) {
    return Image.asset(
      Assets.LIB_ASSETS_JPG_ICON_BANNER_LOGIN_PNG,
      fit: fit ?? BoxFit.contain,
      height: height ?? 290.h,
      width: width ?? 335.w,
      opacity: AlwaysStoppedAnimation(opacity ?? 1.0),
      package: 'module_ekyc',
    );
  }

  static Widget image2ID({
    final double? padding,
  }) {
    return SvgPicture.asset(
      Assets.LIB_ASSETS_SVG_ICON_KYC_SMALL_SVG,
      package: 'module_ekyc',
    ).paddingOnly(left: padding ?? AppDimens.padding10);
  }
}
