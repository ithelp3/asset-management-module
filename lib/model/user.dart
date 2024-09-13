class User {
  int? id;
  String? fullName;
  String? email;
  String? password;
  String? apiToken;
  String? status;
  int? country;
  String? address;
  String? phone;
  int? role;
  int? officeId;
  int? departmentId;
  String? position;
  String? createdAt;
  String? updatedAt;
  int? admin;
  int? saasCompanyId;
  int? isSaasSuperAdmin;

  User({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.apiToken,
    this.status,
    this.country,
    this.address,
    this.phone,
    this.role,
    this.officeId,
    this.departmentId,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.admin,
    this.saasCompanyId,
    this.isSaasSuperAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["fullname"],
    email: json["email"],
    password: json["password"],
    apiToken: json["api_token"],
    status: json["status"],
    country: json["country"],
    address: json["address"],
    phone: json["phone"],
    role: json["role"],
    officeId: json["office_id"],
    departmentId: json["department_id"],
    position: json["position"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    admin: json["admin"],
    saasCompanyId: json["saas_company_id"],
    isSaasSuperAdmin: json["is_saas_superadmin"],
  );
}