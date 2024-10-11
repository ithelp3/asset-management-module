class Profile {
  int? id;
  String? fullName;
  String? email;
  String? password;
  String? apiToken;
  String? status;
  int? country;
  String? address;
  String? phone;
  Department? role;
  int? officeId;
  int? departmentId;
  String? position;
  String? createdAt;
  String? updatedAt;
  int? admin;
  int? saasCompanyId;
  int? isSaasSuperAdmin;
  Department? office;
  Department? department;

  Profile({
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
    this.office,
    this.department,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    fullName: json["fullname"],
    email: json["email"],
    password: json["password"],
    apiToken: json["api_token"],
    status: json["status"],
    country: json["country"],
    address: json["address"],
    phone: json["phone"],
    role: json["role"] != null ? Department.fromJson(json["role"]) : Department(),
    officeId: json["office_id"],
    departmentId: json["department_id"],
    position: json["position"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    admin: json["admin"],
    saasCompanyId: json["saas_company_id"],
    isSaasSuperAdmin: json["is_saas_superadmin"],
    office: Department.fromJson(json["office"]),
    department: Department.fromJson(json["department"]),
  );
}

class Department {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;
  String? initial;
  String? guardName;

  Department({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
    this.initial,
    this.guardName,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    initial: json["inisial"],
    guardName: json["guard_name"],
  );

}