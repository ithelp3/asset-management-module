class AssetLog {
  int? id;
  int? assetId;
  String? description;
  int? userId;
  String? fullName;
  String? logData;
  String? logKey;
  String? translatedActivity;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  AssetLog({
    this.id,
    this.assetId,
    this.description,
    this.userId,
    this.fullName,
    this.logData,
    this.logKey,
    this.translatedActivity,
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
    logData: json["log_data"],
    logKey: json["log_key"],
    translatedActivity: json['translated_activity'],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
  );
}