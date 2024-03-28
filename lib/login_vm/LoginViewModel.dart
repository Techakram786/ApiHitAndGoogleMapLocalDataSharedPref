import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pristine_seeds/models/loginModel/login_model.dart';
import 'package:pristine_seeds/repository/login_repository/login_repository.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import 'package:pristine_seeds/utils/app_utils.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';


class LoginViewModel extends GetxController{
  final _api=LoginRepository();
  final emailController =TextEditingController().obs;
  final passController =TextEditingController().obs;

  final emailFocusNode=FocusNode().obs;
  final passFocusNode=FocusNode().obs;

  RxBool loading=false.obs;

  SessionManagement sessionManagement=SessionManagement();

  Future<void> loginApi() async{
    loading.value=true;
    Map data={
      'email':emailController.value.text,
      'password':passController.value.text,
      'rememberMe':'',
    };
    await _api.loginApiHit(data,sessionManagement).then((value){
      try{
        List<LoginResponse> loginResponse=(json.decode(value) as List).map((i) =>
            LoginResponse.fromJson(i)).toList();
        if (loginResponse[0].condition.toString() == "True") {
          if(loginResponse[0].isHo=='1'){
            sessionManagement.clearSession();
            Get.toNamed(RoutesName.loginScreen);
            Utils.sanckBarError(
                'Message !', "Cluster User Can Not Access Mobile Application.");
            return;
          }
            sessionManagement.setEmail(loginResponse[0].email.toString()).then((_) {
            sessionManagement.setName(loginResponse[0].name.toString());
            sessionManagement.setPhoneNo(loginResponse[0].phoneNo.toString());
            sessionManagement.setEmployeeId(loginResponse[0].employee_id_auto_genrated.toString());
            sessionManagement.setCompanyId(loginResponse[0].company_id.toString());
            sessionManagement.setIsHo(loginResponse[0].isHo.toString());
            sessionManagement.setRoleName(loginResponse[0].roleName.toString());
            sessionManagement.setProfile(loginResponse[0].profile.toString());
            sessionManagement.setMenuList(loginResponse[0].menu ?? []); // Store the menu list

            Get.offAllNamed(RoutesName.homeScreen);
          });

        } else {
          Utils.sanckBarError('Message', loginResponse[0].message.toString());
        }
      }catch(e){
        Utils.sanckBarException('Exception', e.toString());
      }finally{
        loading.value=false;
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      //print(stackTrace);
        Utils.sanckBarError('Api Exception onError', error.toString());
    });
  }

  /*void notificationonios(){
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          actionType: ActionType.Default,
          title: 'Hello World!',
          body: 'This is my first notification!',
        )
    );
  }*/
}