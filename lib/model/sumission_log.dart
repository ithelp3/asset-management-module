class SubmissionLog {
  int? id;
  int? submissionId;
  String? logKey;
  String? logData;
  int? userId;
  String? fullName;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;
  String? userName;
  String? username;
  String? translatedActivity;

  SubmissionLog({
    this.id,
    this.submissionId,
    this.logKey,
    this.logData,
    this.userId,
    this.fullName,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
    this.userName,
    this.username,
    this.translatedActivity,
  });

  factory SubmissionLog.fromJson(Map<String, dynamic> json) => SubmissionLog(
    id: json["id"],
    submissionId: json["submission_id"],
    logKey: json["log_key"],
    logData: json["log_data"],
    userId: json["user_id"],
    fullName: json["fullname"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    userName: json["user_name"],
    username: json["username"],
    translatedActivity: json["translated_activity"],
  );
}
