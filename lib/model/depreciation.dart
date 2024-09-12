class Depreciation {
  int? id;
  int? assetId;
  int? componentId;
  int? addedFrom;
  int? depreciationFormula;
  String? period;
  String? assetValue;
  String? depreciationRate;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;
  String? name;
  String? asset;
  String? assetCost;
  String? category;
  String? cost;

  Depreciation({
    this.id,
    this.assetId,
    this.componentId,
    this.addedFrom,
    this.depreciationFormula,
    this.period,
    this.assetValue,
    this.depreciationRate,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
    this.name,
    this.asset,
    this.assetCost,
    this.category,
    this.cost,
  });

  factory Depreciation.fromJson(Map<String, dynamic> json) => Depreciation(
    id: json["id"],
    assetId: json["assetid"],
    componentId: json["componentid"],
    addedFrom: json["addedfrom"],
    depreciationFormula: json["depreciation_formula"],
    period: json["period"],
    assetValue: json["assetvalue"],
    depreciationRate: json["depreciation_rate"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    name: json["name"],
    asset: json["asset"],
    assetCost: json["assetcost"],
    category: json["category"],
    cost: json["cost"],
  );

}