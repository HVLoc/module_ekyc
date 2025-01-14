import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/live_ness/live_ness_kyc.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';

import '../../../../core/core.src.dart';

class LiveNessKycController extends BaseGetxController {
  late CameraController cameraController;
  late LiveNessRepository liveNessRepository;
  AppController appController = Get.find<AppController>();

  Rx<Uint8List?> imageTemp = Rx<Uint8List?>(null);
  String urlRecordVideoTemp = "";
  late List<CameraDescription> cameras;
  RxBool cameraIsInitialize = false.obs;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      enableClassification: true,
    ),
  );

  List<String> typesTemp = [];

  // RxList<String> listFaceDetectionTemp = <String>[].obs;
  List<String> questionTemp = [];
  int lastQuestion = -1;
  int randomIndex = 10;
  List<int> numbers = [0, 1, 2, 3, 4, 5];

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
  List<String> listSequence = [];
  List<int> listRadonNumber = [];
  double rateFaceMatching = 0.0;
  bool isUpdateLiveNess = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments is bool) {
        isUpdateLiveNess = Get.arguments;
      }
    }

    try {
      showLoadingOverlay();
      liveNessRepository = LiveNessRepository(this);
      await initCamera();
      await _getListSequence();
      randomListQuestion();
    } finally {
      hideLoadingOverlay();
    }
  }

  @override
  Future<void> onClose() async {
    await closePros();
    super.onClose();
  }

  Future<void> _getListSequence() async {
    // await liveNessRepository.getInfoLiveNess().then((value) {
    //   List<LiveNessConfigInfo> listActionAPi =
    //       value.data?.livenessConfigInfo ?? [];
    //   listSequence = listActionAPi.map((item) => item.name ?? "").toList();
    //   // listSequence = value.data?.livenessConfigInfo ?? [];
    //   rateFaceMatching = value.data?.rate ?? 0.0;
    // });
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[1],
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    await cameraController.initialize();
    cameraIsInitialize.value = cameraController.value.isInitialized;
  }

  Future<void> startStreamPicture() async {
    if (!isStreamingImage) {
      isStreamingImage = true;
      if (!cameraController.value.isStreamingImages) {
        cameraController.startImageStream((image) async {
          if (!detecting) {
            await _processImage(image);
          }
        });
      }
    }
  }

  Future<void> closePros() async {
    isStreamingImage = false;
    if (cameraController.value.isStreamingImages) {
      await cameraController.stopImageStream();
    }
    await _faceDetector.close();
    await cameraController.dispose();
    // }
  }

  /// Xử lý khung hình và trả về kết quả hành động vào action
  Future<void> _processImage(CameraImage image) async {
    detecting = true;
    InputImage? inputImage = CameraImageConverter.inputImageFromCameraImage(
      image,
      cameras[1],
      cameraController,
    );
    if (inputImage != null) {
      final faces = await _faceDetector.processImage(inputImage);
      if (faces.isNotEmpty) {
        isManyFace.value = faces.length > 1;

        isFaceEmpty.value = false;
        if (currentStep.value == 0) {
          // randomQuestion();
          currentStep.value++;
          type = typesTemp[currentStep.value - 1];
        }
        LiveNessDetectionData liveNessData = LiveNessDetector(
          faces,
          eyeOpenRightOld,
          eyeOpenLeftOld,
        ).liveNess(type);
        eyeOpenRightOld = faces[0].rightEyeOpenProbability ?? 0.0;
        eyeOpenLeftOld = faces[0].leftEyeOpenProbability ?? 0.0;
        question = liveNessData.question;
        if (isSuccessLiveNess.value) {
          await liveNessSuccess();
        } else {
          if (currentStep.value <= AppConst.currentStepMax) {
            if (question.compareTo(questionTemp[currentStep.value - 1]) == 0) {
              if (question
                      .compareTo(LocaleKeys.live_ness_actionFaceBetween.tr) ==
                  0) {
                await Future.delayed(const Duration(milliseconds: 500));
                await waitAtLeast(
                    isolateConvertImg(inputImage), const Duration(seconds: 2));
                // await isolateConvertImg(inputImage);
              }
              currentStep.value++;
              if (listSmiling.length < AppConst.currentStepMax) {
                listSmiling.add(liveNessData.percentSmile);
              }
              if (currentStep.value <= AppConst.currentStepMax) {
                type = typesTemp[currentStep.value - 1];
              }
            }
          } else {
            isSuccessLiveNess.value = true;

            ///TODO: dialog thành công
            // ShowDialog.successDialog(LocaleKeys.live_ness_liveNessSuccess.tr);
            // await Future.delayed(const Duration(milliseconds: 1000), () {
            //   Get.back();
            // });
          }
        }
      } else {
        isManyFace.value = false;
        isFaceEmpty.value = true;
      }
    }
    detecting = false;
  }

  void randomListQuestion() {
    // for (int j = 0; j < listSequence.length; j++) {
    //   listRadonNumber
    //       .add(LiveNessCollection.listMapOderAction[listSequence[j]] ?? 0);
    // }
    // if (listRadonNumber.isNotEmpty) {
    //   for (int i = 0; i < listRadonNumber.length; i++) {
    //     randomIndex = listRadonNumber[i];
    //     _addListQuestion(randomIndex);
    //     // listRadonNumber.removeAt(i);
    //   }
    // } else {
    for (int i = 0; i < AppConst.currentStepMax; i++) {
      var rng = Random();
      randomIndex = rng.nextInt(numbers.length);
      lastQuestion = numbers[randomIndex];
      if (numbers[randomIndex] == 4 || numbers[randomIndex] == 5) {
        for (int i = 0; i < typesTemp.length; i++) {
          if (typesTemp[i] == LocaleKeys.live_ness_faceSmile.tr ||
              typesTemp[i] == LocaleKeys.live_ness_faceOpen.tr) {
            numbers.removeAt(randomIndex);
            randomIndex = rng.nextInt(numbers.length);
          }
        }
      }
      _addListQuestion(numbers[randomIndex]);
      numbers.removeAt(randomIndex);
    }
    // }
  }

  void _addListQuestion(int index) {
    // listFaceDetectionTemp.add(LiveNessCollection.listFaceDetach[index]);
    typesTemp.add(LiveNessCollection.types[index]);
    questionTemp.add(LiveNessCollection.questions[index]);
  }

  Future<T> waitAtLeast<T>(Future<T> future, Duration minDuration) async {
    final results = await Future.wait([future, Future.delayed(minDuration)]);
    return results[0] as T;
  }

  ///take picture liveness
  Future<void> liveNessSuccess() async {
    try {
      cameraController.pausePreview();
      isStreamingImage = false;
      if (cameraIsInitialize.value) {
        await finishLiveNess();
      }
    } catch (e) {
      await cameraController.resumePreview();
      // Get.back();
    } finally {
      hideLoadingOverlay();
    }
  }

  // void _mapListApi() {
  //   for (int i = 0; i < questionTemp.length; i++) {
  //     listOrderSequence
  //         .add(LiveNessCollection.listMapOderActionApi[questionTemp[i]] ?? "");
  //     listFaceDirection.add(
  //         LiveNessCollection.listMapOderActionSuccess[questionTemp[i]] ?? "");
  //   }
  // }

  Future<void> finishLiveNess() async {
    ///fake dữ liệu
    appController.sendNfcRequestGlobalModel.isFaceMatching = true;
    appController.sendNfcRequestGlobalModel.faceMatching = "90%";
    appController.sendNfcRequestGlobalModel.imgLiveNess =
        base64Encode(imageLiveNess ?? []);
    Get.offNamed(AppRoutes.routeFaceMatchingResult);

    // showLoadingOverlay();
    // await updatePhotoInformationRepository
    //     .checkFaceMatching(
    //   taskId: appController.deepLinkModel.taskId,
    //   idCardFront: appController.deepLinkModel.imgFaceFront,
    //   faceFront: base64Encode(imageLiveNess ?? []),
    // )
    //     .then((value) async {
    //   if ((value.data?.data?.match ?? "0.0") == AppConst.matchSuccess) {
    //     appController.deepLinkModel.imgFace = base64Encode(imageLiveNess ?? []);
    //     // if(appController.deepLinkModel.typeSignPdf == AppConst.signeKycNfc){}
    //     if (appController.deepLinkModel.typeSignPdf == AppConst.signeKycNfc) {
    //       Get.toNamed(
    //         AppRoutes.routeInformationNfc,
    //         arguments: appController.sendNfcRequestModel,
    //       );
    //     } else {
    //       Get.offNamed(AppRoutes.routeFaceMatchingResult);
    //     }
    //   } else {
    //     await closePros();
    //     cameraIsInitialize.value = false;
    //     Get.until((route) =>
    //         Get.routing.current == AppRoutes.routeUpdatePhoToInformationKyc);
    //     showFlushNoti(
    //       LocaleKeys.live_ness_matchingFailTitle.tr,
    //       content: LocaleKeys.live_ness_matchingFailContent.tr,
    //     );
    //   }
    // });
    // Get.back();
    // _mapListApi();
    // if (cameraController.value.isRecordingVideo) {
    //   XFile videoFile = await cameraController.stopVideoRecording();
    //   urlRecordVideoTemp = videoFile.path;
    // }
    // filesImageLiveNess.fileData.value = imageLiveNess;
    // // updateInformationController.maybeContinue.value = true;
    // LiveNessRequestModel inspectReportModel = LiveNessRequestModel(
    //   fileData: urlRecordVideoTemp,
    //   sessionId: hiveApp.get(AppKey.sessionId),
    //   orderSequence: listOrderSequence.join(","),
    //   faceDirection: listFaceDirection.join(","),
    //   smileProbability: listSmiling.join(","),
    //   rateFaceMatching: rateFaceMatching,
    //   isUpdateLiveNess: isUpdateLiveNess,
    // );
    // List<FilesImageModel> listFile = [
    //   filesImageLiveNess,
    // ];
    // await liveNessRepository.sendFileOCR(listFile: listFile);

    // sendLiveNessData(inspectReportModel);
    // if (Get.isRegistered<NfcInformationUserController>()) {
    //   NfcInformationUserController controller =
    //       Get.find<NfcInformationUserController>();
    //   controller.sendLiveNessData(inspectReportModel);
    // }

    // await closePros();
    // hideLoadingOverlay();
    // Get.offAndToNamed(AppRoutes.routeAwaitFaceMatching,
    //     arguments: inspectReportModel);
    // cameraIsInitialize.value = false;

    // Get.offAndToNamed(AppRoutes.routeConfirmInformation);
    // Get.close(2);
    // await appController.initCamera();
  }

  // void sendLiveNessData(LiveNessRequestModel inspectReportModel) {
  //   if (Get.isRegistered<HomeController>()) {
  //     HomeController controller = Get.find<HomeController>();
  //     controller.sendLiveNessData(inspectReportModel);
  //   }
  // }

  ///gọi hàm này chụp lại ảnh khi xong bước nhìn thẳng
  Future<void> isolateConvertImg(InputImage image) async {
    await compute(CameraImageConverter.isolateProcessImage, image)
        .then((value) async {
      imageLiveNess = value;
    });
  }

  static Uint8List isolateProcessImage(InputImage item) {
    img.Image convertedImage = Platform.isAndroid
        ? CameraImageConverter.decodeYUV420SP(item)
        : img.Image.fromBytes(
            width: item.metadata!.size.width.toInt(),
            height: item.metadata!.size.height.toInt(),
            bytes: item.bytes!.buffer, // For iOS
            order: img.ChannelOrder.bgra,
          );

    // Xử lý hướng xoay ảnh và giảm size
    if (item.metadata!.size.width.toInt() >
        item.metadata!.size.height.toInt()) {
      convertedImage = img.copyRotate(convertedImage, angle: -90);
      convertedImage = img.copyResize(convertedImage, width: 480, height: 640);
    }

    //Giảm chất lượng ảnh
    final compressedBytes = img.encodeJpg(convertedImage, quality: 50);

    return Uint8List.fromList(compressedBytes);
  }
}
