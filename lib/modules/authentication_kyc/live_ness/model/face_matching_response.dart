class FaceMatchingModel {
  FaceMatchingModel({
    required this.matching,
    required this.face1,
    required this.face2,
    required this.face1Score,
    required this.face2Score,
    required this.invalidCode,
    required this.invalidMessage,
    required this.match,
  });

  final String matching; // Phần trăm giống nhau giữa hai ảnh đầu vào
  final String face1; // Ảnh khuôn mặt chứng minh thư
  final String face2; // Ảnh khuôn mặt chân dung
  final String face1Score; // Độ tin cậy ảnh khuôn mặt chứng minh thư
  final String face2Score; // Độ tin cậy ảnh khuôn mặt chân dung
  final String invalidCode; // Mã cảnh báo
  final String invalidMessage; // Cảnh báo nếu ảnh có vấn đề
  final String match; // Kết quả đối chiếu

  factory FaceMatchingModel.fromJson(Map<String, dynamic> json) {
    return FaceMatchingModel(
      matching: json['matching'] ?? '',
      face1: json['face1'] ?? '',
      face2: json['face2'] ?? '',
      face1Score: json['face1_score'] ?? '',
      face2Score: json['face2_score'] ?? '',
      invalidCode: json['invalidCode'] ?? '',
      invalidMessage: json['invalidMessage'] ?? '',
      match: json['match'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matching': matching,
      'face1': face1,
      'face2': face2,
      'face1_score': face1Score,
      'face2_score': face2Score,
      'invalidCode': invalidCode,
      'invalidMessage': invalidMessage,
      'match': match,
    };
  }
}
