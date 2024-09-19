class Component {
  int? id;
  int? supplierId;
  int? brandId;
  String? name;
  String? serial;
  String? quantity;
  String? purchaseDate;
  String? cost;
  String? warranty;
  String? status;
  String? picture;
  String? description;
  int? addedFrom;
  int? officeId;
  int? floorId;
  int? roomId;
  int? groupId;
  int? categoryId;
  int? subcategoryId;
  int? picId;
  int? checkStatus;
  int? taxReport;
  String? createdAt;
  String? updatedAt;
  int? saasCompanyId;
  int? warrantyType;
  int? buildingId;
  String? groupName;
  String? categoryName;
  String? subCategoryName;
  String? statusName;
  String? pictureUrl;

  Component({
    this.id,
    this.supplierId,
    this.brandId,
    this.name,
    this.serial,
    this.quantity,
    this.purchaseDate,
    this.cost,
    this.warranty,
    this.status,
    this.picture,
    this.description,
    this.addedFrom,
    this.officeId,
    this.floorId,
    this.roomId,
    this.groupId,
    this.categoryId,
    this.subcategoryId,
    this.picId,
    this.checkStatus,
    this.taxReport,
    this.createdAt,
    this.updatedAt,
    this.saasCompanyId,
    this.warrantyType,
    this.buildingId,
    this.groupName,
    this.categoryName,
    this.subCategoryName,
    this.statusName,
    this.pictureUrl,
  });

  factory Component.fromJson(Map<String, dynamic> json) => Component(
    id: json["id"],
    supplierId: json["supplierid"],
    brandId: json["brandid"],
    name: json["name"],
    serial: json["serial"],
    quantity: json["quantity"],
    purchaseDate: json["purchasedate"],
    cost: json["cost"],
    warranty: json["warranty"],
    status: json["status"],
    picture: json["picture"],
    description: json["description"],
    addedFrom: json["addedfrom"],
    officeId: json["office_id"],
    floorId: json["floor_id"],
    roomId: json["room_id"],
    groupId: json["group_id"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    picId: json["pic_id"],
    checkStatus: json["checkstatus"],
    taxReport: json["tax_report"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    saasCompanyId: json["saas_company_id"],
    warrantyType: json["warranty_type"],
    buildingId: json["building_id"],
    groupName: json["group_name"],
    categoryName: json["categoryname"],
    subCategoryName: json["sub_category_name"],
    statusName: json["status_name"],
    pictureUrl: json["picture_url"],
  );

}