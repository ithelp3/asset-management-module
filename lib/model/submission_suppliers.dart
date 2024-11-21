class SubmissionSuppliers {
  int? id;
  int? submissionId;
  int? addedFrom;
  String? notes;
  int? isApproved;
  int? purchaseId;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;
  List<SupplierRelations>? suppliers;

  SubmissionSuppliers({
    this.id,
    this.submissionId,
    this.addedFrom,
    this.notes,
    this.isApproved,
    this.purchaseId,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
    this.suppliers,
  });

  factory SubmissionSuppliers.fromJson(Map<String, dynamic> json) => SubmissionSuppliers(
    id: json["id"],
    submissionId: json["submission_id"],
    addedFrom: json["addedfrom"],
    notes: json["notes"],
    isApproved: json["is_approved"],
    purchaseId: json["purchase_id"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    suppliers: List<SupplierRelations>.from(json["suppliers"].map((x) => SupplierRelations.fromJson(x))),
  );
}

class SupplierRelations {
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

  SupplierRelations({
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

  factory SupplierRelations.fromJson(Map<String, dynamic> json) => SupplierRelations(
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