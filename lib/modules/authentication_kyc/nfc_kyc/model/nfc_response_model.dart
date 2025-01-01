class NfcResponseModel {
  NfcResponseModel({
    required this.result,
    required this.timestamp,
    required this.signature,
    required this.packageKind,
  });

  final bool? result;
  final int? timestamp;
  final String? signature;
  final String? packageKind;

  factory NfcResponseModel.fromJson(Map<String, dynamic> json){
    return NfcResponseModel(
      result: json["result"],
      timestamp: json["timestamp"],
      signature: json["signature"],
      packageKind: json["packageKind"],

    );
  }

  Map<String, dynamic> toJson() => {
    "result": result,
    "timestamp": timestamp,
    "signature": signature,
  };

}
