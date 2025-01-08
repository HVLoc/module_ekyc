class FaceMatchingResponse {
  FaceMatchingResponse({
    required this.data,
    required this.errorCode,
    required this.errorMessage,
  });

  final Data? data;
  final String? errorCode;
  final String? errorMessage;

  factory FaceMatchingResponse.fromJson(Map<String, dynamic> json){
    return FaceMatchingResponse(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      errorCode: json["errorCode"],
      errorMessage: json["errorMessage"],
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "errorCode": errorCode,
    "errorMessage": errorMessage,
  };

}

class Data {
  Data({
    required this.face1,
    required this.face1Score,
    required this.face2,
    required this.face2Score,
    required this.invalidCode,
    required this.invalidMessage,
    required this.match,
    required this.matching,
  });

  final String? face1;
  final String? face1Score;
  final String? face2;
  final String? face2Score;
  final int? invalidCode;
  final String? invalidMessage;
  final String? match;
  final String? matching;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      face1: json["face1"],
      face1Score: json["face1_score"],
      face2: json["face2"],
      face2Score: json["face2_score"],
      invalidCode: json["invalidCode"],
      invalidMessage: json["invalidMessage"],
      match: json["match"],
      matching: json["matching"],
    );
  }

  Map<String, dynamic> toJson() => {
    "face1": face1,
    "face1_score": face1Score,
    "face2": face2,
    "face2_score": face2Score,
    "invalidCode": invalidCode,
    "invalidMessage": invalidMessage,
    "match": match,
    "matching": matching,
  };

}
