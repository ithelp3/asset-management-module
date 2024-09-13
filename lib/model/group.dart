class Group {
  int? id;
  String? kode;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  Group({
    this.id,
    this.kode,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    id: json["id"],
    kode: json["kode"],
    name: json["name"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
  );
}