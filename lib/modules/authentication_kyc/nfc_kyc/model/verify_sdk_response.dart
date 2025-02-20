import '../../../../base_app/model/model.src.dart';

class VerifyResponse {
  final bool status;
  final String timestamp;
  final String transId;
  final Data? data;
  final List<ErrorModelResponse>? errors;

  VerifyResponse({
    required this.status,
    required this.timestamp,
    required this.transId,
    required this.data,
    this.errors,
  });

  factory VerifyResponse.fromJson(Map<String, dynamic> json) {
    return VerifyResponse(
      status: json['status'],
      timestamp: json['timestamp'],
      transId: json['transId'],
      data: json["data"] != null ? Data.fromJson(json['data']) : null,
      errors: json["errors"] == null
          ? []
          : List<ErrorModelResponse>.from(
              json["errors"]!.map((x) => ErrorModelResponse.fromJson(x))),
    );
  }
}

class Data {
  final String signature;
  final String responseId;
  final int exitcode;
  final bool result;
  final String message;
  final int time;

  Data({
    required this.signature,
    required this.responseId,
    required this.exitcode,
    required this.result,
    required this.message,
    required this.time,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      signature: json['signature'],
      responseId: json['responseId'],
      exitcode: json['exitcode'],
      result: json['result'],
      message: json['message'],
      time: json['time'],
    );
  }
}
