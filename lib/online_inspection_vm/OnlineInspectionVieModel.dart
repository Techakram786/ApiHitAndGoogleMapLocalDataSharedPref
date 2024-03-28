import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/repository/online_inspection_repositry/OnlineInspectionrepository.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../current_location/current_location.dart';
import '../../models/common_api_response.dart';
import '../../models/online_inspection_model/OfflineInspectionResponse.dart';
import '../../models/online_inspection_model/OnlineInspectionResponse.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';
import 'package:function_tree/function_tree.dart';
class OnlineInspectionViewModel extends GetxController{
  final _api =OnlineOfflineInspectionRepository();
  SessionManagement sessionManagement = SessionManagement();
  LocationData locationData = LocationData();
  double from_latitude = 0.0; // Variable to store latitude
  double from_longitude = 0.0;
  final RxString email=''.obs;
  RxString inspection_name=''.obs;
  RxBool loading = false.obs;
  RxBool isLocationChecked=false.obs;
  RxString current_date = "".obs;
  Size size = Get.size;

  RxInt selectedRadio = 0.obs;

  String radio_select='';

  var planting_no_Controller =TextEditingController();
  var prod_center_loc_Controller =TextEditingController();
  var season_Controller =TextEditingController();
  var orgnizer_Controller =TextEditingController();
  var date_Controller =TextEditingController();
  RxList<OnlineinspectionResponse> selected = <OnlineinspectionResponse>[].obs;

  ScrollController scrollController = ScrollController();
  int pageNumber=0;
  int rowsPerPage=50;
  int total_rows=0;
  RxString completed_inspection = ''.obs;
  RxString selected_code = ''.obs;
  RxString selected_lot = ''.obs;
  RxBool isLocationSelect=false.obs;
  RxBool isLotSelect=true.obs;

  //todo api response list...
  RxList<OnlineinspectionResponse> onlineInspectionList = <OnlineinspectionResponse>[].obs;

  Rx<OfflineInspectionResponse> onlineOffline_selected_lot_data = new OfflineInspectionResponse().obs;
  Rx<InspectionDetail> online_offline_selected_inspection = new InspectionDetail().obs;

  RxList<OnlineinspectionResponse> moveToOfflineList = <OnlineinspectionResponse>[].obs;
  final ImagePicker _picker = ImagePicker();

