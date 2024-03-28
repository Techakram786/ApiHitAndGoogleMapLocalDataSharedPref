import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import 'package:pristine_seeds/view_model/offline_inspection_vm/OfflineInspectionViewModel.dart';
import '../../../components/back_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../models/online_inspection_model/OfflineInspectionResponse.dart';


class OfflineInspection extends StatelessWidget{
  OfflineInspection({super.key});
  final OfflineInspectionViewModel offlinePageController=Get.put(OfflineInspectionViewModel());
   Size size=Get.size;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
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
                           Get.offAllNamed(RoutesName.homeScreen);
                           //Get.back();
                         },
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left: 4.0),
                     child: Container(
                       child: Text(
                         "Offline Inspection",
                         style: GoogleFonts.poppins(
                           color: AllColors.primaryDark1,
                           fontSize: 20,
                           fontWeight: FontWeight.w700,
                         ),
                       ),
                     ),
                   ),
                   Spacer(),
                   IconButton(
                     icon:const  Icon(Icons.refresh,color: AllColors.primaryDark1),
                     tooltip: "Refresh List Data",
                     onPressed: () {
                       offlinePageController.syncOfflineDataPushToApiAfterThatGetData('');
                     },
                   ),
                   IconButton(
                     icon:const  Icon(Icons.near_me,color: AllColors.primaryDark1,),
                     tooltip: "Move To Online",
                     onPressed: () {
                       offlinePageController.moveToOnlineAllOfflineData();
                     },
                   ),
                 ],
               ),
             ),
             Obx(() {
               return Visibility(
                 visible: offlinePageController.loading.value,
                 child: LinearProgressIndicator(
                   backgroundColor: AllColors.primaryDark1,
                   color: AllColors.primaryliteColor,
                 ),
               );
             }),
             Container(
               child:Obx(() =>BindPagginationListView(context)) ,
             )
           ],
         )),
   );
  }

  Widget BindPagginationListView(context) {
    if (offlinePageController.onlineOfflineList!=null && offlinePageController.onlineOfflineList.length > 0) {

      return  Expanded(
          child: ListView.separated(
           // controller: offlinePageController.scrollController,
            padding: EdgeInsets.zero,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: .05, color: AllColors.primaryDark1,);
            },
            itemCount: offlinePageController.onlineOfflineList.length,
            itemBuilder: (BuildContext context, int index) {
              var item = offlinePageController.onlineOfflineList[index];
              return BindPendingListView(context, index,item);
            },
          ));
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
  Widget BindPendingListView(BuildContext context, int index, OfflineInspectionResponse data) {
    return InkWell(
      onTap: (){
        offlinePageController.selected_code.value=data.code.toString();
        offlinePageController.selected_lot.value=data.productionLotNo.toString();
        offlinePageController.getProductionLotDataFromTable(data.code!,data.productionLotNo!);
      },
      child: ListTile(
        title: Text("Planting No :   ${data.code}",
            // Replace with the actual field from your data model
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w700)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Prod. Lot No :   ${data.productionLotNo}",
                // Replace with the actual field from your data model
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w600,
                  fontSize: AllFontSize.twelve,
                )),
            Text("Season Code :   ${data.seasonCode}",
                // Replace with the actual field from your data model
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w600,
                  fontSize: AllFontSize.twelve,
                )),
            Text("Season Name :   ${data.seasonName}",
                // Replace with the actual field from your data model
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w600,
                  fontSize: AllFontSize.twelve,
                )),
            Text("Grower Name :   ${data.growerLandOwnerName}",
                // Replace with the actual field from your data model
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w600,
                  fontSize: AllFontSize.twelve,
                )),
            Text("Organizer :   ${data.organizerName}",
                // Replace with the actual field from your data model
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w600,
                  fontSize: AllFontSize.twelve,
                )),
            Text("Organizer Code :   ${data.organizerCode}",
                // Replace with the actual field from your data model
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w600,
                  fontSize: AllFontSize.twelve,
                )),
          ],
        ),
        trailing: (data.isOffline==null || data.isOffline==0)?Icon(Icons.done_all,color: AllColors.primaryDark1,):Icon(Icons.error_outline),
      ),
    );
  }

}


