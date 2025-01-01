class ClientListModel {
  ClientListModel({
    required this.id,
    required this.fullName,
    required this.citizenNumber,
    required this.fileId,
    required this.bodyFileId,
    required this.createdAt,
    required this.status,
    required this.phone,
  });

  final String? id;
  final String? fullName;
  final String? citizenNumber;
  final String? fileId;
  final String? bodyFileId;
  final DateTime? createdAt;
  final String? status;
  final String? phone;

  factory ClientListModel.fromJson(Map<String, dynamic> json){
    return ClientListModel(
      id: json["id"],
      fullName: json["fullName"],
      citizenNumber: json["citizenNumber"],
      fileId: json["fileId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      status: json["status"],
      bodyFileId: json["bodyFileId"],
      phone: json["phone"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "citizenNumber": citizenNumber,
    "fileId": fileId,
    "createdAt": createdAt?.toIso8601String(),
    "status": status,
  };

}
