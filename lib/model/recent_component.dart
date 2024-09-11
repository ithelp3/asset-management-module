class RecentComponent {
  int? id;
  int? assetId;
  int? componentId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  String? status;
  String? date;
  int? saasCompanyId;
  String? component;
  String? asset;
  String? statusId;
  String? statusName;

  RecentComponent({
    this.id,
    this.assetId,
    this.componentId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.date,
    this.saasCompanyId,
    this.component,
    this.asset,
    this.statusId,
    this.statusName,
  });

  factory RecentComponent.fromJson(Map<String, dynamic> json) => RecentComponent(
    id: json["id"],
    assetId: json["assetid"],
    componentId: json["componentid"],
    quantity: json["quantity"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    status: json["status"],
    date: json["date"],
    saasCompanyId: json["saas_company_id"],
    component: json["component"],
    asset: json["asset"],
    statusId: json["status_id"],
    statusName: json["status_name"],
  );
  
}