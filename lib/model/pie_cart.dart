class PieChart {
  int? total;
  String? name;

  PieChart({
    this.total,
    this.name,
  });

  factory PieChart.fromJson(Map<String, dynamic> json) => PieChart(
    total: json["total"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "name": name,
  };
}