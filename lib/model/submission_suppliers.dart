class SubmissionSuppliers {
  int? id;
  int? relId;
  String? relType;
  String? supplierId;
  String? supplierName;
  String? filename;
  String? originalFilename;
  int? isChecked;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;
  String? fileUrl;

  SubmissionSuppliers({
    this.id,
    this.relId,
    this.relType,
    this.supplierId,
    this.supplierName,
    this.filename,
    this.originalFilename,
    this.isChecked,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
    this.fileUrl,
  });

  factory SubmissionSuppliers.fromJson(Map<String, dynamic> json) => SubmissionSuppliers(
    id: json["id"],
    relId: json["rel_id"],
    relType: json["rel_type"],
    supplierId: json["supplierid"],
    supplierName: json["supplier_name"],
    filename: json["filename"],
    originalFilename: json["original_filename"],
    isChecked: json["is_checked"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    fileUrl: json["file_url"],
  );
}