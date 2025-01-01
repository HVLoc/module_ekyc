class SupportModel {
  SupportModel({
    this.alias,
    this.name,
    this.companyName,
    this.phone,
    this.email,
    this.address,
    this.webSite,
    this.license,
  });

  final String? alias;
  final String? name;
  final String? companyName;
  final String? phone;
  final String? email;
  final String? address;
  final String? webSite;
  final String? license;

  factory SupportModel.fromJson(Map<String, dynamic> json){
    return SupportModel(
      alias: json["alias"],
      name: json["name"],
      companyName: json["companyName"],
      phone: json["phone"],
      email: json["email"],
      address: json["address"],
      webSite: json["webSite"],
      license: json["license"],
    );
  }

}
