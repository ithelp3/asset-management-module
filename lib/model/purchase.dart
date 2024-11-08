class Purchase {
  int? id;
  String? subject;
  int? status;
  int? supplierId;
  String? supplierName;
  String? supplierAddress;
  String? supplierPhone;
  String? supplierEmail;
  int? findSupplierId;
  int? isConverted;
  String? date;
  int? addedFrom;
  String? addedFromName;
  String? reason;
  String? notes;
  String? total;
  String? subtotal;
  String? tax;
  String? taxTotal;
  String? discount;
  String? discountTotal;
  int? formatNumber;
  int? updatedBy;
  String? fileUrl;
  String? fileName;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  Purchase({
    this.id,
    this.subject,
    this.status,
    this.supplierId,
    this.supplierName,
    this.supplierAddress,
    this.supplierPhone,
    this.supplierEmail,
    this.findSupplierId,
    this.isConverted,
    this.date,
    this.addedFrom,
    this.addedFromName,
    this.reason,
    this.notes,
    this.total,
    this.subtotal,
    this.tax,
    this.taxTotal,
    this.discount,
    this.discountTotal,
    this.formatNumber,
    this.updatedBy,
    this.fileUrl,
    this.fileName,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
    id: json["id"],
    subject: json["subject"],
    status: json["status"],
    supplierId: json["supplierid"],
    supplierName: json["supplier_name"],
    supplierAddress: json["supplier_address"],
    supplierPhone: json["supplier_phone"],
    supplierEmail: json["supplier_email"],
    findSupplierId: json["find_supplierid"],
    isConverted: json["is_converted"],
    date: json["date"],
    addedFrom: json["addedfrom"],
    addedFromName: json["addedfrom_name"],
    reason: json["reason"],
    notes: json["notes"],
    total: json["total"],
    subtotal: json["subtotal"],
    tax: json["tax"],
    taxTotal: json["tax_total"],
    discount: json["discount"],
    discountTotal: json["discount_total"],
    formatNumber: json["format_number"],
    updatedBy: json["updated_by"],
    fileUrl: json["file_url"],
    fileName: json["file_name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
  );
}