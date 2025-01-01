import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:screenshot/screenshot.dart';
import 'package:module_ekyc/base_app/controllers_base/base_controller/base_controller.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/live_ness/live_ness_kyc.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/nfc_information_user/nfc_information_user_src.dart';

import '../../../../shares/shares.src.dart';

class LiveNessKycController extends BaseGetxController {
  // ScreenshotController screenshotController = ScreenshotController();
  // ScreenshotController screenshotControllerResult = ScreenshotController();

  late CameraController cameraController;

  // final UpdateInformationController updateInformationController =
  //     Get.find<UpdateInformationController>();
  // final AppController appController = Get.find<AppController>();
  // late UpdatePhotoInformationRepository updatePhotoInformationRepository;

  late LiveNessRepository liveNessRepository;

  Rx<Uint8List?> imageTemp = Rx<Uint8List?>(null);
  String urlRecordVideoTemp = "";
  late List<CameraDescription> cameras;
  RxBool cameraIsInitialize = false.obs;
  RxBool isShowLoadingSkip = false.obs;

  // final FaceDetector _faceDetector = FaceDetector(
  //   options: FaceDetectorOptions(
  //     enableContours: true,
  //     enableLandmarks: true,
  //     enableClassification: true,
  //   ),
  // );

  List<String> typesTemp = [];
  RxList<String> listFaceDetectionTemp = <String>[].obs;
  List<String> questionTemp = [];
  int lastQuestion = -1;
  int randomIndex = 10;
  List<int> numbers = [0, 1, 2, 3, 4, 5];
  String fileId = "";

  // FilesImageModel filesImageLiveNess = FilesImageModel(
  //   fileData: Rx<Uint8List?>(null),
  //   fileType: AppConst.fileTypeFace,
  // );

  /// dùng để radom action

  bool isStreamingImage = false;
  bool isTakeFront = false;
  bool detecting = false;
  RxBool isFaceEmpty = false.obs;
  RxBool isManyFace = false.obs;
  String question = '';
  String type = '';
  RxInt currentStep = 0.obs;
  RxBool isSuccessLiveNess = false.obs;

  ///list api
  List<double> listSmiling = [];
  List<String> listOrderSequence = [];
  List<String> listFaceDirection = [];
  Uint8List? imageLiveNess;
  double eyeOpenRightOld = 1.0;
  double eyeOpenLeftOld = 1.0;

  ///take picture
  ScreenshotController screenshotController = ScreenshotController();
  ScreenshotController screenshotControllerResult = ScreenshotController();
  Rx<Uint8List?> imageUInt8List = Rx<Uint8List?>(null);
  RxBool isTakeBody = false.obs;
  RxBool isShowSkip = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    showLoadingOverlay();
    liveNessRepository = LiveNessRepository(this);
    await initCamera();
    // randomListQuestion();
    await TTSManager.init();
    hideLoadingOverlay();
    speakCurrentRequest();
  }

  @override
  Future<void> onClose() async {
    TTSManager.stop();
    super.onClose();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    await cameraController.initialize();
    cameraIsInitialize.value = cameraController.value.isInitialized;
  }

  Future<void> toggleCameraAction() async {
    showLoadingOverlay();
    await toggleCamera();
    hideLoadingOverlay();
  }

  Future<void> toggleCamera() async {
    final List<CameraDescription> cameras = await availableCameras();
    final CameraDescription newCamera =
        cameraController.description == cameras[0] ? cameras[1] : cameras[0];
    cameraIsInitialize.value = false;
    await cameraController.dispose();
    cameraController = CameraController(
      newCamera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );

    await cameraController.initialize();
    cameraIsInitialize.value = cameraController.value.isInitialized;
  }

  Future<void> takePicture() async {
    // await cameraController.stopImageStream();
    try {
      cameraController.pausePreview();
      await takePictureScreen();
    } catch (e) {
      await cameraController.resumePreview();
    }
  }

  Future<void> returnPhotos() async {
    await cameraController.resumePreview();
    imageUInt8List.value = null;
    if (isShowSkip.value) {
      isShowSkip.value = false;
    }
  }

  Future<void> takePictureScreen() async {
    // cameraController.pausePreview();
    showLoading();
    imageUInt8List.value = await screenshotController.capture(
      pixelRatio: 3,
      delay: 10.milliseconds,
    );
    if (!isTakeBody.value) {
      isShowSkip.value = true;
    }
    hideLoading();
  }

  Future<void> saveImage() async {
    showLoading();
    try {
      Uint8List? imagePicture = await screenshotControllerResult.capture(
        pixelRatio: 3,
        delay: 10.milliseconds,
      );
      if (isTakeBody.value) {
        await liveNessRepository
            .sendFileRepository(imagePicture!)
            .then((value) async {
          if (value.status) {
            if (Get.isRegistered<NfcInformationUserController>()) {
              NfcInformationUserController nfcInformationUserController =
                  Get.find<NfcInformationUserController>();
              await nfcInformationUserController.authentication(
                fileId,
                value.data?.filename ?? "",
              );
              Get.until((route) =>
                  Get.currentRoute == AppRoutes.routeNfcInformationUser);
              hideLoading();
            }
          }
          hideLoading();
        });
      } else {
        await liveNessRepository
            .sendFileRepository(imagePicture!)
            .then((value) async {
          if (value.status) {
            fileId = value.data?.filename ?? "";
            isTakeBody.value = true;
            isShowSkip.value = false;

            // if (Get.isRegistered<NfcInformationUserController>()) {
            //   NfcInformationUserController nfcInformationUserController =
            //       Get.find<NfcInformationUserController>();
            //   await nfcInformationUserController
            //       .authentication(value.data?.filename ?? "");
            //   Get.until((route) =>
            //       Get.currentRoute == AppRoutes.routeNfcInformationUser);
            //   hideLoading();
            // }
          }
          await returnPhotos();
          // await toggleCamera();
          hideLoading();
        });
      }
    } catch (e) {
      await returnPhotos();
      showFlushNoti(
        LocaleKeys.live_ness_takeError.tr,
        type: FlushBarType.error,
      );
    } finally {
      hideLoading();
    }
  }

  Future<void> skipButton() async {
    if (!isShowLoading.value) {
      isShowLoadingSkip.value = true;
      await liveNessRepository
          .sendFileRepository(imageUInt8List.value!)
          .then((value) async {
        if (value.status) {
          fileId = value.data?.filename ?? "";
        }
        if (Get.isRegistered<NfcInformationUserController>()) {
          NfcInformationUserController nfcInformationUserController =
              Get.find<NfcInformationUserController>();
          await nfcInformationUserController.authentication(
            fileId,
            "",
          );
          Get.until(
              (route) => Get.currentRoute == AppRoutes.routeNfcInformationUser);
          isShowLoadingSkip.value = false;
        }
      });
    }
  }

  void speakCurrentRequest() {
    TTSManager.stop();
    String textTmp = '';
    if (currentStep.value <= AppConst.currentStepMax) {
      if (currentStep.value == 0) {
        textTmp = LocaleKeys.live_ness_instructLiveNess.tr;
      } else {
        textTmp = questionTemp[currentStep.value - 1];
      }

      TTSManager.speak(textTmp);
    }
  }

