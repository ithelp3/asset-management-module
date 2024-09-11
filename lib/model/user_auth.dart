class UserAuth {
  int? id;
  String? company;
  String? address;
  String? email;
  String? phoneNumber;
  String? country;
  String? logo;
  String? formatDate;
  String? createdAt;
  String? updatedAt;
  String? currency;
  String? language;
  String? submissionPrefix;
  int? checkoutDefaultStatus;
  int? checkInDefaultStatus;
  int? repairDefaultStatus;
  int? saasCompanyId;
  String? token;
  String? urlLogo;

  UserAuth({
    this.id,
    this.company,
    this.address,
    this.email,
    this.phoneNumber,
    this.country,
    this.logo,
    this.formatDate,
    this.createdAt,
    this.updatedAt,
    this.currency,
    this.language,
    this.submissionPrefix,
    this.checkoutDefaultStatus,
    this.checkInDefaultStatus,
    this.repairDefaultStatus,
    this.saasCompanyId,
    this.token,
    this.urlLogo,
  });

  factory UserAuth.fromJson(Map<String, dynamic> json) => UserAuth(
    id: json["id"],
    company: json["company"],
    address: json["address"],
    email: json["email"],
    phoneNumber: json["phonenumber"],
    country: json["country"],
    logo: json["logo"],
    formatDate: json["formatdate"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    currency: json["currency"],
    language: json["language"],
    submissionPrefix: json["submission_prefix"],
    checkoutDefaultStatus: json["checkout_default_status"],
    checkInDefaultStatus: json["checkin_default_status"],
    repairDefaultStatus: json["repair_default_status"],
    saasCompanyId: json["saas_company_id"],
    token: json["token"],
    urlLogo: json["url_logo"],
  );
}