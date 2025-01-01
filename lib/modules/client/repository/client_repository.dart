import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/modules/client/client.src.dart';

class ClientRepository extends BaseRepository {
  ClientRepository(super.controller);

  Future<BaseResponseListBE<ClientListModel>> getListClient({
    required int page,
    required int pageSize,
    required String from,
    required String to,
    required String keyword,
  }) async {
    var response = await baseCallApi(
      AppApi.getListClient(page, pageSize, from, to, keyword),
      EnumRequestMethod.get,
      isHaveVersion: false,
      // jsonMap: registerRequestModel.toJson(),
    );
    return BaseResponseListBE<ClientListModel>.fromJson(
      response,
      (x) => ClientListModel.fromJson(x),
    );
  }

  Future<BaseResponseBE<ClientDetailModel>> getDetailClient({
    required String id,
  }) async {
    var response = await baseCallApi(
      AppApi.getDetailClient(id),
      EnumRequestMethod.get,
      isHaveVersion: false,
      // jsonMap: registerRequestModel.toJson(),
    );
    return BaseResponseBE.fromJson(
      response,
      func: (x) => ClientDetailModel.fromJson(x),
    );
  }

  Future<BaseResponseBE<String>> getFile({
    required String id,
    String type = "base64",
  }) async {
    var response = await baseCallApi(
      AppApi.getFile,
      EnumRequestMethod.get,
      isHaveVersion: false,
      jsonMap: {
        "fileName": id,
        "type": type,
      },
      isQueryParametersPost: true,
    );
    return BaseResponseBE.fromJson(
      response,
    );
  }
//
// Future<BaseResponseBE/*<PackageListModel>*/ > registerPackage({
//   required String packageId,
// }) async {
//   var data = {
//     "packageId": packageId,
//   };
//   var encodedData = data.entries.map((entry) {
//     return '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}';
//   }).join('&');
//   var response = await baseCallApi(
//     AppApi.registerPackage,
//     EnumRequestMethod.post,
//     isHaveVersion: false,
//     jsonMap: encodedData,
//     contentType: Headers.formUrlEncodedContentType,
//     // dioOptions: BaseOptions()
//     //   ..connectTimeout =
//     //       const Duration(milliseconds: AppConst.requestTimeOut)
//     //   ..contentType = Headers.formUrlEncodedContentType,
//   );
//   return BaseResponseBE.fromJson(
//     response,
//     // func: (x) => PackageListModel.fromJson(x),
//   );
// }
}
