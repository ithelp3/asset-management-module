class Purchase {
  int? id;
  String? subject;
  int? status;
  int? supplierId;
  int? findSupplierId;
  int? isConverted;
  String? date;
  int? addedFrom;
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
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;

  Purchase({
    this.id,
    this.subject,
    this.status,
    this.supplierId,
    this.findSupplierId,
    this.isConverted,
    this.date,
    this.addedFrom,
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
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
    id: json["id"],
    subject: json["subject"],
    status: json["status"],
    supplierId: json["supplierid"],
    findSupplierId: json["find_supplierid"],
    isConverted: json["is_converted"],
    date: json["date"],
    addedFrom: json["addedfrom"],
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
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
  );
}