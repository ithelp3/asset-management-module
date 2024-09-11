class RecentAsset {
  int? id;
  int? assetId;
  int? employeeId;
  String? date;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;
  String? asset;
  String? employeeName;
  String? employeeStatus;
  String? statusId;
  String? statusName;

  RecentAsset({
    this.id,
    this.assetId,
    this.employeeId,
    this.date,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
    this.asset,
    this.employeeName,
    this.employeeStatus,
    this.statusId,
    this.statusName,
  });

  factory RecentAsset.fromJson(Map<String, dynamic> json) => RecentAsset(
    id: json["id"],
    assetId: json["assetid"],
    employeeId: json["employeeid"],
    date: json["date"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    asset: json["asset"],
    employeeName: json["employeename"],
    employeeStatus: json["employee_status"],
    statusId: json["status_id"],
    statusName: json["status_name"],
  );

}