  //todo for capture image ........
  Future captureImage(int position) async {
    // final image=await _picker.getImage(source: ImageSource.camera,maxHeight:50,maxWidth:50,imageQuality: 80);
    var image = null;
    try {
        image = await _picker.pickImage(
            source: ImageSource.camera, maxHeight:500,maxWidth:500,imageQuality: 70);
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

//todo checkbox indexex select variable...
  var checkBoxValues = <int, bool>{}.obs;
//todo chip button visible function...
   get isAnyCheckboxSelected {
    return checkBoxValues.values.any((value) => value == true);
  }

  RxList<OnlineinspectionResponse> selectedItems = <OnlineinspectionResponse>[].obs;

  void toggleCheckbox(int index) {
    final bool isChecked = checkBoxValues[index] ?? false;
    if (isChecked) {
      selectedItems.remove(onlineInspectionList[index]);
      checkBoxValues[index] = false;
    } else {
      if (!selectedItems.contains(onlineInspectionList[index])) {
        selectedItems.add(onlineInspectionList[index]);
        checkBoxValues[index] = true;
      }
    }
  }

  void onLocationChanged(bool value) {
     isLocationChecked.value = value;
    if (isLocationChecked.value==true) {
      locationData.getCurrentLocation();
      from_latitude=locationData.latitude;
      from_longitude=locationData.longitude;
    }

  }
  void setSelectedRadio(int value) {
    selectedRadio.value = value;
    if(selectedRadio.value==0){
      radio_select=selectedRadio.value.toString();
    }else{
      radio_select=email.value;
    }
  }

  @override
  Future<void> onInit()  async {
    super.onInit();
    current_date.value=await StaticMethod.getCurrentData();
    date_Controller.text=current_date.value;
    email.value=await sessionManagement.getEmail() ?? '';
    getOnlineInspection(pageNumber,'');
    /*scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int total_page = (total_rows / rowsPerPage).ceil(); // Use ceil to round up
        if (pageNumber + 1 <= total_page) {
            getOnlineInspection(pageNumber + 1,'');
            pageNumber += 1;
        }
        else{
          print(onlineInspectionList[0].message.toString());
        }
      }
    });*/
  }

  getOnlineInspection(int page_no,String flag)async {
    bool isConnected = await StaticMethod.checkInternetConnectivity();
    if(isConnected){
      loading.value = true;
      Map data = {
        'android_latitude':from_latitude.toString(),
        'android_longitude':from_longitude.toString(),
        'filter_email_id': isLotSelect.value==true?email.value:'',
        "date_filter": current_date.value,
        'planting_no': planting_no_Controller.text,
        'production_center_loc':prod_center_loc_Controller.text,
        'season': season_Controller.text,
        'organizer': orgnizer_Controller.text,
        'rowsPerPage':rowsPerPage.toString(),
        'pageNumber': page_no.toString(),
        'email_id': email.value,
      };
      _api.inspectionProductionLotGetOnline(data, sessionManagement).then((value) {
        try {
          final jsonResponse = json.decode(value);
          if (jsonResponse is List) {
            List<OnlineinspectionResponse> response =
            jsonResponse.map((data) => OnlineinspectionResponse.fromJson(data)).toList();
            if (response!=null && response.length>0 && response[0].condition.toString() == "True") {
              loading.value = false;
              if(page_no==0){
                onlineInspectionList.clear();
              }
              //onlineInspectionList.value=response;
              onlineInspectionList.addAll(response);
              total_rows=int.parse(response[0].totalRows!);
              if(flag=='OnLineLotDetail'){
                Get.offAllNamed(RoutesName.onlineInspaction);
              }
            }
            else {
              Utils.sanckBarError('Message False!', response[0].message.toString());
              loading.value = false;
              onlineInspectionList.value = [];
            }
          }
        } catch (e) {
          Utils.sanckBarError('Message Exception!', e.toString());
          print(e.toString());
        }
      }).onError((error, stackTrace) {
        Utils.sanckBarError('Api Exception onError', error.toString());
      }).whenComplete(()  {
        loading.value = false;
      });
    }
    else{
      Utils.sanckBarError('Internet Checking...!','No Internet Connection Available,Please Check Your Internet Connection!');
    }
  }

  Future<void> movetoOffline() async {
    bool isConnected = await StaticMethod.checkInternetConnectivity();
    if(isConnected) {
      loading.value = true;
      List<Map<String, String>> data = [];
      for (var list in selectedItems) {
        data.add({
          'email_id': email.value,
          'production_lot_no': list.productionLotNo.toString(),
          'planting_no': list.plantingNo.toString(),
        });
      }
      await _api.inspectionMoveToOffline(data, sessionManagement).then((value) {
        try {
          final jsonResponse = json.decode(value);
          if (jsonResponse is List) {
            List<OnlineinspectionResponse> response =
            jsonResponse.map((data) => OnlineinspectionResponse.fromJson(data))
                .toList();

            if (response != null &&
                response[0].condition.toString() == "True") {
              loading.value = false;
              moveToOfflineList.value = response;
              checkBoxValues.clear();
              selectedItems.clear();
              //updateSelectedIndexes();
              getOnlineInspection(pageNumber, '');
            } else {
              loading.value = false;
              moveToOfflineList.value = [];
              Utils.sanckBarError(
                  'Message False!', response[0].message.toString());
            }
          }
        } catch (e) {
          Utils.sanckBarError('Message Exception!', e.toString());
          print(e.toString());
        }
      }).onError((error, stackTrace) {

      }).whenComplete(() {
        loading.value = false;
      });
    }
    else{
      Utils.sanckBarError('Internet Checking...!','No Internet Connection Available,Please Check Your Internet Connection!');
    }
  }

  Future<void> getProductionLotDataFromServer(String code,String lot_no)async{
    loading.value = true;
    Map data = {
      "email_id": email.value,
      "production_lot_no": lot_no,
      "planting_no": code
    };
    _api
        .inspectionProductionLotDeatailGet(data, sessionManagement)
        .then((value) {
      try {
        final jsonResponse = json.decode(value);
        print('myresponse' + jsonResponse.toString());
        if (jsonResponse is List) {
          List<OfflineInspectionResponse> response = jsonResponse
              .map((data) => OfflineInspectionResponse.fromJson(data))
              .toList();
          if (response != null && response.length > 0 && response[0].condition.toString() == "True") {
            loading.value = false;
            onlineOffline_selected_lot_data.value = response[0];
            Get.toNamed(RoutesName.onlineLotDetailScreen);
          } else {
            Utils.sanckBarError('Message False!', response[0].condition.toString());
            loading.value = false;
          }
        }
      } catch (e) {
        print(e);
        Utils.sanckBarError('Message Exception!', e.toString());
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('Api Exception onError', error.toString());
    }).whenComplete(() {
      loading.value = false;
    });
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
                                'Production Lot No.:',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                width: size.width * .5,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  '${onlineOffline_selected_lot_data.value.productionLotNo.toString()}',
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
                                    '${onlineOffline_selected_lot_data.value.organizerName.toString()}',
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
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  '${onlineOffline_selected_lot_data.value.varietyCode.toString()}',
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),

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
                                        'Mobile No.:',
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
                                        'Mobile No.:',
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

  //todo for complete online inspection..............
  Future<void> completeOnlineInspection() async {

    bool isConnected = await StaticMethod.checkInternetConnectivity();

    if (isConnected) {
      loading.value = true;
      List<Map<String, String>> data_line = [];
      for (int i = 0;
      i < online_offline_selected_inspection.value.fields!.length;
      i++) {
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
              getProductionLotDataFromServer(selected_code.value,selected_lot.value!);
              //Get.toNamed(RoutesName.onlineLotDetailScreen);

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

  //todo for filter dialog.............................
  void showFilterBottomSheet(BuildContext context){
    date_Controller.text=current_date.value;
    isLotSelect.value=true;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure minimal height
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filter List",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return ActionChip(
                        elevation: 1,
                        tooltip: "Select Current Location",
                        avatar: Icon(Icons.location_pin, color: isLocationSelect.value ?AllColors.customDarkerWhite:AllColors.primaryDark1),
                        shape: StadiumBorder(
                            side: BorderSide(color: isLocationSelect.value ?AllColors.primaryDark1:AllColors.primaryliteColor)),
                        backgroundColor: isLocationSelect.value ? AllColors.primaryDark1 : AllColors.grayColor, // Change background color
                        label: Text('Location',
                            style: GoogleFonts.poppins(
                              color:isLocationSelect.value ? AllColors.customDarkerWhite:AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        onPressed: () {
                          isLocationSelect.value = !isLocationSelect.value;
                          onLocationChanged(isLocationSelect.value);
                        },
                      );
                    }),
                    Obx(() {
                      return ActionChip(
                        elevation: 1,
                        tooltip: "Select Owner",
                        avatar: Icon(Icons.self_improvement, color: isLotSelect.value ?AllColors.customDarkerWhite:AllColors.primaryDark1),
                        shape: StadiumBorder(
                            side: BorderSide(color: isLotSelect.value ?AllColors.primaryDark1:AllColors.primaryliteColor)),
                        backgroundColor: isLotSelect.value ? AllColors.primaryDark1 : AllColors.grayColor, // Change background color
                        label: Text('My Self',
                            style: GoogleFonts.poppins(
                              color:isLotSelect.value ? AllColors.customDarkerWhite:AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        onPressed: () {
                          isLotSelect.value = !isLotSelect.value;

                        },
                      );
                    }),
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      controller: planting_no_Controller,
                      decoration: InputDecoration(
                        labelText: 'Planting No.',
                        hintText: 'Planting No.',
                        hintStyle: GoogleFonts.poppins(
                          color: AllColors.lightblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.ten,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors.primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onChanged: (value) {
                        // Handle the text field value changes if needed
                      },
                    ),
                    TextField(
                      controller: prod_center_loc_Controller,
                      decoration: InputDecoration(
                        labelText: 'Production Loc. Centre',
                        hintText: 'Production Loc. Centre',
                        hintStyle: GoogleFonts.poppins(
                          color: AllColors.lightblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.ten,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors.primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onChanged: (value) {
                        // Handle the text field value changes if needed
                      },
                    ),
                    TextField(
                      controller: season_Controller,
                      decoration: InputDecoration(
                        labelText: 'Season',
                        hintText: 'Season',
                        hintStyle: GoogleFonts.poppins(
                          color: AllColors.lightblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.ten,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors.primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onChanged: (value) {
                        // Handle the text field value changes if needed
                      },
                    ),
                    TextField(
                      controller: orgnizer_Controller,
                      decoration: InputDecoration(
                        labelText: 'Organizer',
                        hintText: 'Organizer',
                        hintStyle: GoogleFonts.poppins(
                          color: AllColors.lightblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.ten,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors.primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onChanged: (value) {
                        // Handle the text field value changes if needed
                      },
                    ),
                    TextField(
                      controller: date_Controller,
                      decoration: InputDecoration(
                        labelText: 'Select Date',
                        hintText: 'Select Date',
                        hintStyle: GoogleFonts.poppins(
                          color: AllColors.lightblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.ten,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors.primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onTap: () async {
                          DateTime stating_date = new DateTime(1900);
                          DateTime ending_date = new DateTime(2200);
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: stating_date,
                              lastDate: ending_date,
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: AllColors.primaryDark1, // Header background color
                                    //accentColor: AllColors.primaryDark1, // Color of the buttons
                                    colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                                    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                                  ),
                                  child: child!,
                                );
                              });
                          var outputFormat = DateFormat('yyyy-MM-dd');
                          if (date != null && date != "")
                            date_Controller.text= outputFormat.format(date);
                          else
                            date_Controller.text = "";
                      },
                      onChanged: (value) {
                        // Handle the text field value changes if needed
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.primaryDark,
                                      width: 1),
                                ),
                                backgroundColor: AllColors.whiteColor,
                                foregroundColor: AllColors.lightgreyColor),
                            onPressed: () {
                              Get.back();
                              getOnlineInspection(pageNumber,'');
                            },
                            child: Text(
                              'Submit',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.redColor, width: 1),
                                ),
                                backgroundColor: AllColors.whiteColor,
                                foregroundColor: AllColors.lightgreyColor),
                            onPressed: () {
                              Get.back();
                              planting_no_Controller.clear();
                              prod_center_loc_Controller.clear();
                              season_Controller.clear();
                              orgnizer_Controller.clear();
                              date_Controller.clear();
                            },
                            child: Text(
                              'Reset',
                              style: GoogleFonts.poppins(
                                  color: AllColors.redColor,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
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





