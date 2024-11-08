class AssetRelations {
  int? id;
  int? relId;
  String? relType;
  String? name;
  int? brandId;
  String? brandName;
  String? brandDescription;
  int? subCategoryId;
  String? subCategoryName;
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
    this.subCategoryName,
    this.brandId,
    this.brandName,
    this.brandDescription,
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
    subCategoryName: json["subcategory_name"],
    brandId: json["brandid"],
    brandName: json["brand_name"],
    brandDescription: json["brand_description"],
    cost: json["cost"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    description: json["description"],
    qty: json["qty"],
    picture: json["picture"],
  );
}