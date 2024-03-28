import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../local_database/inspection/OnlineInspectionDatabase.dart';
import '../../models/common_api_response.dart';
import '../../models/online_inspection_model/OfflineInspectionResponse.dart';
import '../../repository/online_inspection_repositry/OnlineInspectionrepository.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';

class OfflineInspectionViewModel extends GetxController {
  final _api = OnlineOfflineInspectionRepository();
  SessionManagement sessionManagement = SessionManagement();
  RxList<OfflineInspectionResponse> onlineOfflineList = <OfflineInspectionResponse>[].obs;

  RxString completed_inspection = ''.obs;
  Rx<OfflineInspectionResponse> onlineOffline_selected_lot_data = new OfflineInspectionResponse().obs;
  Rx<InspectionDetail> online_offline_selected_inspection = new InspectionDetail().obs;
  final OnlineInspectionDatabase _database = OnlineInspectionDatabase();
  RxBool loading = false.obs;
  RxBool isDone = false.obs;
  final RxString email = ''.obs;
  RxString main_list_refress=''.obs;
  RxString selected_code = ''.obs;
  RxString selected_lot = ''.obs;

  final ImagePicker _picker = ImagePicker();

  //todo for capture image ........
  Future captureImage(int position) async {
    // final image=await _picker.getImage(source: ImageSource.camera,maxHeight:50,maxWidth:50,imageQuality: 80);
    var image = null;
    try {
      image = await _picker.pickImage(
          source: ImageSource.camera, maxHeight:50,maxWidth:50,imageQuality: 50);
      if (image != null) {
        // todo Convert image to base64
        List<int> imageBytes = await image.readAsBytes();
        online_offline_selected_inspection.value.fields![position].fieldValue = base64Encode(imageBytes);
        //todo refreshing ui...
        InspectionDetail all_inspection_detail=InspectionDetail();
        all_inspection_detail=[...[online_offline_selected_inspection.value]][0];
        online_offline_selected_inspection.value=InspectionDetail();
        online_offline_selected_inspection.value=all_inspection_detail;
      } else {
        Utils.sanckBarError(
            "Image Error!", "You have not select any image");
      }

    } catch (e) {
      Utils.sanckBarError("Image Exception!", e.toString());
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    email.value = await sessionManagement.getEmail() ?? '';
    syncOfflineDataPushToApiAfterThatGetData('');
  }

  Future<void> syncOfflineDataPushToApiAfterThatGetData(String flag) async {

    bool isConnected = await StaticMethod.checkInternetConnectivity();
    if (isConnected) {
      loading.value = true;
      List<OfflineInspectionResponse> alloffline_lot_list = await _database.getAllOfflineInspectionCompleteData();
        List<Map<String, dynamic>> hit_payload = [];

        if(alloffline_lot_list.length>0){
          for (int i = 0; i < alloffline_lot_list.length; i++) {
            List<InspectionDetail>? inspectionDetail =alloffline_lot_list[i].inspectionDetail!.where((element) => element.isDone!>0).toList();
            for (int j = 0;
            j < inspectionDetail!.length;
            j++) {
              List<Map<String, String>> data_line = [];
              for (int k = 0;
              k < inspectionDetail![j].fields!.length;
              k++) {
                data_line.add({
                  "inspection_type_id": (inspectionDetail![j].fields![k].inspectionTypeId ??
                      '')
                      .toString(),
                  "inspection_type": inspectionDetail![j].fields![k].inspectionType ??
                      '',
                  "inspection_field_id": (inspectionDetail![j].fields![k].inspectionFieldId ??
                      '')
                      .toString(),
                  "field_name":inspectionDetail![j].fields![k].fieldName ??
                      '',
                  "field_value": inspectionDetail![j].fields![k].fieldValue ??
                      ''
                });
              }

              hit_payload.add({
                "inspection_flag": "Offline",
                "planting_no":
                inspectionDetail![j]!.plantingNo ?? '',
                "line_no": (inspectionDetail![j]!.lineNo ?? '')
                    .toString(),
                "inspection_type_id":
                (inspectionDetail![j]!.inspectionTypeId ??
                    '')
                    .toString(),
                "inspection_type_name":
                inspectionDetail![j]!.inspectionTypeName ??
                    '',
                "production_lot_no":
                inspectionDetail![j]!.productionLotNo ?? '',
                "email_id": email.value,
                "fields": data_line
              });
            }
          }

          _api.inspectionComplete(hit_payload, sessionManagement).then((value) async {
            try {
              final jsonResponse = json.decode(value);
              if (jsonResponse is List) {
                List<CommaonApiModel> response = jsonResponse
                    .map((data) => CommaonApiModel.fromJson(data))
                    .toList();
                if (response != null && response.length > 0 && response[0].condition.toString() == "True") {

                  loading.value = false;
                  Utils.sanckBarSuccess('Message True!', response[0].message.toString());

                  //delete offline data
                  int result = await _database.deleteAllOfflineInspectionData();

                  if (result <= 0)
                    Utils.sanckBarSuccess('Offline Inspection Delete Error', "Offline Inspection Data Not Delete After Sync To Api.");
                   getAllOfflineDatafromTable(flag);

                }
                else {
                  //Utils.sanckBarError('Message False!', response[0].message.toString());
                  loading.value = false;
                }
              }
            } catch (e) {
              Utils.sanckBarError('Message Exception!', e.toString());
              loading.value = false;
            }
          }).onError((error, stackTrace) {
            Utils.sanckBarError('Api Exception onError', error.toString());
            print(error);
          }).whenComplete(() {
            loading.value = false;
            //getOfflineInspectionFromApi();

          });
        }
        else{
          getOfflineInspectionFromApi(flag);
        }
    }
    else {
      getAllOfflineDatafromTable(flag);
    }
  }

  getOfflineInspectionFromApi(String flag) {
    onlineOfflineList.clear();

    loading.value = true;
    Map data = {"email_id": email.value};
    _api.inspectionProductionLotGetoffline(data, sessionManagement).then((value) async {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          print('res...'+jsonResponse.toString());
          List<OfflineInspectionResponse> response = jsonResponse.map((data) => OfflineInspectionResponse.fromJson(data))
              .toList();
          if (response != null && response.length > 0 && response[0].condition.toString() == "True") {
            loading.value = false;
            int result = await insertOnlineInspectionDataList(response);
            if (result <= 0) {
              Utils.sanckBarError("Inspection Insert", "Data Not Insert Into Tabel.");
              return;
            }
            onlineOfflineList.value = response;
          }
          else {
           // Utils.sanckBarError('Message False!', response[0].message.toString());
            loading.value = false;
            onlineOfflineList.value = [];
          }
        }
      } catch (e) {
        Utils.sanckBarError('Message Exception!', e.toString());
        print(e);
        loading.value = false;
        onlineOfflineList.value = [];
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('Api Exception onError', error.toString());
    }).whenComplete(() {
      loading.value = false;
      if(flag=='OfflineLotDetail'){
        Get.offAllNamed(RoutesName.offlineInspection);
      }
    });
  }

