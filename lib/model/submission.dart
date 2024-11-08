class Submission {
  int? id;
  String? subject;
  String? submissionDetail;
  String? priority;
  int? addedFrom;
  String? dateUsed;
  String? status;
  int? number;
  String? reason;
  int? step;
  int? approvalLevel;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;
  String? username;
  String? submissionId;
  int? addedFromId;
  int? findSupplierId;

  Submission({
    this.id,
    this.subject,
    this.submissionDetail,
    this.priority,
    this.addedFrom,
    this.dateUsed,
    this.status,
    this.number,
    this.reason,
    this.step,
    this.approvalLevel,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
    this.username,
    this.submissionId,
    this.addedFromId,
    this.findSupplierId,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
    id: json["id"],
    subject: json["subject"],
    submissionDetail: json["submission_detail"],
    priority: json["priority"],
    addedFrom: json["addedfrom"],
    dateUsed: json["date_used"],
    status: json["status"],
    number: json["number"],
    reason: json["reason"],
    step: json["step"],
    approvalLevel: json["approval_level"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    username: json["username"],
    submissionId: json["submission_id"],
    addedFromId: json["added_from_id"],
    findSupplierId: json["find_supplier_id"],
  );
}