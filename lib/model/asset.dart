class Asset {
  int? id;
  int? supplierId;
  int? brandId;
  String? assetTag;
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
  int? number;
  int? buildingId;
  int? approvalStatus;
  String? assetName;
  String? assetCreatedAt;
  String? assetUpdatedAt;
  String? brand;
  String? supplier;
  String? floorName;
  String? roomName;
  String? statusName;
  String? officeName;
  String? groupName;
  String? categoryName;
  String? subcategoryName;
  String? pic;
  String? statusColor;
  String? assign;
  String? locations;
  String? pictures;
  String? buildingName;

  Asset({
    this.id,
    this.supplierId,
    this.brandId,
    this.assetTag,
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
    this.number,
    this.buildingId,
    this.approvalStatus,
    this.assetName,
    this.assetCreatedAt,
    this.assetUpdatedAt,
    this.brand,
    this.supplier,
    this.floorName,
    this.roomName,
    this.statusName,
    this.officeName,
    this.groupName,
    this.categoryName,
    this.subcategoryName,
    this.pic,
    this.statusColor,
    this.assign,
    this.locations,
    this.pictures,
    this.buildingName,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    id: json["id"],
    supplierId: json["supplierid"],
    brandId: json["brandid"],
    assetTag: json["assettag"],
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
    number: json["number"],
    buildingId: json["building_id"],
    approvalStatus: json["approval_status"],
    assetName: json["assetname"],
    assetCreatedAt: json["assetcreated_at"],
    assetUpdatedAt: json["assetupdated_at"],
    brand: json["brand"],
    supplier: json["supplier"],
    floorName: json["floorname"],
    roomName: json["roomname"],
    statusName: json["status_name"],
    officeName: json["officename"],
    groupName: json["groupname"],
    categoryName: json["categoryname"],
    subcategoryName: json["subcategoryname"],
    pic: json["pic"],
    statusColor: json["status_color"],
    assign: json["assign"],
    locations: json["locations"],
    pictures: json["pictures"],
    buildingName: json["building_name"],
  );

}