// Future<void> startStreamPicture() async {
//   if (!isStreamingImage) {
//     isStreamingImage = true;
//     if (!cameraController.value.isRecordingVideo) {
//       cameraController.startVideoRecording(onAvailable: (image) async {
//         if (!detecting) {
//           await _processImage(image);
//         }
//       });
//     }
//   }
// }
//
// Future<void> closePros() async {
//   TTSManager.stop();
//   isStreamingImage = false;
//   if (cameraController.value.isRecordingVideo) {
//     await cameraController.stopVideoRecording();
//   }
//   await _faceDetector.close();
//   await cameraController.dispose();
// }

  /// Xử lý khung hình và trả về kết quả hành động vào action
// Future<void> _processImage(CameraImage image) async {
//   detecting = true;
//   InputImage? inputImage = CameraImageConverter.inputImageFromCameraImage(
//     image,
//     cameras[1],
//     cameraController,
//   );
//   if (inputImage != null) {
//     final faces = await _faceDetector.processImage(inputImage);
//     if (faces.isNotEmpty) {
//       isManyFace.value = faces.length > 1;
//
//       isFaceEmpty.value = false;
//       if (currentStep.value == 0) {
//         // randomQuestion();
//         currentStep.value++;
//         type = typesTemp[currentStep.value - 1];
//         speakCurrentRequest();
//       }
//       LiveNessDetectionData liveNessData = LiveNessDetector(
//         faces,
//         eyeOpenRightOld,
//         eyeOpenLeftOld,
//       ).liveNess(type);
//       eyeOpenRightOld = faces[0].rightEyeOpenProbability ?? 0.0;
//       eyeOpenLeftOld = faces[0].leftEyeOpenProbability ?? 0.0;
//       question = liveNessData.question;
//       if (isSuccessLiveNess.value) {
//         await liveNessSuccess();
//       } else {
//         if (currentStep.value <= AppConst.currentStepMax) {
//           if (question.compareTo(questionTemp[currentStep.value - 1]) == 0) {
//             if (question
//                     .compareTo(LocaleKeys.live_ness_actionFaceBetween.tr) ==
//                 0) {
//               await Future.delayed(const Duration(milliseconds: 500));
//               await waitAtLeast(
//                   isolateConvertImg(inputImage), const Duration(seconds: 2));
//               // await isolateConvertImg(inputImage);
//             }
//             currentStep.value++;
//             speakCurrentRequest();
//             if (listSmiling.length < AppConst.currentStepMax) {
//               listSmiling.add(liveNessData.percentSmile);
//             }
//             if (currentStep.value <= AppConst.currentStepMax) {
//               type = typesTemp[currentStep.value - 1];
//             }
//           }
//         } else {
//           isSuccessLiveNess.value = true;
//           ShowDialog.successDialog(LocaleKeys.live_ness_liveNessSuccess.tr);
//           await Future.delayed(const Duration(milliseconds: 1000), () {
//             Get.back();
//           });
//         }
//       }
//     } else {
//       isManyFace.value = false;
//       isFaceEmpty.value = true;
//     }
//   }
//   detecting = false;
// }
//
// void randomListQuestion() {
//   for (int i = 0; i < AppConst.currentStepMax; i++) {
//     var rng = Random();
//     randomIndex = rng.nextInt(numbers.length);
//     lastQuestion = numbers[randomIndex];
//     if (numbers[randomIndex] == 4 || numbers[randomIndex] == 5) {
//       for (int i = 0; i < typesTemp.length; i++) {
//         if (typesTemp[i] == LocaleKeys.live_ness_faceSmile.tr ||
//             typesTemp[i] == LocaleKeys.live_ness_faceOpen.tr) {
//           numbers.removeAt(randomIndex);
//           randomIndex = rng.nextInt(numbers.length);
//         }
//       }
//     }
//     _addListQuestion(numbers[randomIndex]);
//     numbers.removeAt(randomIndex);
//   }
// }
//
// void _addListQuestion(int index) {
//   listFaceDetectionTemp.add(LiveNessCollection.listFaceDetach[index]);
//   typesTemp.add(LiveNessCollection.types[index]);
//   questionTemp.add(LiveNessCollection.questions[index]);
// }
//
// Future<T> waitAtLeast<T>(Future<T> future, Duration minDuration) async {
//   final results = await Future.wait([future, Future.delayed(minDuration)]);
//   return results[0] as T;
// }

  ///take picture liveness
