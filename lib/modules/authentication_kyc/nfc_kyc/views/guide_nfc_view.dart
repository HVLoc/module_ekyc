part of 'nfc_kyc_page.dart';

Widget _bodyGuide(ScanNfcKycController controller) {
  return SizedBox(
    height: Get.width,
    child: ImageWidget.imageAsset(
      GetPlatform.isAndroid
          ? Assets.ASSETS_PNG_NFC_ANDROID_PNG
          : Assets.ASSETS_PNG_NFC_IOS_PNG,
      width: Get.width - 100,
    ),
  );
}
