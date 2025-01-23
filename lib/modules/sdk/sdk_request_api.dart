class SdkRequestAPI {
  final String apiKey;
  final String transactionId;
  final int timestamp;
  final String hash;

  SdkRequestAPI({
    required this.apiKey,
    required this.transactionId,
    required this.timestamp,
    required this.hash,
  });

  factory SdkRequestAPI.fromJson(Map<String, dynamic> json) {
    return SdkRequestAPI(
      apiKey: json['apiKey'],
      transactionId: json['transactionId'],
      timestamp: json['timestamp'],
      hash: json['hash'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'transactionId': transactionId,
      'timestamp': timestamp,
      'hash': hash,
    };
  }
}