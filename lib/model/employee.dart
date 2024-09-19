class Employee {
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
  String? statusName;
  String? countryName;
  String? roleName;
  String? departmentName;

  Employee({
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
    this.statusName,
    this.countryName,
    this.roleName,
    this.departmentName,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
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
    statusName: json["status_name"],
    countryName: json["country_name"],
    roleName: json["role_name"],
    departmentName: json["department_name"],
  );
}