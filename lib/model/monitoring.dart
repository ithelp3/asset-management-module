class Monitoring {
  int? id;
  int? addedFromId;
  String? username;
  String? subject;
  String? submissionDetail;
  String? priority;
  String? dateUsed;
  String? status;
  int? step;
  String? submissionId;
  int? purchaseStatus;
  int? findSupplierId;
  String? reason;

  Monitoring({
    this.id,
    this.addedFromId,
    this.username,
    this.subject,
    this.submissionDetail,
    this.priority,
    this.dateUsed,
    this.status,
    this.step,
    this.submissionId,
    this.purchaseStatus,
    this.findSupplierId,
    this.reason,
  });

  factory Monitoring.fromJson(Map<String, dynamic> json) => Monitoring(
    id: json["id"],
    addedFromId: json["added_from_id"],
    username: json["username"],
    subject: json["subject"],
    submissionDetail: json["submission_detail"],
    priority: json["priority"],
    dateUsed: json["date_used"],
    status: json["status"],
    step: json["step"],
    submissionId: json["submission_id"],
    purchaseStatus: json["purchase_status"],
    findSupplierId: json['find_supplier_id'],
    reason: json['reason'],
  );

}