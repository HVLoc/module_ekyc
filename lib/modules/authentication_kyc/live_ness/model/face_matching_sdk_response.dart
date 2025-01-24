class FaceMatchSDKResponse {
  final String face1;
  final String face1Score;
  final String face2;
  final String face2Score;
  final int invalidCode;
  final String invalidMessage;
  final String match;
  final String matching;

  FaceMatchSDKResponse({
    required this.face1,
    required this.face1Score,
    required this.face2,
    required this.face2Score,
    required this.invalidCode,
    required this.invalidMessage,
    required this.match,
    required this.matching,
  });

  factory FaceMatchSDKResponse.fromJson(Map<String, dynamic> json) {
    return FaceMatchSDKResponse(
      face1: json['face1'],
      face1Score: json['face1_score'],
      face2: json['face2'],
      face2Score: json['face2_score'],
      invalidCode: json['invalidCode'],
      invalidMessage: json['invalidMessage'],
      match: json['match'],
      matching: json['matching'],
    );
  }
}
