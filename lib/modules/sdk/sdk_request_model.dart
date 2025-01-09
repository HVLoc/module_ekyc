class SdkRequestModel {
  SdkRequestModel({
    this.key = "",
    this.secretKey = "",
    this.isProd = false,
  });

  final String key;
  final String secretKey;
  final bool isProd;

  factory SdkRequestModel.fromJson(Map<String, dynamic> json) {
    return SdkRequestModel(
      key: json["key"] ?? "",
      secretKey: json["secretKey"] ?? "",
      isProd: json["isProd"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "key": key,
        "secretKey": secretKey,
        "isProd": isProd,
      };
}
