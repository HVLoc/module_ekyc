// import 'package:dio/dio.dart';
//
// class LiveNessRequestModel {
//   LiveNessRequestModel({
//     this.fileData,
//     this.sessionId,
//     this.orderSequence,
//     this.faceDirection,
//     this.smileProbability,
//     this.rateFaceMatching,
//     this.isUpdateLiveNess,
//   });
//
//   final String? fileData;
//   final String? sessionId;
//   final String? orderSequence;
//   final String? faceDirection;
//   final String? smileProbability;
//   final double? rateFaceMatching;
//   final bool? isUpdateLiveNess;
//
//   factory LiveNessRequestModel.fromJson(Map<String, dynamic> json) {
//     return LiveNessRequestModel(
//       fileData: json["fileData"],
//       sessionId: json["sessionId"],
//       orderSequence: json["orderSequence"],
//       faceDirection: json["faceDirection"],
//       smileProbability: json["smileProbability"],
//     );
//   }
//
//   Future<Map<String, dynamic>> toJson() async => {
//         "fileData": fileData != null
//             ? await MultipartFile.fromFile(
//                 fileData!,
//               )
//             : null,
//         "sessionId": sessionId,
//         "orderSequence": orderSequence,
//         "faceDirection": faceDirection,
//         "smileProbability": smileProbability,
//       };
// }
