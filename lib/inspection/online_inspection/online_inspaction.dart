import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../components/back_button.dart';
import '../../../components/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../models/online_inspection_model/OnlineInspectionResponse.dart';
import '../../../resourse/routes/routes_name.dart';
import '../../../view_model/online_inspection_vm/OnlineInspectionVieModel.dart';
class OnlineInspaction extends StatelessWidget {
  OnlineInspaction({super.key});
  Size size = Get.size;
  final OnlineInspectionViewModel onlinepageController = Get.put(OnlineInspectionViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(onlinepageController.selectedItems!=null && onlinepageController.selectedItems.length>0){
            onlinepageController.selectedItems.clear();
            onlinepageController.showFilterBottomSheet(context);
          }
          else{
            onlinepageController.showFilterBottomSheet(context);
          }
        },
        child: Icon(Icons.filter_alt_sharp, color: AllColors.whiteColor,),
        backgroundColor: AllColors.primaryDark1,),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
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
                           // Get.back();
                            Get.offAllNamed(RoutesName.homeScreen);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Container(
                        child: Text(
                          "Online Inspection",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Obx(() => Visibility(
                      visible: onlinepageController.isAnyCheckboxSelected,
                      child: ActionChip(
                        elevation: 1,
                        tooltip: "Lot Move To Offline",
                        backgroundColor: AllColors.grayColor,
                        avatar: Icon(Icons.send,
                            color: AllColors.primaryDark1),
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: AllColors.primaryDark1)),
                        label: Text('Offline',
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600,
                            )),
                        onPressed: () {
                          _showFullScreenDialog(context);
                        },
                      ),
                    )),
                  ],
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: onlinepageController.loading.value,
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
    ScrollController _scrollController = ScrollController();
    _scrollController!.addListener(() {
      try {
        if (_scrollController!.position.pixels ==
            _scrollController!.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (onlinepageController.total_rows / onlinepageController.rowsPerPage).toInt();
          if ((onlinepageController.total_rows % onlinepageController.rowsPerPage) > 0)
            total_page += 1;

          print(
              "last index ${onlinepageController.pageNumber} ${onlinepageController.total_rows} ${onlinepageController.rowsPerPage} ${total_page}");

          if (onlinepageController.pageNumber + 1 != total_page) {
            onlinepageController.getOnlineInspection(onlinepageController.pageNumber + 1,"");
            onlinepageController.pageNumber += 1;
          }
        }
      }catch(e){
        print('Exception: '+e.toString());
      }
    });
    if (onlinepageController.onlineInspectionList!=null && onlinepageController.onlineInspectionList.length > 0) {
      return  Expanded(
          child: ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: .05, color: AllColors.primaryDark1,);
            },
            itemCount: onlinepageController.onlineInspectionList.length,
            itemBuilder: (BuildContext context, int index) {
              var item = onlinepageController.onlineInspectionList[index];
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

  Widget BindPendingListView(BuildContext context, int index, OnlineinspectionResponse data) {
      return ListTile(
        title: Text("Planting No. :   ${data.plantingNo}",
            // Replace with the actual field from your data model
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w700)),
        subtitle: InkWell(
          onTap: (){
            onlinepageController.selected_code.value=data.plantingNo.toString();
            onlinepageController.selected_lot.value=data.productionLotNo.toString();
            onlinepageController.getProductionLotDataFromServer(data.plantingNo!,data.productionLotNo!);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Prod. Lot No. :   ${data.productionLotNo}",
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
        ),
        trailing: Obx(() {
          return Checkbox(
            value: onlinepageController.checkBoxValues[index] ?? false,
            activeColor: AllColors.primaryDark1,
            onChanged: (bool? value) {
              onlinepageController.toggleCheckbox(index);
              //onlinepageController.updateSelectedIndexes();
            },
          );
        }),
      );

  }
  void _showFullScreenDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // Set the content of the dialog
          child: Container(
            // Set the dimensions of the dialog
            height: size.height * 0.6,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("View List  ",
                    // Replace with the actual field from your data model
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700)),
                Divider(height: 2,thickness: 1,color: AllColors.primaryDark1),

                Center(
                  child: Text(
                    'Select List :  ${onlinepageController.selectedItems.length.toString()}',
                    style:  GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.eighteen,
                        fontWeight: FontWeight.w700),
                  ),
                ),

                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(height: 3, thickness: 1,color: AllColors.primaryDark1,);
                    },
                    itemCount: onlinepageController.selectedItems.length,
                    itemBuilder: (context, index) {
                      print('index..'+index.toString());
                      return ListTile(title:Padding(padding: EdgeInsets.only(top: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Planting No. :  ${onlinepageController.selectedItems[index].plantingNo}',
                                style:  GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w700),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Prod. Lot No. :  ${onlinepageController.selectedItems[index].productionLotNo}',
                                  style:  GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ]),
                      ),);
                    },

                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1), // Set your desired color
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onlinepageController.movetoOffline();
                        // Close the dialog
                      },
                      child: Text('Ok',style: GoogleFonts.poppins(
                          color: AllColors.customDarkerWhite,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w700),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1)) ,
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Remove unchecked items from selectedItems list
                        onlinepageController.selectedItems.removeWhere((item) =>
                        onlinepageController.checkBoxValues.values.contains(true));

                        // Remove checked items from selectedItems list
                        /*onlinepageController.selectedItems.removeWhere((item) =>
                        onlinepageController.checkBoxValues[onlinepageController.selectedItems.indexOf(item)] == false);*/
                        onlinepageController. checkBoxValues.clear();


                        // Close the dialog
                      },
                      child: Text('Cancel',style:GoogleFonts.poppins(
                          color: AllColors.customDarkerWhite,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w700)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showFullScreenDialog(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      return SimpleDialog(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              padding: EdgeInsets.only(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 0.10),
                  ),
                ],
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: SizedBox(
                        height: size.height * 0.05,
                        child: CircleBackButton(
                          press: () {
                            Get.back();
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      "Filter",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Adjust cross-axis alignment
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Checkbox(
                        activeColor: AllColors.primaryDark1,
                        value: onlinepageController.isLocationChecked.value,
                        onChanged: (value) {
                          onlinepageController.onLocationChanged(value ?? false);
                          // pageController.onCheckboxChanged(pageController.isLocationChecked.value);
                          onlinepageController.isLocationChecked.value = value ?? false;
                        },
                      );
                    }),
                    SizedBox(width: 5), // Add some spacing
                    Text('Location', style: TextStyle(color: AllColors.primaryDark1, fontSize: 15)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return Radio(
                        value: 0,
                        activeColor: AllColors.primaryDark1,
                        groupValue: onlinepageController.selectedRadio.value,
                        onChanged: (value) {
                          onlinepageController.setSelectedRadio(value!);
                        },
                      );
                    }),
                    Text('All Lot',
                        style: TextStyle(
                            color: AllColors.primaryDark1, fontSize: 15)),
                    Obx(() {
                      return Radio(
                        value: 1,
                        activeColor: AllColors.primaryDark1,
                        groupValue: onlinepageController.selectedRadio.value,
                        onChanged: (value) {
                          onlinepageController.setSelectedRadio(value!);
                        },
                      );
                    }),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * 0.09),
                      child: Text('My Self',
                          style: TextStyle(
                              color: AllColors.primaryDark1, fontSize: 15)),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Planting No.',
                      labelStyle: TextStyle(
                          color: AllColors.primaryDark1, fontSize: 15),
                      hintText: 'Planting No.',
                      hintStyle: TextStyle(color: AllColors.primaryDark1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AllColors
                              .primaryDark1, // Set the desired border color here
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      // Handle the text field value changes if needed
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Production Center Loc',
                      labelStyle: TextStyle(
                          color: AllColors.primaryDark1, fontSize: 15),
                      hintText: 'Production Center Loc',
                      hintStyle: TextStyle(color: AllColors.primaryDark1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AllColors
                              .primaryDark1, // Set the desired border color here
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      // Handle the text field value changes if needed
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: TextField(
                    controller: onlinepageController.season_Controller,
                    decoration: InputDecoration(
                      labelText: 'Season',
                      labelStyle: TextStyle(
                          color: AllColors.primaryDark1, fontSize: 15),
                      hintText: 'Season',
                      hintStyle: TextStyle(color: AllColors.primaryDark1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AllColors
                              .primaryDark1, // Set the desired border color here
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      // Handle the text field value changes if needed
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Organizer',
                      labelStyle: TextStyle(
                          color: AllColors.primaryDark1, fontSize: 15),
                      hintText: 'Organizer',
                      hintStyle: TextStyle(color: AllColors.primaryDark1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AllColors
                              .primaryDark1, // Set the desired border color here
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      // Handle the text field value changes if needed
                    },
                  ),
                ),
                Center(
                  child: Obx(() {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                      child: DefaultButton(
                        text: "Submit",
                        press: () {
                          Navigator.of(context).pop();
                          onlinepageController.getOnlineInspection(onlinepageController.pageNumber,'');
                        },
                        loading: onlinepageController.loading.value,
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ],
      );
    },
    );
  }


}