  //todo insert data into local database................
  Future<int> insertOnlineInspectionDataList(List<OfflineInspectionResponse> dataList) async {
    return await _database.insertOnlineInspectionDataList(dataList);
  }

  //todo get data from local database...............
  Future<void> getAllOfflineDatafromTable(String flag) async {
    try {
      List<OfflineInspectionResponse> dataList =
          await _database.getAllOfflineData();
      if (dataList != null && dataList.length > 0) {
        onlineOfflineList.value = dataList;

      } else {
        //Utils.sanckBarError('Local Data', 'No Record Found');
      }
    } catch (e) {
      print(e);
    }
    finally{
      if(flag=='OfflineLotDetail'){
        Get.offAllNamed(RoutesName.offlineInspection);
      }
    }
  }

  //todo get particular  production lot data from table...........
  Future<void> getProductionLotDataFromTable(String code, String lot_no) async {
      try {
        List<OfflineInspectionResponse> dataList =
            await _database.getProductionLotData(code, lot_no);

        if (dataList.length <= 0) {
          Utils.sanckBarError("Inspection Lot Selection", "Selected Lot Data Not Found.");
          return;
        }
        if (dataList != null && dataList.length > 0) {
          onlineOffline_selected_lot_data.value = dataList[0];
          Get.toNamed(RoutesName.lotDetailScreen);
        }
      } catch (e) {
        print(e);
      }
  }

