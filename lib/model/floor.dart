class Floor {
  int? id;
  String? name;
  String? description;
  int? parentId;
  int? officeId;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  Floor({
    this.id,
    this.name,
    this.description,
    this.parentId,
    this.officeId,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
  });

  factory Floor.fromJson(Map<String, dynamic> json) => Floor(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    parentId: json["parent_id"],
    officeId: json["office_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "parent_id": parentId,
    "office_id": officeId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "saas_company_id": saasCompanyId,
  };
}