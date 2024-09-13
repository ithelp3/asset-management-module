class Room {
  int? id;
  String? name;
  String? description;
  int? parentId;
  int? officeId;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  Room({
    this.id,
    this.name,
    this.description,
    this.parentId,
    this.officeId,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    parentId: json["parent_id"],
    officeId: json["office_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
  );
}