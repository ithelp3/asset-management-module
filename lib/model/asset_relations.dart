class AssetRelations {
  int? id;
  int? relId;
  int? relType;
  String? name;
  int? brandId;
  int? subCategoryId;
  String? cost;
  String? description;
  String? picture;
  int? qty;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  AssetRelations({
    this.id,
    this.relId,
    this.name,
    this.relType,
    this.subCategoryId,
    this.brandId,
    this.cost,
    this.description,
    this.updatedAt,
    this.createdAt,
    this.saasCompanyId,
    this.qty,
    this.picture,
  });

  factory AssetRelations.fromJson(Map<String, dynamic> json) => AssetRelations(
    id: json["id"],
    relId: json["rel_id"],
    relType: json["rel_type"],
    name: json["name"],
    subCategoryId: json["subcategory_id"],
    brandId: json["brandid"],
    cost: json["cost"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    description: json["description"],
    qty: json["qty"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "rel_id": relType,
    "name": name,
    "description": description,
    "brandid": brandId,
    "subcategory_id": subCategoryId,
    "qty": qty,
    "cost": cost,
    "picture": picture,
  };
}