  Future<void> completeOnlineInspection() async {

    bool isConnected = await StaticMethod.checkInternetConnectivity();

    if (isConnected) {
      loading.value = true;
      List<Map<String, String>> data_line = [];
      for (int i = 0; i < online_offline_selected_inspection.value.fields!.length; i++) {
        data_line.add({
          "inspection_type_id": (online_offline_selected_inspection
                      .value.fields![i].inspectionTypeId ??
                  '')
              .toString(),
          "inspection_type": online_offline_selected_inspection
                  .value.fields![i].inspectionType ??
              '',
          "inspection_field_id": (online_offline_selected_inspection
                      .value.fields![i].inspectionFieldId ??
                  '')
              .toString(),
          "field_name":
              online_offline_selected_inspection.value.fields![i].fieldName ??
                  '',
          "field_value":
              online_offline_selected_inspection.value.fields![i].fieldValue ??
                  ''
        });
      }
      List<Map<String, dynamic>> hit_payload = [
        {
          "inspection_flag": "online",
          "planting_no":
              online_offline_selected_inspection.value!.plantingNo ?? '',
          "line_no": (online_offline_selected_inspection.value.lineNo ?? '')
              .toString(),
          "inspection_type_id":
              (online_offline_selected_inspection.value.inspectionTypeId ?? '')
                  .toString(),
          "inspection_type_name":
              online_offline_selected_inspection.value.inspectionTypeName ?? '',
          "production_lot_no":
              online_offline_selected_inspection.value.productionLotNo ?? '',
          "email_id": email.value,
          "fields": data_line
        }
      ];
       _api.inspectionComplete(hit_payload, sessionManagement).then((value) {
        try {
          final jsonResponse = json.decode(value);
          if (jsonResponse is List) {
            List<CommaonApiModel> response = jsonResponse
                .map((data) => CommaonApiModel.fromJson(data))
                .toList();
            if (response != null &&
                response.length > 0 &&
                response[0].condition.toString() == "True") {
              loading.value = false;
              Utils.sanckBarSuccess('Message True!', response[0].message.toString());
              offlineInspectionComplte(0);
            } else {
              Utils.sanckBarError(
                  'Message False!', response[0].message.toString());
              loading.value = false;
            }
          }
        } catch (e) {
          Utils.sanckBarError('Message Exception!', e.toString());
          loading.value = false;
        }
      }).onError((error, stackTrace) {
        Utils.sanckBarError('Api Exception onError', error.toString());
        print(error);
      }).whenComplete(() {
        loading.value = false;
      });
    }
    else {
      Fields mandatory_field=online_offline_selected_inspection.value.fields!.firstWhere((element) => element.isMandatory!>0 && (element.fieldValue==null||element.fieldValue==''));
      if(mandatory_field!=null && (mandatory_field.fieldValue==null || mandatory_field.fieldValue=='')){
         Utils.sanckBarError("Error!", 'Field name ${mandatory_field.fieldName} is mandatory so,it can not be null or blank.');
         return;
      }
      offlineInspectionComplte(1);
    }
  }

  Future<void> offlineInspectionComplte( int is_offline) async {
      for (var element
          in onlineOffline_selected_lot_data.value.inspectionDetail!) {
        if (element.inspectionTypeName ==
            online_offline_selected_inspection.value.inspectionTypeName) {
          online_offline_selected_inspection.value.isDone = 1;
          online_offline_selected_inspection.value.completedBy = email.value;
          element = online_offline_selected_inspection.value;
          break;
        }
      }

      int result = await _database.updateOfflineInspection(
          onlineOffline_selected_lot_data.value.inspectionDetail!,
          onlineOffline_selected_lot_data.value.code!,
          onlineOffline_selected_lot_data.value.productionLotNo!,
          1);
      if (result <= 0) {
        Utils.sanckBarError("Inspection Complete Update", "Error In Inspection Completetion.");
      }
    getProductionLotDataFromTable(online_offline_selected_inspection.value.plantingNo!, online_offline_selected_inspection.value.productionLotNo!);
  }
  
