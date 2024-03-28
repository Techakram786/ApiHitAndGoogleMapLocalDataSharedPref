import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import 'package:pristine_seeds/utils/app_utils.dart';
import '../../../components/back_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../view_model/online_inspection_vm/OnlineInspectionVieModel.dart';

class OnlineLotDetailScreen extends StatelessWidget{
  OnlineLotDetailScreen({super.key});
  final OnlineInspectionViewModel lotDetailPageController = Get.put(OnlineInspectionViewModel());
  Size size=Get.size;
  Future<bool> onWillPop() async {
    lotDetailPageController.getOnlineInspection(lotDetailPageController.pageNumber,'OnLineLotDetail');
    return false; // Prevent the default back behavior
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body:  Container(
            width: double.infinity,
            height: size.height,

            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 10, right: 10, bottom: 0, top: 25),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 0.55),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: size.height * 0.09,
                          child: CircleBackButton(
                            press: () {
                              //Get.back();
                              lotDetailPageController.getOnlineInspection(lotDetailPageController.pageNumber,'OnLineLotDetail');
                             // lotDetailPageController.syncOfflineDataPushToApiAfterThatGetData('lot_detail_page');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                          child: Text(
                            lotDetailPageController.onlineOffline_selected_lot_data.value!=null && lotDetailPageController.onlineOffline_selected_lot_data.value.productionLotNo!=null?"Online Lot ("+lotDetailPageController.onlineOffline_selected_lot_data.value.productionLotNo!+")":'',
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return Visibility(
                    visible: lotDetailPageController.loading.value,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.primaryliteColor,
                    ),
                  );
                }),
                Container(
                  child:BindLotDetails(context) ,
                )
              ],
            )),
      ),
    );
  }

  Widget BindLotDetails(context) {

    if (lotDetailPageController.onlineOffline_selected_lot_data.value!=null && lotDetailPageController.onlineOffline_selected_lot_data.value.productionLotNo!=null) {

      return  Expanded(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:Column(children: [
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
                                'Code: ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lotDetailPageController.onlineOffline_selected_lot_data.value.code!,
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
                                'Organizer Name: ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Tooltip(
                                message: lotDetailPageController.onlineOffline_selected_lot_data.value.organizerName!,
                                child: Container(
                                  width: size.width*.5,
                                  child: Text(
                                    lotDetailPageController.onlineOffline_selected_lot_data.value.organizerName!,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryliteColor,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              )
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                'Season: ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lotDetailPageController.onlineOffline_selected_lot_data.value.seasonCode!+'('+ lotDetailPageController.onlineOffline_selected_lot_data.value.seasonName!+')',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryliteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.end,
                              )
                            ],),
                          TableRow(
                            children: [
                              Text(
                                'Production Loc. Centre: ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lotDetailPageController.onlineOffline_selected_lot_data.value.productionCenterLoc!,
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryliteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.end,
                              )
                            ],),
                          TableRow(
                            children: [
                              Text(
                                'Planting Date: ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lotDetailPageController.onlineOffline_selected_lot_data.value.plantingDate!,
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryliteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.end,
                              )
                            ],),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: DynamicChip(context),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0,right:8.0,top: 8.0),
                child: Status(context),
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
                                'Production Lot No. : ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lotDetailPageController.onlineOffline_selected_lot_data.value.productionLotNo!,
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
                                'Planting Line No. : ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lotDetailPageController.onlineOffline_selected_lot_data.value.lineNo.toString()!,
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryliteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.end,
                              )
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                'Grower Name : ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lotDetailPageController.onlineOffline_selected_lot_data.value.growerLandOwnerName.toString(),
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryliteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.end,
                              )
                            ],),
                          TableRow(
                            children: [
                              Text(
                                'Grower State: ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lotDetailPageController.onlineOffline_selected_lot_data.value.growerDetail!.stateName??'',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryliteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.end,
                              )
                            ],),
                          TableRow(
                            children: [
                              Text(
                                'Crop Code : ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lotDetailPageController.onlineOffline_selected_lot_data.value.cropCode!,
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryliteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.end,
                              )
                            ],),
                          TableRow(
                            children: [
                              Text(
                                'Variety Code : ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lotDetailPageController.onlineOffline_selected_lot_data.value.varietyCode!,
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryliteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.end,
                              )
                            ],),
                          TableRow(
                            children: [
                              Text(
                                'Crop Type : ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lotDetailPageController.onlineOffline_selected_lot_data.value.itemCropType.toString(),
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryliteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.end,
                              )
                            ],),
                          TableRow(
                            children: [
                              Text(
                                'Class Of Seeds : ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lotDetailPageController.onlineOffline_selected_lot_data.value.itemClassOfSeeds!,
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryliteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.end,
                              )
                            ],),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
            )
        ),
      );
    } else {
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
  }

  Widget DynamicChip(BuildContext context){
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: List<Widget>.generate(lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail!.length, (int index) {
        return ActionChip(
          elevation: 1,
          tooltip: lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![index].inspectionTypeName!.toString(),
          backgroundColor: lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![index].isDone!>0?AllColors.primaryDark1:AllColors.grayColor,
          //avatar: Icon(Icons.delete, color: AllColors.redColor),
          shape: StadiumBorder(
              side: BorderSide(color: AllColors.primaryDark1)),
          label: Text(lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![index].inspectionTypeName!.toString(),
              style: GoogleFonts.poppins(
                color: lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![index].isDone!>0?AllColors.customDarkerWhite:AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w600,
              )),
          onPressed: () {
            lotDetailPageController.inspection_name.value=lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![index].inspectionTypeName!.toString();

            if(lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![index].isDone!>0 || index==0 || lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![index].isQc!>0){
              lotDetailPageController.online_offline_selected_inspection.value=lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![index];
              lotDetailPageController.getFormulaExpressionValues();
              Get.toNamed(RoutesName.onlineInspectionLotFieldDetailScreen);
            }
            else if( lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![index].isQc!>0 && lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![0].isDone!<=0){
              //lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![index].isQc!>0 &&
              Utils.sanckBarError('Inspection', 'Please Complete Inspection One Before Qc Inspection.');
            }
            else if( lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![index-1].isDone!<1){
              Utils.sanckBarError('Inspection', 'Please Complete Inspection Before It.');
            }else{
              lotDetailPageController.online_offline_selected_inspection.value=lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![index];
              Get.toNamed(RoutesName.onlineInspectionLotFieldDetailScreen);
            }
          },
        );
      }),
    );
  }

  Widget Status(BuildContext context){
    String status_message="";
    for(int i=0;i<lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail!.length;i++){
      if(i==0 && lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![i].isDone!<=0){
        status_message="Pending: " + lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![i].inspectionTypeName.toString();
        break;
      }else {
        if(i+1!=lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail!.length && lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![i].isDone!<=0){
          status_message="Completed: " + lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![i-1].inspectionTypeName.toString();
          break;
        }
        if(i+1==lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail!.length && lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![i].isDone!>0){
          status_message="Completed: " + lotDetailPageController.onlineOffline_selected_lot_data.value.inspectionDetail![i].inspectionTypeName.toString();
          break;
        }

      }
    }

    lotDetailPageController.completed_inspection.value = status_message;

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Lot Details: ',
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700),
        ),
        Container(
          width: size.width*.6,
          child: Text(
            lotDetailPageController.completed_inspection.value,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}