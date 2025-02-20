import 'model.src.dart';

class BaseResponseBESDK<T> {
  BaseResponseBESDK({
    required this.errorCode,
    required this.errorMessage,
    this.data,
    required this.status,
    this.errors,
  });

  final String errorCode;
  final String errorMessage;
  final T? data;
  final List<ErrorModelResponse>? errors;
  final bool? status;

  factory BaseResponseBESDK.fromJson(
    Map<String, dynamic> json, {
    Function(Map<String, dynamic> x)? func,
  }) {
    T? convertObject() => func != null ? func(json["data"]) : json["data"];
    return BaseResponseBESDK<T>(
      status: json["status"],
      errorCode: json["errorCode"] ?? "",
      errorMessage: json["errorMessage"] ?? "",
      data: json["data"] != null ? convertObject() : null,
      errors: json["errors"] == null
          ? []
          : List<ErrorModelResponse>.from(
              json["errors"]!.map((x) => ErrorModelResponse.fromJson(x))),
    );
  }
}
