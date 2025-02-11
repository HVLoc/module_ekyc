import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:flutter/material.dart';

class SDSImageNetworkModel {
  final String? imgUrl;
  final double width;
  final double height;
  final String imageDefault;
  final Widget? errorWidget;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit fit;
  final bool isAddBaseUrl;

  SDSImageNetworkModel(
    this.imgUrl, {
    this.height = AppDimens.sizeImageBig,
    this.width = AppDimens.sizeImage,
    this.imageDefault = 'packages/module_ekyc/assets/jpg/image_default.jpg',
    this.errorWidget,
    this.borderRadius,
    this.fit = BoxFit.fill,
    this.isAddBaseUrl = true,
  });
}
