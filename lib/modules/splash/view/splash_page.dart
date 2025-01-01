import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';

class SplashPage extends GetView<AppController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AppController(), permanent: true);
    return Container(
      color: AppColors.basicGrey4,
      alignment: Alignment.center,
      child: Center(
        child: SvgPicture.asset(
          Assets.ASSETS_SVG_ICON_KYC_SVG,
          width: 136,
          height: 115,
        ),
      ),
    );
  }
}
