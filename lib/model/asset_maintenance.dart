class AssetMaintenance {
  int? id;
  int? assetId;
  int? addedFrom;
  int? supplierId;
  String? startDate;
  String? endDate;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;
  String? supplier;
  String? asset;

  AssetMaintenance({
    this.id,
    this.assetId,
    this.addedFrom,
    this.supplierId,
    this.startDate,
    this.endDate,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
    this.supplier,
    this.asset,
  });

  factory AssetMaintenance.fromJson(Map<String, dynamic> json) => AssetMaintenance(
    id: json["id"],
    assetId: json["assetid"],
    addedFrom: json["addedfrom"],
    supplierId: json["supplierid"],
    startDate: json["startdate"],
    endDate: json["enddate"],
    type: json["type"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    supplier: json["supplier"],
    asset: json["asset"],
  );

}