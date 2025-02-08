class SdkRequestModel {
  SdkRequestModel({
    this.merchantKey = "",
    this.secretKey = "",
    this.documentNumber = "",
    this.method = "C06",
    this.isProd = false,
  });

  final String merchantKey;
  final String secretKey;
  final String documentNumber;
  final String method;
  final bool isProd;

  factory SdkRequestModel.fromJson(Map<String, dynamic> json) {
    return SdkRequestModel(
      merchantKey: json["merchantKey"] ?? "",
      secretKey: json["secretKey"] ?? "",
      documentNumber: json["CCCD"] ?? "",
      method: json["method"] ?? "",
      isProd: json["isProd"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "merchantKey": merchantKey,
        "secretKey": secretKey,
        "method": method,
        "CCCD": documentNumber,
        "isProd": isProd,
      };
}
