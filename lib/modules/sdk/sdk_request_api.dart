class SdkRequestAPI {
  final String merchantKey;
  final String transactionId;
  final int timestamp;
  final String hash;

  SdkRequestAPI({
    required this.merchantKey,
    required this.transactionId,
    required this.timestamp,
    required this.hash,
  });

  factory SdkRequestAPI.fromJson(Map<String, dynamic> json) {
    return SdkRequestAPI(
      merchantKey: json['merchantKey'],
      transactionId: json['transactionId'],
      timestamp: json['timestamp'],
      hash: json['hash'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'merchantKey': merchantKey,
      'transactionId': transactionId,
      'timestamp': timestamp,
      'hash': hash,
    };
  }
}
