class AssetDepreciation {
  int? depreciationId;
  int? period;
  String? periodMonth;
  String? bookValue;
  String? depreciationPercentage;
  String? amount;
  String? accumulatedDepreciation;
  String? endingBookValue;
  int? saasCompanyId;
  int? depreciationFormula;
  int? id;

  AssetDepreciation({
    this.depreciationId,
    this.period,
    this.periodMonth,
    this.bookValue,
    this.depreciationPercentage,
    this.amount,
    this.accumulatedDepreciation,
    this.endingBookValue,
    this.saasCompanyId,
    this.depreciationFormula,
    this.id,
  });

  factory AssetDepreciation.fromJson(Map<String, dynamic> json) => AssetDepreciation(
    depreciationId: json["depreciation_id"],
    period: json["period"],
    periodMonth: json["period_month"],
    bookValue: json["book_value"],
    depreciationPercentage: json["depreciation_precentage"],
    amount: json["amount"],
    accumulatedDepreciation: json["accumulated_depreciation"],
    endingBookValue: json["ending_book_value"],
    saasCompanyId: json["saas_company_id"],
    depreciationFormula: json["depreciation_formula"],
    id: json["id"],
  );
}