  Future<void> showLotDetailsBottomSheet(BuildContext context) async {
    Size size = Get.size;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      "Lot Details",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Icon(Icons.cancel,color: AllColors.primaryDark1,),
                    ),
                  )
                ],
              ),
            ),
            
            Center(child: Divider(height: 1,color: AllColors.primaryDark1,)),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table(
                        children: [
                          TableRow(
                            children: [
                              Text(
                                'Production Lot No:',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                width: size.width * .5,
                                child: Tooltip(
                                  message: onlineOffline_selected_lot_data
                                      .value.productionLotNo
                                      .toString(),
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    '${onlineOfflineList[0].productionLotNo.toString()}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                'Organizer Name:',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                width: size.width * .5,
                                child: Tooltip(
                                  message: onlineOffline_selected_lot_data
                                      .value.organizerName
                                      .toString(),
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    '${onlineOfflineList[0].organizerName.toString()}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                'Crop Code:',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '${onlineOffline_selected_lot_data.value.cropCode.toString()}',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                'Variety Code:',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                width: size.width * .5,
                                child: Tooltip(
                                  message: onlineOffline_selected_lot_data
                                      .value.varietyCode
                                      .toString(),
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    '${onlineOfflineList[0].varietyCode.toString()}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                         /* TableRow(
                            children: [
                              Text(
                                'Sowing.Date.Male:',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                width:size.width*.5,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 28.0),
                                  child: Text(
                                    '${onlineOffline_selected_lot_data.value.sowingDateMale.toString()}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                              children: [Text(
                              'Sowing.Date.Female:',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Text(
                                  '${onlineOffline_selected_lot_data.value.sowingDateFemale.toString()}',
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ]),*/
                        ],
                      ),
                      Column(
                        children: [
                          Visibility(
                            visible: onlineOffline_selected_lot_data.value.sowingDateMale!=null ?true:false,
                            child: Column(children: [
                              Row(
                                children: [
                                  Text(
                                    'Sowing.Date.Male:',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    width: size.width*.5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 30.0),
                                      child: Text(
                                        ' ${onlineOffline_selected_lot_data.value.sowingDateMale.toString()}',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Sowing.Date.Female:',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    width: size.width*.5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 14.0),
                                      child: Text(
                                        '${onlineOffline_selected_lot_data.value.sowingDateFemale.toString()}',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ]),
                          ),
                          Visibility(
                            visible: onlineOffline_selected_lot_data.value.sowingDateOther!=null?true:false,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sowing.Date.Other:',
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  width: size.width*.5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      '${onlineOffline_selected_lot_data.value.sowingDateOther.toString()}',
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        //height: 350,
                        //width: 400,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Grower Details',
                            labelStyle: GoogleFonts.poppins(
                                color: AllColors.blackColor,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.twentee
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: AllColors.primaryliteColor),
                            ),
                            border: OutlineInputBorder(
                      
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Table(
                                children: [
                                  TableRow(
                                    children: [
                                      Text(
                                        'Address:',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        width: size.width * .5,
                                        child: Tooltip(
                                          message: onlineOffline_selected_lot_data
                                              .value.growerDetail!.address??'',

                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            '${onlineOffline_selected_lot_data
                                                .value.growerDetail!.address??''}',
                                            style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text(
                                        'State Code:',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        onlineOffline_selected_lot_data.value.growerDetail!.stateCode??'',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text(
                                        'State Name:',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        width: size.width * .5,
                                        child: Tooltip(
                                          message: onlineOffline_selected_lot_data
                                              .value.varietyCode
                                              .toString(),
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            '${onlineOffline_selected_lot_data.value.growerDetail!.stateName??''}',
                                            style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text(
                                        'Mobile No:',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '${onlineOffline_selected_lot_data.value.growerDetail!.mobileNo??''}',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        //height: 350,
                        //width: 400,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Organizer Details',
                            labelStyle: GoogleFonts.poppins(
                                color: AllColors.blackColor,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.twentee
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: AllColors.primaryliteColor),
                            ),
                            border: OutlineInputBorder(
                      
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Table(
                                children: [
                                  TableRow(
                                    children: [
                                      Text(
                                        'Address:',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        width: size.width * .5,
                                        child: Tooltip(
                                          message: onlineOffline_selected_lot_data
                                              .value.growerDetail!.address??'',

                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            '${onlineOffline_selected_lot_data
                                                .value.organizerDetail!.address??''}',
                                            style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text(
                                        'State Code:',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        onlineOffline_selected_lot_data.value.organizerDetail!.stateCode??'',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text(
                                        'State Name:',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        width: size.width * .5,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          '${onlineOffline_selected_lot_data.value.organizerDetail!.stateName??''}',
                                          style: GoogleFonts.poppins(
                                              color: AllColors.primaryDark1,
                                              fontSize: AllFontSize.fourtine,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text(
                                        'Mobile No:',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '${onlineOffline_selected_lot_data.value.organizerDetail!.mobileNo??''}',
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> moveToOnlineAllOfflineData()async{
    bool isConnected = await StaticMethod.checkInternetConnectivity();
    if (isConnected) {
      List<OfflineInspectionResponse> alloffline_lot_list = await _database.getAllOfflineInspectionCompleteData();
      if(alloffline_lot_list!=null && alloffline_lot_list.length>0){
          Utils.sanckBarError('Move To Online!', 'Please Complete Offline All Lots, Then Move To Online.');
          return;
      }
      loading.value = true;
      Map data = {
        "email_id": email.value
      };
        _api.inspectionMoveToOnline(data, sessionManagement).then((value) async {
          try {
            final jsonResponse = json.decode(value);
            if (jsonResponse is List) {
              List<CommaonApiModel> response = jsonResponse.map((data) => CommaonApiModel.fromJson(data)).toList();
              if (response != null && response.length > 0 && response[0].condition.toString() == "True") {
                loading.value = false;
                Utils.sanckBarSuccess('Message True!', response[0].message.toString());
                // todo for delete offline data
                int result = await _database.deleteAllInspectionData();
               if(result>0){
                 syncOfflineDataPushToApiAfterThatGetData('');
               }
              }
              else {
                Utils.sanckBarError('Message False!', response[0].message.toString());
                loading.value = false;
              }
            }
          } catch (e) {
            Utils.sanckBarError('Message Exception!', e.toString());
            loading.value = false;
          }
        }).onError((error, stackTrace) {
          Utils.sanckBarError('Api Exception onError', error.toString());
          print(error);
        }).whenComplete(() {
          loading.value = false;
        });
      }
    else{
      Utils.sanckBarError('Internet Connection!', 'No Internet Connection Available.');
    }
  }

  Future<void> getFormulaExpressionValues() async {
    try {
      for (int i = 0; i <
          online_offline_selected_inspection.value.fields!.length; i++) {
        String field_type = online_offline_selected_inspection.value.fields![i]
            .fieldType!.toString();
        int is_formula = online_offline_selected_inspection.value.fields![i]
            .isFormula!;
        if (field_type == 'Numeric' && is_formula > 0)
          calulateFieldVisibleListData(
              online_offline_selected_inspection.value.fields![i]!);
      }
    }catch(e){
      print("error..."+e.toString());
    }
  }

  //todo calculate field
  Future<void> calulateFieldVisibleListData(Fields field)async {
    List<Fields>?  field_list=online_offline_selected_inspection.value.fields;
    var expression_string_valye = '';
    try {
      for (int i = 0; i < field.formulaExperession!.length; i++) {
        if (field.formulaExperession![i].isOprator! > 0) continue;
        Fields filter_field= field_list!.firstWhere((element) => element.fieldName==field.formulaExperession![i].fieldName);
        if(filter_field!=null && filter_field.fieldName!=null){
          double field_value = 0;
          field_value = double.tryParse(filter_field.fieldValue!) ?? 0;
          field.formulaExperession![i].fieldValue = field_value.toString();
        }
      }

      expression_string_valye = field.formulaExperession!
          .map((item) =>
      item.isOprator! > 0 ? item.fieldName! : item.fieldValue.toString())
          .join();
      field.fieldValue= '${expression_string_valye.interpret()}';
    } catch (e) {
      print("error..."+e.toString());
      field.fieldValue="0";
    }
    finally{
      InspectionDetail all_inspection_detail=InspectionDetail();
      all_inspection_detail=[...[online_offline_selected_inspection.value]][0];
      online_offline_selected_inspection.value=InspectionDetail();
      online_offline_selected_inspection.value=all_inspection_detail;
    }
  }

}


