import '../base_app.src.dart';

class BaseResponseListBE<T> {
  BaseResponseListBE({
    required this.status,
    required this.timestamp,
    required this.transId,
    required this.data,
    required this.totalItem,
    this.errors,
  });

  final bool status;
  final String timestamp;
  final String transId;
  final int totalItem;
  final List<ErrorModelResponse>? errors;
  final List<T> data;

  factory BaseResponseListBE.fromJson(
    Map<String, dynamic> json,
    Function(dynamic x) func,
  ) {
    return BaseResponseListBE<T>(
      status: json["status"] ?? false,
      timestamp: json["timestamp"] ?? "",
      transId: json["transId"] ?? "",
      totalItem: json["totalItem"] ?? 0,
      errors: json["errors"] == null
          ? []
          : List<ErrorModelResponse>.from(
              json["errors"]!.map((x) => ErrorModelResponse.fromJson(x))),
      data: json["data"] != null
          ? List<T>.from(json["data"].map((x) => func(x)))
          : [],
    );
  }
}
