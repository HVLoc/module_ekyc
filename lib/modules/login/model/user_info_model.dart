class UserInfoModel {
  UserInfoModel({
    this.subscribeInfo,
    this.customerInfo,
  });

  final SubscribeInfo? subscribeInfo;
  final CustomerInfo? customerInfo;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      subscribeInfo: json["subscribeInfo"] == null
          ? null
          : SubscribeInfo.fromJson(json["subscribeInfo"]),
      customerInfo: json["customerInfo"] == null
          ? null
          : CustomerInfo.fromJson(json["customerInfo"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "subscribeInfo": subscribeInfo?.toJson(),
        "customerInfo": customerInfo?.toJson(),
      };
}

class CustomerInfo {
  CustomerInfo({
    this.id,
    this.username,
    this.email,
    this.fullName,
    this.citizenNumber,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.ethnic,
    this.religion,
    this.phone,
    this.userType,
    this.status,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.isAgree,
    this.isVerified,
    this.isChangePass,
  });

  final String? id;
  final String? username;
  final String? email;
  final String? fullName;
  final String? citizenNumber;
  final String? dateOfBirth;
  final String? gender;
  final String? nationality;
  final String? ethnic;
  final String? religion;
  final String? phone;
  final String? userType;
  final String? status;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final bool? isAgree;
  final bool? isVerified;
  final bool? isChangePass;

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      fullName: json["fullName"],
      citizenNumber: json["citizenNumber"],
      dateOfBirth: json["dateOfBirth"] ?? "",
      gender: json["gender"],
      nationality: json["nationality"],
      ethnic: json["ethnic"],
      religion: json["religion"],
      phone: json["phone"],
      userType: json["userType"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      createdBy: json["createdBy"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      updatedBy: json["updatedBy"],
      isAgree: json["isAgree"],
      isVerified: json["isVerified"],
      isChangePass: json["isChangePass"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "fullName": fullName,
        "citizenNumber": citizenNumber,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "nationality": nationality,
        "ethnic": ethnic,
        "religion": religion,
        "phone": phone,
        "userType": userType,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt?.toIso8601String(),
        "updatedBy": updatedBy,
        "isAgree": isAgree,
        "isVerified": isVerified,
      };
}

class SubscribeInfo {
  SubscribeInfo({
    this.id,
    this.packageId,
    this.packageName,
    this.type,
    this.paymentMethod,
    this.costTotal,
    this.tax,
    this.status,
    this.times,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.fullName,
    this.phone,
    this.email,
    this.userType,
    this.totalUsed,
  });

  final String? id;
  final String? packageId;
  final String? packageName;
  final String? type;
  final String? paymentMethod;
  final num? costTotal;
  final num? tax;
  final String? status;
  final num? times;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? fullName;
  final String? phone;
  final String? email;
  final String? userType;
  final num? totalUsed;

  factory SubscribeInfo.fromJson(Map<String, dynamic> json) {
    return SubscribeInfo(
      id: json["id"],
      packageId: json["packageId"],
      packageName: json["packageName"],
      type: json["type"],
      paymentMethod: json["paymentMethod"],
      costTotal: json["costTotal"],
      tax: json["tax"],
      status: json["status"],
      times: json["times"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      createdBy: json["createdBy"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      updatedBy: json["updatedBy"],
      fullName: json["fullName"],
      phone: json["phone"],
      email: json["email"],
      userType: json["userType"],
      totalUsed: json["totalUsed"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "packageId": packageId,
        "packageName": packageName,
        "type": type,
        "paymentMethod": paymentMethod,
        "costTotal": costTotal,
        "tax": tax,
        "status": status,
        "times": times,
        "createdAt": createdAt?.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt?.toIso8601String(),
        "updatedBy": updatedBy,
        "fullName": fullName,
        "phone": phone,
        "email": email,
        "userType": userType,
        "totalUsed": totalUsed,
      };
}
