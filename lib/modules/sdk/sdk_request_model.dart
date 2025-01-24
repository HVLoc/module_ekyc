class SdkRequestModel {
  SdkRequestModel({
    this.key = "",
    this.secretKey = "",
    this.documentNumber = "",
    this.isProd = false,
  });

  final String key;
  final String secretKey;
  final String documentNumber;
  final bool isProd;

  factory SdkRequestModel.fromJson(Map<String, dynamic> json) {
    return SdkRequestModel(
      key: json["key"] ?? "",
      secretKey: json["secretKey"] ?? "",
      documentNumber: json["CCCD"] ?? "",
      isProd: json["isProd"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "key": key,
        "secretKey": secretKey,
        "CCCD": documentNumber,
        "isProd": isProd,
      };
}
