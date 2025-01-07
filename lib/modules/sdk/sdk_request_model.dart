class SdkRequestModel {
  SdkRequestModel({
    this.key = "",
    this.secretKey = "",
  });

  final String key;
  final String secretKey;

  factory SdkRequestModel.fromJson(Map<String, dynamic> json) {
    return SdkRequestModel(
      key: json["key"] ?? "",
      secretKey: json["secretKey"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "key": key,
        "secretKey": secretKey,
      };
}
