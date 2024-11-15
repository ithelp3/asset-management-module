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
  int? checkoutDefaultStatus;
  int? checkInDefaultStatus;
  int? repairDefaultStatus;
  String? submissionPrefix;
  int? saasCompanyId;
  String? tagComponent;
  int? counterDigit;
  String? purchasePrefix;
  List? approverLevel1;
  List? approverLevel2;
  List? approverLevel3;
  String? token;
  String? urlLogo;
  int? userId;

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
    this.checkoutDefaultStatus,
    this.checkInDefaultStatus,
    this.repairDefaultStatus,
    this.submissionPrefix,
    this.saasCompanyId,
    this.tagComponent,
    this.counterDigit,
    this.purchasePrefix,
    this.approverLevel1,
    this.approverLevel2,
    this.approverLevel3,
    this.token,
    this.urlLogo,
    this.userId,
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
    checkoutDefaultStatus: json["checkout_default_status"],
    checkInDefaultStatus: json["checkin_default_status"],
    repairDefaultStatus: json["repair_default_status"],
    submissionPrefix: json["submission_prefix"],
    saasCompanyId: json["saas_company_id"],
    tagComponent: json["tag_component"],
    counterDigit: json["counter_digit"],
    purchasePrefix: json["purchase_prefix"],
    approverLevel1: json["approver_level_1"].split(',').map((i) => int.tryParse(i)).toList(),
    approverLevel2: json["approver_level_2"].split(',').map((i) => int.tryParse(i)).toList(),
    approverLevel3: json["approver_level_3"].split(',').map((i) => int.tryParse(i)).toList(),
    token: json["token"],
    urlLogo: json["url_logo"],
    userId: json["user_id"],
  );
}