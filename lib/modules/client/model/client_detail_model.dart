class ClientDetailModel {
  ClientDetailModel({
    required this.id,
    required this.createdAt,
    required this.phone,
    required this.fullName,
    required this.citizenNumber,
    required this.oldCitizenNumber,
    required this.dateOfBirth,
    required this.dateProvide,
    required this.sex,
    required this.nationality,
    required this.ethnic,
    required this.religion,
    required this.placeOfOrigin,
    required this.personalIdentification,
    required this.fatherName,
    required this.motherName,
    required this.coupleName,
    required this.status,
    required this.dateOfExpired,
    required this.placeOfResidence,
    required this.kind,
  });

  final String? id;
  final DateTime? createdAt;
  final String? fullName;
  final String? phone;
  final String? citizenNumber;
  final String? oldCitizenNumber;
  final String? dateOfBirth;
  final String? dateProvide;
  final String? dateOfExpired;
  final String? sex;
  final String? nationality;
  final String? ethnic;
  final String? religion;
  final String? placeOfOrigin;
  final String? personalIdentification;
  final String? fatherName;
  final String? motherName;
  final String? coupleName;
  final String? status;
  final String? placeOfResidence;
  final String? kind;

  factory ClientDetailModel.fromJson(Map<String, dynamic> json) {
    return ClientDetailModel(
      id: json["id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      fullName: json["fullName"],
      phone: json["phone"],
      citizenNumber: json["citizenNumber"],
      oldCitizenNumber: json["oldCitizenNumber"],
      dateOfBirth: json["dateOfBirth"],
      dateProvide: json["dateProvide"],
      sex: json["sex"],
      nationality: json["nationality"],
      ethnic: json["ethnic"],
      religion: json["religion"],
      placeOfOrigin: json["placeOfOrigin"],
      personalIdentification: json["personalIdentification"],
      fatherName: json["fatherName"],
      motherName: json["motherName"],
      coupleName: json["coupleName"],
      status: json["status"],
      dateOfExpired: json["dateOfExpired"],
      placeOfResidence: json["placeOfResidence"],
      kind: json["kind"],
    );
  }
}
