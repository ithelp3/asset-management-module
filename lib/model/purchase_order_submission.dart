class PurchaseOrderSubmission {
  int? id;
  String? username;
  String? subject;
  String? submissionDetail;
  String? priority;
  String? dateUsed;
  String? status;
  int? step;
  String? submissionId;

  PurchaseOrderSubmission({
    this.id,
    this.username,
    this.subject,
    this.submissionDetail,
    this.priority,
    this.dateUsed,
    this.status,
    this.step,
    this.submissionId,
  });

  factory PurchaseOrderSubmission.fromJson(Map<String, dynamic> json) => PurchaseOrderSubmission(
    id: json["id"],
    username: json["username"],
    subject: json["subject"],
    submissionDetail: json["submission_detail"],
    priority: json["priority"],
    dateUsed: json["date_used"],
    status: json["status"],
    step: json["step"],
    submissionId: json["submission_id"],
  );

}