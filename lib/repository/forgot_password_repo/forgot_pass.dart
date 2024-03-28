import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

import '../../network_data/network/network_api_service.dart';
import '../../resourse/appUrl/app_url.dart';

class ForgotPasswordRepository{
  final _apiService=NetworkApiServices();
  Future<String> forgotPassApiHit(var data,SessionManagement sessionManagement) async{
    return _apiService.postApi(data, AppUrl.forgot_pass_url,sessionManagement);
  }
}