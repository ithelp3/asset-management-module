class AssetFile {
  int? id;
  int? assetId;
  int? componentId;
  int? addedFrom;
  String? name;
  String? filename;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;
  String? fileUrl;

  AssetFile({
    this.id,
    this.assetId,
    this.componentId,
    this.addedFrom,
    this.name,
    this.filename,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
    this.fileUrl,
  });

  factory AssetFile.fromJson(Map<String, dynamic> json) => AssetFile(
    id: json["id"],
    assetId: json["assetid"],
    componentId: json["componentid"],
    addedFrom: json["addedfrom"],
    name: json["name"],
    filename: json["filename"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    fileUrl: json["file_url"],
  );
}