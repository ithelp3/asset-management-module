class Supplier {
  int? id;
  String? name;
  String? email;
  String? city;
  String? country;
  String? zip;
  String? phone;
  String? address;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  Supplier({
    this.id,
    this.name,
    this.email,
    this.city,
    this.country,
    this.zip,
    this.phone,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    city: json["city"],
    country: json["country"],
    zip: json["zip"],
    phone: json["phone"],
    address: json["address"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
  );
}