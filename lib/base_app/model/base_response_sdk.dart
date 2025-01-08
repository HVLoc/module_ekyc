

class BaseResponseBESDK<T> {
  BaseResponseBESDK({
    required this.errorCode,
    required this.errorMessage,
    this.data,
  });

  final String errorCode;
  final String errorMessage;
  final T? data;

  factory BaseResponseBESDK.fromJson(
    Map<String, dynamic> json, {
    Function(Map<String, dynamic> x)? func,
  }) {
    T? convertObject() => func != null ? func(json["data"]) : json["data"];
    return BaseResponseBESDK<T>(
      errorCode: json["errorCode"] ?? "",
      errorMessage: json["errorMessage"] ?? "",
      data: json["data"] != null ? convertObject() : null,
    );
  }
}
