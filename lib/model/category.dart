class Category {
  int? id;
  String? kode;
  String? name;
  int? parentId;
  int? groupId;
  int? number;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  Category({
    this.id,
    this.kode,
    this.name,
    this.parentId,
    this.groupId,
    this.number,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    kode: json["kode"],
    name: json["name"],
    parentId: json["parent_id"],
    groupId: json["group_id"],
    number: json["number"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
  );
}