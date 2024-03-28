import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../components/back_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../models/online_inspection_model/OfflineInspectionResponse.dart';
import '../../../resourse/routes/routes_name.dart';
import '../../../view_model/offline_inspection_vm/OfflineInspectionViewModel.dart';
class InspectionLotFieldDetailScreen extends StatelessWidget {
  InspectionLotFieldDetailScreen({super.key});
  final OfflineInspectionViewModel inspectinDetailPageController=Get.put(OfflineInspectionViewModel());
  Size size = Get.size;
  Future<bool> onWillPop() async {
    Get.toNamed(RoutesName.offlineInspection);
    return false; // Prevent the default back behavior
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 25),
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 0.55))
              ], color: Colors.white),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: size.height * 0.09,
                      child: CircleBackButton(
                        press: () {
                          Get.back();
                          //inspectinDetailPageController.syncOfflineDataPushToApiAfterThatGetData('');
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Offline Inspection",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon:const  Icon(Icons.view_agenda,color: AllColors.primaryDark1,),
                    tooltip: "View Lot Details",
                    onPressed: () {
                      inspectinDetailPageController.showLotDetailsBottomSheet(context);
                    },
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AllColors.customDarkerWhite,
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1), // Shadow color
                    spreadRadius: 5, // Spread radius
                    blurRadius: 9, // Blur radius
                    offset: Offset(0, 0), // Offset position
                  ),
                ],
                border: Border.all(color: AllColors.primaryliteColor,width: .2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Table(
                      children: [
                        TableRow(
                          children: [
                            Text(
                              'Planting Date : ',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              inspectinDetailPageController.onlineOffline_selected_lot_data.value.plantingDate!,
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text(
                              'Season Name: ',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              inspectinDetailPageController.onlineOffline_selected_lot_data.value.seasonCode!+
                                  '('+inspectinDetailPageController.onlineOffline_selected_lot_data.value.seasonName!+')',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.end,
                            ),

                          ],
                        ),
                        TableRow(
                          children: [
                            Text(
                              'Production Loc.Centre: ',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              inspectinDetailPageController.onlineOffline_selected_lot_data.value.productionCenterLoc!.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text(
                              'Production Lot No.: ',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${inspectinDetailPageController.onlineOffline_selected_lot_data.value.productionLotNo}',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),),

            Divider(height: .5, color: AllColors.primaryDark1,),
            //BindInputFields(context),
            Obx(() {
              if (inspectinDetailPageController
                  .online_offline_selected_inspection
                  .value
                  .inspectionTypeName ==
                  null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      'No Record Found.',
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                );
              }
              return BindInputFields(context);
            }),
            Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    //color: AllColors.customDarkerWhite, // Replace with your desired background color
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: .5),
                    child: Obx((){
                      return Visibility(
                        visible:inspectinDetailPageController.online_offline_selected_inspection.value.isDone!>0?false:true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                inspectinDetailPageController.completeOnlineInspection();
                              },
                              child: Text('Complete',style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700
                              ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {

                              },
                              child: Text('Reset',style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700
                              ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  //todo get inspection lot details field...............................
  Widget BindInputFields(context) {
    return  Expanded(
      child: ListView.builder(
        //controller: inspectinDetailPageController.scrollController,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: (inspectinDetailPageController.online_offline_selected_inspection.value.inspectionTypeName == null)
              ? 0 : inspectinDetailPageController.online_offline_selected_inspection.value.fields!.length,
          itemBuilder: (BuildContext context, int index) {
            return  getInspectionLotDetailfields(context, index);
          }),
    );
  }

  Widget getInspectionLotDetailfields(BuildContext context,int position){
    String field_type=inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldType!.toString();
    int is_done=inspectinDetailPageController.online_offline_selected_inspection.value.isDone!;
    print(field_type);
    Widget ?my_dynamic_ui=null;
    switch(field_type){
      case 'String':{
        my_dynamic_ui=EditTextUiTypeText(position,is_done);
        break;
      }
      case 'Numeric':{
        my_dynamic_ui=EditTextUiTypeNumber(position,is_done);
        break;
      }
      case 'Date':{
        my_dynamic_ui=DatePickerUi(context,position,is_done);
        break;
      }

      case 'Option':{
        my_dynamic_ui=DropDownUi(context,position,is_done);
        break;
      }

      case 'File':
        {
          my_dynamic_ui = BindFileUi(context, position, is_done);
          break;
        }
      default:{
        my_dynamic_ui=Text('No Flag Found.');
      }
    }
    return my_dynamic_ui;
  }

  /*Future<void> setMapPriviousFilterValue(TextEditingController edit_text_controller,int position) async{
    String selected_map_type= inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].mapInspectionType??'';
    String map_field_name=inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].mapInspectionFieldName??'';
    String map_field_value=inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue??'';
    if(inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].isMap!>0 && selected_map_type!="planting_line" && (map_field_value=='' || map_field_value==null)){

      List<Fields>? field_list_data=inspectinDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail!.firstWhere((element) => element.inspectionTypeName==selected_map_type! ).fields;
      map_field_value= field_list_data!.firstWhere((element) => element.fieldName==map_field_name!).fieldValue!;
      inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue=map_field_value;
    }else{
      map_field_value=inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue??'';
    }
    edit_text_controller.text=map_field_value;
  }*/
  Future<void> setMapPriviousFilterValue(
      TextEditingController? edit_text_controller, int position) async {
    String selected_map_type = inspectinDetailPageController
        .online_offline_selected_inspection
        .value
        .fields![position]
        .mapInspectionType ??
        '';
    String map_field_name = inspectinDetailPageController
        .online_offline_selected_inspection
        .value
        .fields![position]
        .mapInspectionFieldName ??
        '';
    String map_field_value = inspectinDetailPageController
        .online_offline_selected_inspection
        .value
        .fields![position]
        .fieldValue ??
        '';
    if (inspectinDetailPageController.online_offline_selected_inspection.value
        .fields![position].isMap! >
        0 &&
        selected_map_type != "planting_line" &&
        (map_field_value == '' || map_field_value == null)) {
      List<Fields>? field_list_data = inspectinDetailPageController
          .onlineOffline_selected_lot_data.value.inspectionDetail!
          .firstWhere(
              (element) => element.inspectionTypeName == selected_map_type!)
          .fields;
      map_field_value = field_list_data!
          .firstWhere((element) => element.fieldName == map_field_name!)
          .fieldValue!;
      inspectinDetailPageController.online_offline_selected_inspection.value
          .fields![position].fieldValue = map_field_value;
    } else {
      map_field_value = inspectinDetailPageController
          .online_offline_selected_inspection
          .value
          .fields![position]
          .fieldValue ??
          '';
    }
    edit_text_controller!.text = map_field_value;
  }

 /* //todo for return edit text type string layout...................
  Widget EditTextUiTypeText(int position,int is_read_value){
    var edit_text_controller=TextEditingController();
    setMapPriviousFilterValue(edit_text_controller,position);

    //edit_text_controller.text=inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue??'';
    return  Padding(
      padding: const EdgeInsets.only(left: 8,right: 8),
      child: TextFormField(
        controller: edit_text_controller,
        keyboardType: TextInputType.text,
        readOnly:inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].isReadOnly!>0 || is_read_value>0?true:false
        ,
        onChanged: (value) {
          inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue=value;
          edit_text_controller.text=value;
        },
        decoration: InputDecoration(
          hintText: inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldName!,
          labelText:  inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldName!,
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
      ),
    );
  }

  //todo for return edit text type number layout...................
  Widget EditTextUiTypeNumber(int position,int is_read_value){

    var edit_text_controller=TextEditingController();
    setMapPriviousFilterValue(edit_text_controller,position);
   // edit_text_controller.text=inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue??'';
    return  Padding(
      padding: const EdgeInsets.only(left: 8,right: 8),
      child: TextFormField(
        controller: edit_text_controller,
        keyboardType: TextInputType.number,
        readOnly:inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].isReadOnly!>0 || is_read_value>0?true:false
        ,
        onChanged: (value) {
          inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue=value;
          edit_text_controller.text=value;
          print(inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue);
        },
        decoration: InputDecoration(
          hintText: inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldName!,
          labelText:  inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldName!,
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
      ),
    );
  }

  //todo for return date field layout................
  Widget DatePickerUi(BuildContext context,int position,int is_done_value) {
   var  edit_text_controller=TextEditingController();
    setMapPriviousFilterValue(edit_text_controller,position);
    // edit_text_controller.text=inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue??'';

    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8),
      child: TextFormField(
        controller: edit_text_controller,
          readOnly:inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].isReadOnly!>0 || is_done_value>0?true:false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.one),
          hintText: inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldName!,
          labelText:  inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldName!,
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.sisxteen),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
        ),
        cursorColor: AllColors.primaryDark1,
        onTap: () async {
          if(is_done_value<=0){
            DateTime stating_date = new DateTime(1900);
            DateTime ending_date = new DateTime(2200);
            FocusScope.of(context).requestFocus(new FocusNode());
            DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: stating_date,
                lastDate: ending_date);
            var outputFormat = DateFormat('yyyy-MM-dd');
            if (date != null && date != "")
              inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue=
                  outputFormat.format(date);
            else
              inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue = "";

            print( 'date:'+inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue!);
            edit_text_controller.text= inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue!;
            print( 'date1:'+ edit_text_controller.text);
          }
        },
      ),
    );
  }*/

  //todo for return edit text type string layout...................
  Widget EditTextUiTypeText(int position, int is_read_value) {
    if (inspectinDetailPageController.online_offline_selected_inspection.value
        .fields![position].edit_text_field ==
        null)
      inspectinDetailPageController.online_offline_selected_inspection.value
          .fields![position].edit_text_field = TextEditingController();

    setMapPriviousFilterValue(
        inspectinDetailPageController.online_offline_selected_inspection.value
            .fields![position].edit_text_field,
        position);

    //edit_text_controller.text=inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue??'';
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: TextFormField(
        controller: inspectinDetailPageController
            .online_offline_selected_inspection
            .value
            .fields![position]
            .edit_text_field,
        keyboardType: TextInputType.text,
        readOnly: inspectinDetailPageController
            .online_offline_selected_inspection
            .value
            .fields![position]
            .isReadOnly! >
            0 ||
            is_read_value > 0
            ? true
            : false,
        onChanged: (value) {
          inspectinDetailPageController.online_offline_selected_inspection.value
              .fields![position].fieldValue = value;
          inspectinDetailPageController.online_offline_selected_inspection.value
              .fields![position].edit_text_field!.text = value;
        },
        decoration: InputDecoration(
          hintText: inspectinDetailPageController
              .online_offline_selected_inspection
              .value
              .fields![position]
              .fieldName!,
          labelText: inspectinDetailPageController
              .online_offline_selected_inspection
              .value
              .fields![position]
              .fieldName!,
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
      ),
    );
  }

  //todo for return edit text type number layout...................aaa a
  Widget EditTextUiTypeNumber(int position, int is_read_value) {
    if (inspectinDetailPageController.online_offline_selected_inspection.value
        .fields![position].edit_text_field ==
        null)
      inspectinDetailPageController.online_offline_selected_inspection.value
          .fields![position].edit_text_field = TextEditingController();

    setMapPriviousFilterValue(
        inspectinDetailPageController.online_offline_selected_inspection.value
            .fields![position].edit_text_field,
        position);
    // edit_text_controller.text=inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue??'';
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: TextFormField(
        controller: inspectinDetailPageController
            .online_offline_selected_inspection
            .value
            .fields![position]
            .edit_text_field,
        keyboardType: TextInputType.number,
        readOnly: inspectinDetailPageController
            .online_offline_selected_inspection
            .value
            .fields![position]
            .isReadOnly! >
            0 ||
            is_read_value > 0
            ? true
            : false,
        onChanged: (value) {
          inspectinDetailPageController.online_offline_selected_inspection.value
              .fields![position].fieldValue = value;
          inspectinDetailPageController.online_offline_selected_inspection.value
              .fields![position].edit_text_field!.text = value;
          inspectinDetailPageController.getFormulaExpressionValues();
        },
        decoration: InputDecoration(
          hintText: inspectinDetailPageController
              .online_offline_selected_inspection
              .value
              .fields![position]
              .fieldName!,
          labelText: inspectinDetailPageController
              .online_offline_selected_inspection
              .value
              .fields![position]
              .fieldName!,
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
      ),
    );
  }

  //todo for return date field layout................
  Widget DatePickerUi(BuildContext context, int position, int is_done_value) {
    if (inspectinDetailPageController.online_offline_selected_inspection.value
        .fields![position].edit_text_field ==
        null)
      inspectinDetailPageController.online_offline_selected_inspection.value
          .fields![position].edit_text_field = TextEditingController();

    setMapPriviousFilterValue(
        inspectinDetailPageController.online_offline_selected_inspection.value
            .fields![position].edit_text_field,
        position);
    // edit_text_controller.text=inspectinDetailPageController.online_offline_selected_inspection.value.fields![position].fieldValue??'';

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: TextFormField(
        controller: inspectinDetailPageController
            .online_offline_selected_inspection
            .value
            .fields![position]
            .edit_text_field,
        readOnly: inspectinDetailPageController
            .online_offline_selected_inspection
            .value
            .fields![position]
            .isReadOnly! >
            0 ||
            is_done_value > 0
            ? true
            : false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.one),
          hintText: inspectinDetailPageController
              .online_offline_selected_inspection
              .value
              .fields![position]
              .fieldName!,
          labelText: inspectinDetailPageController
              .online_offline_selected_inspection
              .value
              .fields![position]
              .fieldName!,
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.ten),
          labelStyle: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.sisxteen),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: AllColors.primaryDark1), // Change the color to green
          ),
        ),
        cursorColor: AllColors.primaryDark1,
        onTap: () async {
          if (is_done_value <= 0) {
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
              inspectinDetailPageController
                  .online_offline_selected_inspection
                  .value
                  .fields![position]
                  .fieldValue = outputFormat.format(date);
            else
              inspectinDetailPageController.online_offline_selected_inspection
                  .value.fields![position].fieldValue = "";

            print('date:' +
                inspectinDetailPageController.online_offline_selected_inspection
                    .value.fields![position].fieldValue!);
            inspectinDetailPageController.online_offline_selected_inspection
                .value.fields![position].edit_text_field!.text =
            inspectinDetailPageController.online_offline_selected_inspection
                .value.fields![position].fieldValue!;
            print('date1:' +
                inspectinDetailPageController.online_offline_selected_inspection
                    .value.fields![position].edit_text_field!.text);
          }
        },
      ),
    );
  }

  //todo for drop down field layout.................
  Widget DropDownUi(BuildContext context, int position, int is_read_value) {
    String dropdown_json_string = inspectinDetailPageController
        .online_offline_selected_inspection
        .value
        .fields![position]
        .fieldOptionValue ??
        '';
    final jsonResponse = json.decode(dropdown_json_string);
    List<String> dropdownListData = [];
    if (jsonResponse is List) {
      dropdownListData = jsonResponse.cast<String>().toList();
    }
    if (inspectinDetailPageController.online_offline_selected_inspection.value
        .fields![position].edit_text_field ==
        null)
      inspectinDetailPageController.online_offline_selected_inspection.value
          .fields![position].edit_text_field = TextEditingController();

    setMapPriviousFilterValue(
        inspectinDetailPageController.online_offline_selected_inspection.value
            .fields![position].edit_text_field,
        position);
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: size.width*.96,
      child: DropdownMenu<String>(
        width: size.width * .96,
        controller: inspectinDetailPageController
            .online_offline_selected_inspection
            .value
            .fields![position]
            .edit_text_field,
        label: Text(
          'Select Menu',
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          //hintStyle:TextStyle(color: ),
          //labelStyle: TextStyle(color: AllColors.primaryDark1,fontSize: AllFontSize.sisxteen,fontWeight: FontWeight.w700),
          filled: false,
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
        ),
        enabled: inspectinDetailPageController
            .online_offline_selected_inspection
            .value
            .fields![position]
            .isReadOnly! >
            0 ||
            is_read_value > 0
            ? false
            : true,
        onSelected: (String? value) {
          inspectinDetailPageController.online_offline_selected_inspection.value
              .fields![position].fieldValue = value;
          inspectinDetailPageController.online_offline_selected_inspection.value
              .fields![position].edit_text_field!.text = value!;
        },
        dropdownMenuEntries:
        dropdownListData.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e);
        }).toList(),
      ),
    );
  }

  Widget BindFileUi(BuildContext context, int position, int is_done) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(

        children: [
          GestureDetector(
            onTap: (){
              if(inspectinDetailPageController.online_offline_selected_inspection.value.isDone!<=0){
                inspectinDetailPageController.captureImage(position);
              }
            },
            child: DottedBorder(
              color: Colors.grey,
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              dashPattern: [10, 5, 10, 5],
              child: Container(
                width: size.width,
                height: size.height * 0.22,
                child:  inspectinDetailPageController
                    .online_offline_selected_inspection
                    .value
                    .fields![position]
                    .fieldValue!=null &&  inspectinDetailPageController
                    .online_offline_selected_inspection
                    .value
                    .fields![position]
                    .fieldValue!=""
                    ? ClipRRect(
                  borderRadius:
                  BorderRadius
                      .circular(20.0),
                  child: kIsWeb
                      ? Image.memory(
                    StaticMethod.stringToDecodeBase64(inspectinDetailPageController
                        .online_offline_selected_inspection
                        .value
                        .fields![position]
                        .fieldValue!)!,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return Image.asset('assets/images/no_file.png'); // Replace 'default_image.png' with your default image asset path
                    },// Use BoxFit.cover to make the image fit
                  ) : Image.memory(
                    base64.decode(inspectinDetailPageController
                        .online_offline_selected_inspection
                        .value
                        .fields![position]
                        .fieldValue!),
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return Image.asset('assets/images/no_file.png'); // Replace 'default_image.png' with your default image asset path
                    },// Use BoxFit.cover to make the image fit
                  ),
                ) : Icon(
                  Icons.camera,
                  size: size.height * 0.16,
                  color: AllColors.primaryDark1,
                ),
              ),
            ),
          ),
          //Spacer(),
          SizedBox(height: 6,),

          Text(
            inspectinDetailPageController
                .online_offline_selected_inspection
                .value
                .fields![position]
                .fieldName!,
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

}
