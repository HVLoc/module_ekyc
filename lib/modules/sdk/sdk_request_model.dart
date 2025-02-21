class SdkRequestModel {
  SdkRequestModel({
    this.merchantKey = "",
    this.secretKey = "",
    this.documentNumber = "",
    this.apiKey = "",
    this.method = "C06",
    this.isProd = false,
  });

  final String merchantKey;
  final String secretKey;
  final String documentNumber;
  final String apiKey;
  final String method;
  final bool isProd;

  factory SdkRequestModel.fromJson(Map<String, dynamic> json) {
    return SdkRequestModel(
      merchantKey: json["merchantKey"] ?? "",
      secretKey: json["secretKey"] ?? "",
      documentNumber: json["CCCD"] ?? "",
      apiKey: json["apiKey"] ?? "",
      method: json["method"] ?? "",
      isProd: json["isProd"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "merchantKey": merchantKey,
        "secretKey": secretKey,
        "apiKey": apiKey,
        "method": method,
        "CCCD": documentNumber,
        "isProd": isProd,
      };
}
