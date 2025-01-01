class FileModel {
  FileModel({
    required this.size,
    required this.filename,
  });

  final int? size;
  final String? filename;

  factory FileModel.fromJson(Map<String, dynamic> json){
    return FileModel(
      size: json["size"],
      filename: json["filename"],
    );
  }

  Map<String, dynamic> toJson() => {
    "size": size,
    "filename": filename,
  };

}
