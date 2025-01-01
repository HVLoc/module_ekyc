import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/live_ness/live_ness_kyc.src.dart';

class LiveNessRepository extends BaseRepository {
  LiveNessRepository(super.controller);

  // Future<BaseResponseBE> sendLiveNessRepository(
  //     LiveNessRequestModel liveNessRequestModel) async {
  //   FormData formData = FormData.fromMap(await liveNessRequestModel.toJson());
  //   var response = await baseCallApi(
  //     AppApi.sendLiveNessData,
  //     EnumRequestMethod.post,
  //     jsonMap: formData,
  //     isHaveVersion: false,
  //   );
  //   return BaseResponseBE.fromJson(response);
  // }
  //
  // Future<BaseResponseBE> sendFileOCR({
  //   required List<FilesImageModel> listFile,
  // }) async {
  //   Map<String, dynamic> jsonMap = {
  //     "session_id": hiveApp.get(AppKey.sessionId),
  //     "files": _getListFile(listFile),
  //   };
  //   var response = await baseCallApi(
  //     AppApi.sendFileOCR,
  //     EnumRequestMethod.post,
  //     jsonMap: jsonMap,
  //     isHaveVersion: false,
  //   );
  //   return BaseResponseBE.fromJson(
  //     response,
  //   );
  // }
  // List<Map<String, String>> _getListFile(List<FilesImageModel> listFile) {
  //   return listFile.map((obj) => obj.toJson()).toList();
  // }

  Future<BaseResponseBE<FileModel>> sendFileRepository(Uint8List image) async {
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        image,
        filename: "Image.jpg",
        contentType: MediaType(
          'image',
          'jpg',
        ),
      ),
    });
    var response = await baseCallApi(
      AppApi.sendFileData,
      EnumRequestMethod.post,
      jsonMap: formData,
      isHaveVersion: false,
    );
    return BaseResponseBE.fromJson(
      response,
      func: (x) => FileModel.fromJson(x),
    );
  }
}
