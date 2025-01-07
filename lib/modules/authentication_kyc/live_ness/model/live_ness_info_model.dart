// class LiveNessInfoModel {
//   LiveNessInfoModel({
//     required this.livenessConfigInfo,
//     required this.rate,
//   });
//
//   final List<LiveNessConfigInfo> livenessConfigInfo;
//   final double? rate;
//
//   factory LiveNessInfoModel.fromJson(Map<String, dynamic> json){
//     return LiveNessInfoModel(
//       livenessConfigInfo: json["livenessConfigInfo"] == null ? [] : List<LiveNessConfigInfo>.from(json["livenessConfigInfo"]!.map((x) => LiveNessConfigInfo.fromJson(x))),
//       rate: json["rate"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "livenessConfigInfo": livenessConfigInfo.map((x) => x.toJson()).toList(),
//     "rate": rate,
//   };
//
// }
//
// class LiveNessConfigInfo {
//   LiveNessConfigInfo({
//     required this.name,
//     required this.required,
//   });
//
//   final String? name;
//   final bool? required;
//
//   factory LiveNessConfigInfo.fromJson(Map<String, dynamic> json){
//     return LiveNessConfigInfo(
//       name: json["name"],
//       required: json["required"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "required": required,
//   };
//
// }