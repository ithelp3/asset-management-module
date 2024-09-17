class Office {
  int? id;
  String? name;
  String? inisial;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  Office({
    this.id,
    this.name,
    this.inisial,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
  });

  factory Office.fromJson(Map<String, dynamic> json) => Office(
    id: json["id"],
    name: json["name"],
    inisial: json["inisial"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "inisial": inisial,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "saas_company_id": saasCompanyId,
  };
}