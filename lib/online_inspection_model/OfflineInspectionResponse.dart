import 'package:flutter/material.dart';

class OfflineInspectionResponse {
  String? condition;
  String? message;
  String? code;
  String? productionCenterLoc;
  String? plantingDate;
  String? dateOfHarvest;
  String? seasonCode;
  String? seasonName;
  String? organizerCode;
  String? organizerName;
  OrganizerDetail? organizerDetail;
  int? lineNo;
  String? growerOwnerCode;
  String? growerLandOwnerName;
  GrowerDetail? growerDetail;
  String? cropCode;
  String? varietyCode;
  String? itemProductGroupCode;
  String? itemClassOfSeeds;
  String? itemCropType;
  String? itemNo;
  String? itemName;
  String? sowingDateMale;
  String? sowingDateFemale;
  String? sowingDateOther;
  double? sowingAreaInAcres;
  String? productionLotNo;
  double? standingAcres;
  double? pldAcre;
  double? netAcre;
  String? pldReason;
  int? isOffline;
  List<InspectionDetail>? inspectionDetail;

  OfflineInspectionResponse(
      {this.condition,
        this.message,
        this.code,
        this.productionCenterLoc,
        this.plantingDate,
        this.dateOfHarvest,
        this.seasonCode,
        this.seasonName,
        this.organizerCode,
        this.organizerName,
        this.organizerDetail,
        this.lineNo,
        this.growerOwnerCode,
        this.growerLandOwnerName,
        this.growerDetail,
        this.cropCode,
        this.varietyCode,
        this.itemProductGroupCode,
        this.itemClassOfSeeds,
        this.itemCropType,
        this.itemNo,
        this.itemName,
        this.sowingDateMale,
        this.sowingDateFemale,
        this.sowingDateOther,
        this.sowingAreaInAcres,
        this.productionLotNo,
        this.standingAcres,
        this.pldAcre,
        this.netAcre,
        this.pldReason,
        this.isOffline,
        this.inspectionDetail
      }
      );

  OfflineInspectionResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    code = json['code'];
    productionCenterLoc = json['production_center_loc'];
    plantingDate = json['planting_date'];
    dateOfHarvest = json['date_of_harvest'];
    seasonCode = json['season_code'];
    seasonName = json['season_name'];
    organizerCode = json['organizer_code'];
    organizerName = json['organizer_name'];
    organizerDetail = json['organizer_detail'] != null
        ? new OrganizerDetail.fromJson(json['organizer_detail'])
        : null;
    lineNo = json['line_no'];
    growerOwnerCode = json['grower_owner_code'];
    growerLandOwnerName = json['grower_land_owner_name'];
    growerDetail = json['grower_detail'] != null
        ? new GrowerDetail.fromJson(json['grower_detail'])
        : null;
    cropCode = json['crop_code'];
    varietyCode = json['variety_code'];
    itemProductGroupCode = json['item_product_group_code'];
    itemClassOfSeeds = json['item_class_of_seeds'];
    itemCropType = json['item_crop_type'];
    itemNo = json['item_no'];
    itemName = json['item_name'];
    sowingDateMale = json['sowing_date_male'];
    sowingDateFemale = json['sowing_date_female'];
    sowingDateOther = json['sowing_date_other'];
    sowingAreaInAcres = json['sowing_area_In_acres'];
    productionLotNo = json['production_lot_no'];
    standingAcres = json['standing_acres'];
    pldAcre = json['pld_acre'];
    netAcre = json['net_acre'];
    pldReason = json['pld_reason'];
    if (json['inspection_detail'] != null) {
      inspectionDetail = <InspectionDetail>[];
      json['inspection_detail'].forEach((v) {
        inspectionDetail!.add(new InspectionDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['code'] = this.code;
    data['production_center_loc'] = this.productionCenterLoc;
    data['planting_date'] = this.plantingDate;
    data['date_of_harvest'] = this.dateOfHarvest;
    data['season_code'] = this.seasonCode;
    data['season_name'] = this.seasonName;
    data['organizer_code'] = this.organizerCode;
    data['organizer_name'] = this.organizerName;
    if (this.organizerDetail != null) {
      data['organizer_detail'] = this.organizerDetail!.toJson();
    }
    data['line_no'] = this.lineNo;
    data['grower_owner_code'] = this.growerOwnerCode;
    data['grower_land_owner_name'] = this.growerLandOwnerName;
    if (this.growerDetail != null) {
      data['grower_detail'] = this.growerDetail!.toJson();
    }
    data['crop_code'] = this.cropCode;
    data['variety_code'] = this.varietyCode;
    data['item_product_group_code'] = this.itemProductGroupCode;
    data['item_class_of_seeds'] = this.itemClassOfSeeds;
    data['item_crop_type'] = this.itemCropType;
    data['item_no'] = this.itemNo;
    data['item_name'] = this.itemName;
    data['sowing_date_male'] = this.sowingDateMale;
    data['sowing_date_female'] = this.sowingDateFemale;
    data['sowing_date_other'] = this.sowingDateOther;
    data['sowing_area_In_acres'] = this.sowingAreaInAcres;
    data['production_lot_no'] = this.productionLotNo;
    data['standing_acres'] = this.standingAcres;
    data['pld_acre'] = this.pldAcre;
    data['net_acre'] = this.netAcre;
    data['pld_reason'] = this.pldReason;
    //data['is_offline'] = this.isOffline;
    if (this.inspectionDetail != null) {
      data['inspection_detail'] =
          this.inspectionDetail!.map((v) => v.toJson()).toList();
    }
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

class GrowerDetail {
  String? address;
  String? address2;
  String? postCode;
  String? stateCode;
  String? stateName;
  String? countryCode;
  String? countryName;
  String? phoneNo;
  String? mobileNo;

  GrowerDetail(
      {this.address,
        this.address2,
        this.postCode,
        this.stateCode,
        this.stateName,
        this.countryCode,
        this.countryName,
        this.phoneNo,
        this.mobileNo});

  GrowerDetail.fromJson(Map<String, dynamic> json) {
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

class InspectionDetail {
  String? plantingNo;
  int? lineNo;
  int? inspectionTypeId;
  String? inspectionTypeName;
  String? productionLotNo;
  int? isQc;
  int? isDone;
  String? completedOn;
  String? completedBy;
  List<Fields>? fields;

  InspectionDetail(
      {this.plantingNo,
        this.lineNo,
        this.inspectionTypeId,
        this.inspectionTypeName,
        this.productionLotNo,
        this.isQc,
        this.isDone,
        this.completedOn,
        this.completedBy,
        this.fields});

  InspectionDetail.fromJson(Map<String, dynamic> json) {
    plantingNo = json['planting_no'];
    lineNo = json['line_no'];
    inspectionTypeId = json['inspection_type_id'];
    inspectionTypeName = json['inspection_type_name'];
    productionLotNo = json['production_lot_no'];
    isQc = json['is_qc'];
    isDone = json['is_done'];
    completedOn = json['completed_on'];
    completedBy = json['completed_by'];
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(new Fields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['planting_no'] = this.plantingNo;
    data['line_no'] = this.lineNo;
    data['inspection_type_id'] = this.inspectionTypeId;
    data['inspection_type_name'] = this.inspectionTypeName;
    data['production_lot_no'] = this.productionLotNo;
    data['is_qc'] = this.isQc;
    data['is_done'] = this.isDone;
    data['completed_on'] = this.completedOn;
    data['completed_by'] = this.completedBy;
    if (this.fields != null) {
      data['fields'] = this.fields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fields {
  String? plantingNo;
  int? lineNo;
  String? productionLotNo;
  int? inspectionTypeId;
  String? inspectionType;
  int? inspectionFieldId;
  String? fieldName;
  String? fieldType;
  String? fieldOptionValue;
  int? isMandatory;
  int? isPlantingField;
  int? isReadOnly;
  int? isMap;
  String? mapInspectionType;
  String? mapInspectionFieldName;
  int? isFormula;
  List<IsVisibleExpression>? isVisibleExpression;
  String? fieldValue;
  List<FormulaExperession>? formulaExperession;
  TextEditingController? edit_text_field;

  Fields(
      {this.plantingNo,
        this.lineNo,
        this.productionLotNo,
        this.inspectionTypeId,
        this.inspectionType,
        this.inspectionFieldId,
        this.fieldName,
        this.fieldType,
        this.fieldOptionValue,
        this.isMandatory,
        this.isPlantingField,
        this.isReadOnly,
        this.isMap,
        this.mapInspectionType,
        this.mapInspectionFieldName,
        this.isFormula,
        this.formulaExperession,
        this.isVisibleExpression,
        this.fieldValue,
        this.edit_text_field
      });

  Fields.fromJson(Map<String, dynamic> json) {
    plantingNo = json['planting_no'];
    lineNo = json['line_no'];
    productionLotNo = json['production_lot_no'];
    inspectionTypeId = json['inspection_type_id'];
    inspectionType = json['inspection_type'];
    inspectionFieldId = json['inspection_field_id'];
    fieldName = json['field_name'];
    fieldType = json['field_type'];
    fieldOptionValue = json['field_option_value'];
    isMandatory = json['is_mandatory'];
    isPlantingField = json['is_planting_field'];
    isReadOnly = json['is_read_only'];
    isMap = json['is_map'];
    mapInspectionType = json['map_inspection_type'];
    mapInspectionFieldName = json['map_inspection_field_name'];
    isFormula = json['is_formula'];
    if (json['formula_experession'] != null) {
      formulaExperession = <FormulaExperession>[];
      json['formula_experession'].forEach((v) {
        formulaExperession!.add(new FormulaExperession.fromJson(v));
      });
    }
    if (json['is_visible_expression'] != null) {
      isVisibleExpression = <IsVisibleExpression>[];
      json['is_visible_expression'].forEach((v) {
        isVisibleExpression!.add(new IsVisibleExpression.fromJson(v));
      });
    }
    fieldValue = json['field_value'];
    edit_text_field=null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['planting_no'] = this.plantingNo;
    data['line_no'] = this.lineNo;
    data['production_lot_no'] = this.productionLotNo;
    data['inspection_type_id'] = this.inspectionTypeId;
    data['inspection_type'] = this.inspectionType;
    data['inspection_field_id'] = this.inspectionFieldId;
    data['field_name'] = this.fieldName;
    data['field_type'] = this.fieldType;
    data['field_option_value'] = this.fieldOptionValue;
    data['is_mandatory'] = this.isMandatory;
    data['is_planting_field'] = this.isPlantingField;
    data['is_read_only'] = this.isReadOnly;
    data['is_map'] = this.isMap;
    data['map_inspection_type'] = this.mapInspectionType;
    data['map_inspection_field_name'] = this.mapInspectionFieldName;
    data['is_formula'] = this.isFormula;
    if (this.formulaExperession != null) {
      data['formula_experession'] =
          this.formulaExperession!.map((v) => v.toJson()).toList();
    }
    if (this.isVisibleExpression != null) {
      data['is_visible_expression'] =
          this.isVisibleExpression!.map((v) => v.toJson()).toList();
    }
    data['field_value'] = this.fieldValue;
    return data;
  }
}

class FormulaExperession {
  int? id;
  String? fieldName;
  int? isOprator;
  String? fieldValue;

  FormulaExperession(
      {this.id, this.fieldName, this.isOprator, this.fieldValue});

  FormulaExperession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldName = json['field_name'];
    isOprator = json['is_oprator'];
    fieldValue = json['field_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['field_name'] = this.fieldName;
    data['is_oprator'] = this.isOprator;
    data['field_value'] = this.fieldValue;
    return data;
  }
}
class IsVisibleExpression {
  int? id;
  String? fieldName;
  int? isOprator;
  String? fieldValue;

  IsVisibleExpression(
      {this.id, this.fieldName, this.isOprator, this.fieldValue});

  IsVisibleExpression.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldName = json['field_name'];
    isOprator = json['is_oprator'];
    fieldValue = json['field_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['field_name'] = this.fieldName;
    data['is_oprator'] = this.isOprator;
    data['field_value'] = this.fieldValue;
    return data;
  }
}

