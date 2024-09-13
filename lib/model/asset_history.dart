class AssetHistory {
  int? id;
  int? assetId;
  int? employeeId;
  String? date;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;
  String? assetName;
  String? employeeName;
  String? employee;

  AssetHistory({
    this.id,
    this.assetId,
    this.employeeId,
    this.date,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
    this.assetName,
    this.employeeName,
    this.employee,
  });

  factory AssetHistory.fromJson(Map<String, dynamic> json) => AssetHistory(
    id: json["id"],
    assetId: json["assetid"],
    employeeId: json["employeeid"],
    date: json["date"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    assetName: json["assetname"],
    employeeName: json["employeename"],
    employee: json["employee"],
  );
}