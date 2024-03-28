class OnlineinspectionResponse {
  String? condition;
  String? message;
  String? totalRows;
  String? plantingNo;
  String? productionLotNo;
  String? seasonCode;
  String? seasonName;
  String? organizerCode;
  String? organizerName;
  OrganizerDetail? organizerDetail;
  String? growerLandOwnerName;
  String? growerOwnerCode;
  OrganizerDetail? growerDetail;
  String? productionCenterLoc;
  String? plantingDate;
  String? cropCode;
  String? varietyCode;
  String? itemCropType;
  String? itemClassOfSeeds;
  String? itemProductGroupCode;
  String? sowingDateMale;
  String? sowingDateFemale;
  String? sowingDateOther;
  bool? isSelected;


  OnlineinspectionResponse(
      {this.condition,
        this.message,
        this.totalRows,
        this.plantingNo,
        this.productionLotNo,
        this.seasonCode,
        this.seasonName,
        this.organizerCode,
        this.organizerName,
        this.organizerDetail,
        this.growerLandOwnerName,
        this.growerOwnerCode,
        this.growerDetail,
        this.productionCenterLoc,
        this.plantingDate,
        this.cropCode,
        this.varietyCode,
        this.itemCropType,
        this.itemClassOfSeeds,
        this.itemProductGroupCode,
        this.sowingDateMale,
        this.sowingDateFemale,
        this.sowingDateOther,
        this.isSelected});

  OnlineinspectionResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalRows = json['total_rows'];
    plantingNo = json['planting_no'];
    productionLotNo = json['production_lot_no'];
    seasonCode = json['season_code'];
    seasonName = json['season_name'];
    organizerCode = json['organizer_code'];
    organizerName = json['organizer_name'];
    organizerDetail = json['organizer_detail'] != null
        ? new OrganizerDetail.fromJson(json['organizer_detail'])
        : null;
    growerLandOwnerName = json['grower_land_owner_name'];
    growerOwnerCode = json['grower_owner_code'];
    growerDetail = json['grower_detail'] != null
        ? new OrganizerDetail.fromJson(json['grower_detail'])
        : null;
    productionCenterLoc = json['production_center_loc'];
    plantingDate = json['planting_date'];
    cropCode = json['crop_code'];
    varietyCode = json['variety_code'];
    itemCropType = json['item_crop_type'];
    itemClassOfSeeds = json['item_class_of_seeds'];
    itemProductGroupCode = json['item_product_group_code'];
    sowingDateMale = json['sowing_date_male'];
    sowingDateFemale = json['sowing_date_female'];
    sowingDateOther = json['sowing_date_other'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_rows'] = this.totalRows;
    data['planting_no'] = this.plantingNo;
    data['production_lot_no'] = this.productionLotNo;
    data['season_code'] = this.seasonCode;
    data['season_name'] = this.seasonName;
    data['organizer_code'] = this.organizerCode;
    data['organizer_name'] = this.organizerName;
    if (this.organizerDetail != null) {
      data['organizer_detail'] = this.organizerDetail!.toJson();
    }
    data['grower_land_owner_name'] = this.growerLandOwnerName;
    data['grower_owner_code'] = this.growerOwnerCode;
    if (this.growerDetail != null) {
      data['grower_detail'] = this.growerDetail!.toJson();
    }
    data['production_center_loc'] = this.productionCenterLoc;
    data['planting_date'] = this.plantingDate;
    data['crop_code'] = this.cropCode;
    data['variety_code'] = this.varietyCode;
    data['item_crop_type'] = this.itemCropType;
    data['item_class_of_seeds'] = this.itemClassOfSeeds;
    data['item_product_group_code'] = this.itemProductGroupCode;
    data['sowing_date_male'] = this.sowingDateMale;
    data['sowing_date_female'] = this.sowingDateFemale;
    data['sowing_date_other'] = this.sowingDateOther;
    data['isSelected'] = this.isSelected;
    return data;
  }
}

class OrganizerDetail {
  String? address;
  String? address2;
  String? postCode;
  String? stateCode;
  String? stateName;
  String? countryCode;
  String? countryName;
  String? phoneNo;
  String? mobileNo;

  OrganizerDetail(
      {this.address,
        this.address2,
        this.postCode,
        this.stateCode,
        this.stateName,
        this.countryCode,
        this.countryName,
        this.phoneNo,
        this.mobileNo});

  OrganizerDetail.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    address2 = json['address2'];
    postCode = json['post_code'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    countryCode = json['country_code'];
    countryName = json['country_name'];
    phoneNo = json['phone_no'];
    mobileNo = json['mobile_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['post_code'] = this.postCode;
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['country_code'] = this.countryCode;
    data['country_name'] = this.countryName;
    data['phone_no'] = this.phoneNo;
    data['mobile_no'] = this.mobileNo;
    return data;
  }
}
