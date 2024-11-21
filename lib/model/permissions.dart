class Permission {
  String? feature;
  List<String>? permissions;

  Permission({
    this.feature,
    this.permissions,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    feature: json["feature"],
    permissions: List<String>.from(json["permissions"].map((x) => x)),
  );
}
