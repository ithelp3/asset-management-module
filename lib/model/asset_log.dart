class AssetLog {
  int? id;
  int? assetId;
  String? description;
  int? userId;
  String? fullName;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  AssetLog({
    this.id,
    this.assetId,
    this.description,
    this.userId,
    this.fullName,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
  });

  factory AssetLog.fromJson(Map<String, dynamic> json) => AssetLog(
    id: json["id"],
    assetId: json["asset_id"],
    description: json["description"],
    userId: json["user_id"],
    fullName: json["fullname"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
  );
}