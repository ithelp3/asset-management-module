class Pwa {
  int? userId;
  int? type;
  int? companyId;
  int? packageId;
  int? empId;
  String? empPin;
  int? moduleId;
  String? ipAddress;
  String? platform;
  String? language;
  String? theme;
  String? email;

  Pwa({
    this.userId,
    this.type,
    this.companyId,
    this.packageId,
    this.empId,
    this.empPin,
    this.moduleId,
    this.ipAddress,
    this.platform,
    this.language,
    this.theme,
    this.email,
  });

  factory Pwa.fromJson(Map<String, dynamic> json) => Pwa(
    userId: json["user_id"],
    type: json["type"],
    companyId: json["company_id"],
    packageId: json["package_id"],
    empId: json["emp_id"],
    empPin: json["emp_pin"],
    moduleId: json["module_id"],
    ipAddress: json["ip_address"],
    platform: json["platform"],
    language: json["language"],
    theme: json["theme"],
    email: json["email"],
  );
}