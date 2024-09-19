class Maintenance {
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
  String? addedFromName;
  String? supplierName;
  String? assetName;
  String? assetTag;

  Maintenance({
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
    this.addedFromName,
    this.supplierName,
    this.assetName,
    this.assetTag,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) => Maintenance(
    id: json["id"],
    assetId: json["assetid"],
    addedFrom: json["addedfrom"],
    supplierId: json["supplierid"],
    startDate: json["startdate"],
    endDate: json["enddate"],
    type: json["type"],
    createdAt: json["created_at"],
    updatedAt:json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    addedFromName: json["added_from_name"],
    supplierName: json["supplier_name"],
    assetName: json["asset_name"],
    assetTag: json["asset_tag"],
  );
}