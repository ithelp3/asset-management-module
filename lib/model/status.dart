class Status {
  int? id;
  String? name;
  String? color;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  Status({
    this.id,
    this.name,
    this.color,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
    color: json["color"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
  );
}