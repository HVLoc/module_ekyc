class SendNfcRequestModel {
  SendNfcRequestModel({
    this.sessionId,
    this.type,
    this.number,
    this.name,
    this.firstName,
    this.lastName,
    this.dob,
    this.sex,
    this.nationality,
    this.doe,
    this.mrz,
    this.file,
    this.aaSignature,
    this.aaPublicKey,
    this.keyAlg,
    this.method = "C06",
  });

  String? sessionId;
  String? type;
  String? number;
  String? name;
  String? firstName;
  String? lastName;
  String? dob;
  String? sex;
  String? nationality;
  String? doe;
  String? mrz;
  String? file;
  String? aaSignature;
  String? aaPublicKey;
  String? keyAlg;
  String? imgLiveNess;
  String? faceMatching;
  bool? isFaceMatching;
  bool verifyDocumentNumber = false;

  ///xác thư c06 chưa

  ///base64
  String? sodData;
  String? dg1DataB64;
  String? dg2DataB64;
  String? dg13DataB64;
  String? dg14DataB64;
  String? fileId;
  String? bodyFileId;

  ///data dg13VNM
  String? numberVMN;
  String? nameVNM;
  String? dobVMN;
  String? sexVMN;
  String? nationalityVMN;
  String? nationVNM;
  String? religionVMN;
  String? homeTownVMN;
  String? residentVMN;
  String? identificationSignsVNM;
  String? registrationDateVMN;
  String? doeVMN;
  String? nameDadVMN;
  String? nameMomVMN;
  String? otherPaper;
  String? nameCouple;
  String? raw;
  String? phone;
  bool isView = false;
  bool statusSuccess = false;
  bool visibleButtonDetail = true;
  String? kind;
  String? method;

  factory SendNfcRequestModel.fromJson(Map<String, dynamic> json) {
    return SendNfcRequestModel(
      sessionId: json["session_id"],
      type: json["type"],
      number: json["number"],
      name: json["name"],
      dob: json["dob"],
      sex: json["sex"],
      nationality: json["nationality"],
      doe: json["doe"],
      mrz: json["MRZ"],
      file: json["file"],
      aaSignature: json["aaSignature"],
      aaPublicKey: json["aaPublicKey"],
      keyAlg: json["keyAlg"],
    );
  }

  Map<String, dynamic> toJsonBase64() => {
        "sodData": sodData,
        "dg1DataB64": dg1DataB64,
        "dg2DataB64": dg2DataB64,
        "dg13DataB64": dg13DataB64,
        "dg14DataB64": dg14DataB64,
        "fileId": fileId,
        "bodyFileId": bodyFileId,
        "phone": phone,
      };

  Map<String, dynamic> toJsonVerify() => {
        "sodData": sodData,
        "dg1DataB64": dg1DataB64,
        "dg2DataB64": dg2DataB64,
        "dg13DataB64": dg13DataB64,
        "dg14DataB64": dg14DataB64,
        "fileId": fileId,
        "bodyFileId": bodyFileId,
        "phone": phone,
        "method": method,
      };

  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "type": type,
        "number": number,
        "name": nameVNM,
        "dob": dobVMN,
        "sex": sex,
        "nationality": nationality,
        "doe": doeVMN,
        "MRZ": mrz,
        "poo": homeTownVMN,
        "por": residentVMN,
        "religion": religionVMN,
        "nation": nationVNM,
        "registerDate": registrationDateVMN,
        "symbol": identificationSignsVNM,
        "father": nameDadVMN,
        "mother": nameMomVMN,
        "aaSignature": aaSignature,
        "aaPublicKey": aaPublicKey,
        "keyAlg": keyAlg?.split('.').last,
        "file": file,
        "identity": otherPaper,
        "raw": raw,
        "couple": nameCouple,
      };

  Map<String, dynamic> toJsonFull() => {
        "sessionId": sessionId,
        "type": type,
        "number": number,
        "name": name,
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob,
        "sex": sex,
        "nationality": nationality,
        "doe": doe,
        "MRZ": mrz,
        "file": file,
        "aaSignature": aaSignature,
        "aaPublicKey": aaPublicKey,
        "keyAlg": keyAlg?.split('.').last,
        "imgLiveNess": imgLiveNess,
        "faceMatching": faceMatching,
        "isFaceMatching": isFaceMatching,
        "verifyDocumentNumber": verifyDocumentNumber,
        "sodData": sodData,
        "dg1DataB64": dg1DataB64,
        "dg2DataB64": dg2DataB64,
        "dg13DataB64": dg13DataB64,
        "dg14DataB64": dg14DataB64,
        "fileId": fileId,
        "bodyFileId": bodyFileId,
        "numberVMN": numberVMN,
        "nameVNM": nameVNM,
        "dobVMN": dobVMN,
        "sexVMN": sexVMN,
        "nationalityVMN": nationalityVMN,
        "nationVNM": nationVNM,
        "religionVMN": religionVMN,
        "homeTownVMN": homeTownVMN,
        "residentVMN": residentVMN,
        "identificationSignsVNM": identificationSignsVNM,
        "registrationDateVMN": registrationDateVMN,
        "doeVMN": doeVMN,
        "nameDadVMN": nameDadVMN,
        "nameMomVMN": nameMomVMN,
        "otherPaper": otherPaper,
        "nameCouple": nameCouple,
        "raw": raw,
        "phone": phone,
        "isView": isView,
        "statusSuccess": statusSuccess,
        "visibleButtonDetail": visibleButtonDetail,
        "kind": kind,
        "method": method,
      };
}
