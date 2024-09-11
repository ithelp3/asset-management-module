class Submission {
  int? id;
  String? name;
  int? status;
  int? supplierId;
  int? brandId;
  String? date;
  String? cost;
  int? addedFrom;
  String? description;
  String? reason;
  String? picture;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  Submission({
    this.id,
    this.name,
    this.status,
    this.supplierId,
    this.brandId,
    this.date,
    this.cost,
    this.addedFrom,
    this.description,
    this.reason,
    this.picture,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    supplierId: json["supplierid"],
    brandId: json["brandid"],
    date: json["date"],
    cost: json["cost"],
    addedFrom: json["addedfrom"],
    description: json["description"],
    reason: json["reason"],
    picture: json["picture"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
  );
}