// Future<void> liveNessSuccess() async {
//   try {
//     cameraController.pausePreview();
//     isStreamingImage = false;
//     await finishLiveNess();
//   } catch (e) {
//     await cameraController.resumePreview();
//     Get.back();
//   } finally {
//     hideLoadingOverlay();
//   }
// }
//
// void _mapListApi() {
//   for (int i = 0; i < questionTemp.length; i++) {
//     listOrderSequence
//         .add(LiveNessCollection.listMapOderAction[questionTemp[i]] ?? "");
//     listFaceDirection.add(
//         LiveNessCollection.listMapOderActionSuccess[questionTemp[i]] ?? "");
//   }
// }

// Future<void> finishLiveNess() async {
//   showLoadingOverlay();
//   _mapListApi();
//   if (cameraController.value.isRecordingVideo) {
//     XFile videoFile = await cameraController.stopVideoRecording();
//     urlRecordVideoTemp = videoFile.path;
//   }
//   filesImageLiveNess.fileData.value = imageLiveNess;
//   // updateInformationController.maybeContinue.value = true;
//   LiveNessRequestModel inspectReportModel = LiveNessRequestModel(
//     fileData: urlRecordVideoTemp,
//     sessionId: hiveApp.get(AppKey.sessionId),
//     orderSequence: listOrderSequence.join(","),
//     faceDirection: listFaceDirection.join(","),
//     smileProbability: listSmiling.join(","),
//   );
//   List<FilesImageModel> listFile = [
//     filesImageLiveNess,
//   ];
//   await liveNessRepository.sendFileOCR(listFile: listFile);
//
//   sendLiveNessData(inspectReportModel);
//   // if (Get.isRegistered<NfcInformationUserController>()) {
//   //   NfcInformationUserController controller =
//   //       Get.find<NfcInformationUserController>();
//   //   controller.sendLiveNessData(inspectReportModel);
//   // }
//   await closePros();
//   hideLoadingOverlay();
//   cameraIsInitialize.value = false;
//   Get.offAndToNamed(AppRoutes.routeConfirmInformation);
//   // Get.close(2);
//   // await appController.initCamera();
// }

// void sendLiveNessData(LiveNessRequestModel inspectReportModel) {
//   if (Get.isRegistered<NfcInformationUserController>()) {
//     NfcInformationUserController controller =
//         Get.find<NfcInformationUserController>();
//     // controller.sendLiveNessData(inspectReportModel);
//   }
// }
//

  ///gọi hàm này chụp lại ảnh khi xong bước nhìn thẳng
// Future<void> isolateConvertImg(InputImage image) async {
//   await compute(CameraImageConverter.isolateProcessImage, image)
//       .then((value) async {
//     imageLiveNess = value;
//   });
// }
//
// static Uint8List isolateProcessImage(InputImage item) {
//   img.Image convertedImage = Platform.isAndroid
//       ? CameraImageConverter.decodeYUV420SP(item)
//       : img.Image.fromBytes(
//           width: item.metadata!.size.width.toInt(),
//           height: item.metadata!.size.height.toInt(),
//           bytes: item.bytes!.buffer, // For iOS
//           order: img.ChannelOrder.bgra,
//         );
//
//   // Xử lý hướng xoay ảnh và giảm size
//   if (item.metadata!.size.width.toInt() >
//       item.metadata!.size.height.toInt()) {
//     convertedImage = img.copyRotate(convertedImage, angle: -90);
//     convertedImage = img.copyResize(convertedImage, width: 480, height: 640);
//   }
//
//   //Giảm chất lượng ảnh
//   final compressedBytes = img.encodeJpg(convertedImage, quality: 50);
//
//   return Uint8List.fromList(compressedBytes);
// }
}
