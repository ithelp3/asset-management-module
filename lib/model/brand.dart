class Brand {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  Brand({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
  );

}